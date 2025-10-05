#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] [feature_context]"
    exit 0
}

$FEATURE_INPUT = $Args -join ' '

# Function to find the repository root
function Find-RepoRoot {
    param([string]$dir)

    while ($dir -ne "/") {
        if (Test-Path "$dir/.git" -or Test-Path "$dir/.specify") {
            return $dir
        }
        $dir = Split-Path $dir -Parent
    }
    return $null
}

# Resolve repository root
$SCRIPT_DIR = Split-Path $PSScriptRoot -Parent

if (git rev-parse --show-toplevel 2>$null) {
    $REPO_ROOT = git rev-parse --show-toplevel
    $HAS_GIT = $true
} else {
    $REPO_ROOT = Find-RepoRoot $SCRIPT_DIR
    if ([string]::IsNullOrEmpty($REPO_ROOT)) {
        Write-Host "Error: Could not determine repository root. Please run this script from within the repository." -ForegroundColor Red
        exit 1
    }
    $HAS_GIT = $false
}

Set-Location $REPO_ROOT

# Get current branch
$CURRENT_BRANCH = "unknown"
if ($HAS_GIT) {
    try {
        $CURRENT_BRANCH = git rev-parse --abbrev-ref HEAD 2>$null
        if ([string]::IsNullOrEmpty($CURRENT_BRANCH)) {
            $CURRENT_BRANCH = "unknown"
        }
    } catch {
        $CURRENT_BRANCH = "unknown"
    }
}

# Determine feature context
$FEATURE_NAME = ""
$FEATURE_DIR = ""

# Check if we're in a feature directory
if ($PWD -like "*/features/*") {
    $CURRENT_DIR = Split-Path $PWD -Leaf
    if ($CURRENT_DIR -ne "features") {
        $FEATURE_NAME = $CURRENT_DIR
        $FEATURE_DIR = $PWD
    }
}

# If no feature detected, try to find feature from input
if ([string]::IsNullOrEmpty($FEATURE_NAME) -and -not [string]::IsNullOrEmpty($FEATURE_INPUT)) {
    # Try to extract feature name from input
    $FEATURE_NAME = ($FEATURE_INPUT | Select-Object -First 30).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
    if (Test-Path "$REPO_ROOT/features/$FEATURE_NAME") {
        $FEATURE_DIR = "$REPO_ROOT/features/$FEATURE_NAME"
    }
}

# Create timestamp-based Event Storming directory
$TIMESTAMP = Get-Date -Format "yyyyMMdd-HHmmss"
if (-not [string]::IsNullOrEmpty($FEATURE_NAME)) {
    $EVENT_STORMING_DIR = "$REPO_ROOT/features/$FEATURE_NAME/event-storming-$TIMESTAMP"
    $ANALYSIS_NAME = "feature-$FEATURE_NAME"
} else {
    $EVENT_STORMING_DIR = "$REPO_ROOT/specs/feature-event-storming-$TIMESTAMP"
    $ANALYSIS_NAME = "feature-event-storming"
}

New-Item -ItemType Directory -Force -Path $EVENT_STORMING_DIR | Out-Null

# Create Event Storming output file
$EVENT_STORMING_FILE = "$EVENT_STORMING_DIR/feature-event-storming.drawio"

# Create knowledge directory
$KNOWLEDGE_DIR = "$EVENT_STORMING_DIR/knowledge"
New-Item -ItemType Directory -Force -Path $KNOWLEDGE_DIR | Out-Null

# Create feature Event Storming report file
$FEATURE_REPORT_FILE = "$EVENT_STORMING_DIR/feature-event-storming-report.md"

# Create basic template for feature Event Storming report
@'
# Feature-Level Event Storming Report

**Feature**: [Feature Name]
**Analysis ID**: feature-event-storming-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Feature Context**: [Feature context or current working directory]

## Feature Context

### Feature Overview
**Feature Name**: [Feature Name]
**Feature Scope**: [Clear, concrete scope]
**Business Value**: [Specific value proposition]
**Current Status**: [Specification/Clarification/Planning]

### Feature Requirements
**Concrete Requirements**:
- [Requirement 1]: [Specific, implementable requirement]
- [Requirement 2]: [Specific, implementable requirement]
- [Requirement 3]: [Specific, implementable requirement]

**Business Rules**:
- [Rule 1]: [Specific business rule]
- [Rule 2]: [Specific business rule]

**Validation Logic**:
- [Validation 1]: [Clear validation criteria]
- [Validation 2]: [Clear validation criteria]

### Domain Context
**Bounded Context**: [Relevant bounded context from high-level model]
**Related Aggregates**: [Existing aggregates from high-level model]
**Domain Events**: [Relevant high-level events]
**Business Processes**: [Related business processes]

## Feature Event Storming Results

### Domain Events (Feature-Level)
- **[Event 1 Name]**: [Business significance and triggers]
- **[Event 2 Name]**: [Business significance and triggers]
- **[Event 3 Name]**: [Business significance and triggers]

### Commands and User Interactions
- **[Command 1 Name]**: [User action and business operation]
- **[Command 2 Name]**: [User action and business operation]

### Feature Aggregates and Entities
**Aggregates**:
- **[Aggregate 1 Name]**: [Entities and business rules]
- **[Aggregate 2 Name]**: [Entities and business rules]

**Entities**:
- **[Entity 1 Name]**: [Attributes and responsibilities]
- **[Entity 2 Name]**: [Attributes and responsibilities]

### Feature Business Processes
**Process 1**: [Detailed feature workflow]
- Step 1: [Specific action]
- Step 2: [Specific action]
- Step 3: [Specific action]

**Process 2**: [Detailed feature workflow]
- Step 1: [Specific action]
- Step 2: [Specific action]

### Integration Points
**External Dependencies**:
- [System 1]: [Integration purpose and requirements]
- [System 2]: [Integration purpose and requirements]

**Internal Dependencies**:
- [Feature/Component 1]: [Dependency description]
- [Feature/Component 2]: [Dependency description]

## Implementation Guidance

### Data Model Implications
**New Entities**: [List of new entities]
**Modified Entities**: [List of modified entities]
**Relationships**: [New or modified relationships]

### API and Integration Requirements
**API Endpoints**: [Required API endpoints]
**Data Contracts**: [Data structures and schemas]
**Event Contracts**: [Event structures and payloads]

### Business Rule Implementation
**Validation Logic**: [Implementation approach for validation]
**Business Rules**: [Implementation approach for business rules]
**Error Handling**: [Implementation approach for error handling]

## Big Model Update Recommendations

### New Domain Elements
**New Events**: [Events to add to high-level model]
**New Aggregates**: [Aggregates to add to high-level model]
**New Business Rules**: [Rules to add to high-level model]

### Model Enhancements
**Aggregate Refinements**: [Improvements to existing aggregates]
**Process Refinements**: [Improvements to existing processes]
**Integration Enhancements**: [New integration capabilities]

## Next Steps

### Immediate Actions
1. **Proceed to Planning**: `/plan "feature implementation"`
2. **Update Big Model**: Apply big model update recommendations
3. **Implementation**: Begin feature implementation with domain model guidance

### Success Criteria
- [ ] All feature business rules are documented
- [ ] Integration points are clearly specified
- [ ] Implementation guidance is actionable
- [ ] Domain model is consistent with high-level model
- [ ] Development team has clear understanding

---

**Execution Status**:
- [ ] Feature context analyzed
- [ ] Domain context extracted
- [ ] Event Storming executed
- [ ] Feature domain model created
- [ ] Implementation guidance prepared
- [ ] Big model update recommendations made
- [ ] Knowledge base enriched
- [ ] Implementation readiness assessed

'@ | Out-File -FilePath $FEATURE_REPORT_FILE -Encoding UTF8

if ($Json) {
    $output = @{
        EVENT_STORMING_DIR = $EVENT_STORMING_DIR
        EVENT_STORMING_FILE = $EVENT_STORMING_FILE
        FEATURE_REPORT_FILE = $FEATURE_REPORT_FILE
        KNOWLEDGE_DIR = $KNOWLEDGE_DIR
        FEATURE_NAME = $FEATURE_NAME
        FEATURE_DIR = $FEATURE_DIR
        CURRENT_BRANCH = $CURRENT_BRANCH
        TIMESTAMP = $TIMESTAMP
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "EVENT_STORMING_DIR: $EVENT_STORMING_DIR"
    Write-Host "EVENT_STORMING_FILE: $EVENT_STORMING_FILE"
    Write-Host "FEATURE_REPORT_FILE: $FEATURE_REPORT_FILE"
    Write-Host "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    Write-Host "FEATURE_NAME: $FEATURE_NAME"
    Write-Host "FEATURE_DIR: $FEATURE_DIR"
    Write-Host "CURRENT_BRANCH: $CURRENT_BRANCH"
    Write-Host "TIMESTAMP: $TIMESTAMP"
    Write-Host ""
    Write-Host "Ready for feature-level Event Storming."
    if (-not [string]::IsNullOrEmpty($FEATURE_NAME)) {
        Write-Host "Working with feature: $FEATURE_NAME"
    } else {
        Write-Host "No specific feature detected - will work with provided context or current directory"
    }
    Write-Host ""
    Write-Host "The AI will now:"
    Write-Host "1. Analyze feature context and requirements"
    Write-Host "2. Query knowledge base for relevant domain intelligence"
    Write-Host "3. Execute feature-level Event Storming for detailed domain modeling"
    Write-Host "4. Create feature-specific domain model and implementation guidance"
    Write-Host "5. Prepare big model update recommendations"
    Write-Host "6. Enrich knowledge base with feature-specific insights"
    Write-Host ""
    Write-Host "Feature-level Event Storming will be performed in the current branch context."
}
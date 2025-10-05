#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] [update_scope]"
    exit 0
}

$UPDATE_INPUT = $Args -join ' '

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

# Create update scope name
if (-not [string]::IsNullOrEmpty($UPDATE_INPUT)) {
    $SCOPE_NAME = ($UPDATE_INPUT | Select-Object -First 30).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
} else {
    $SCOPE_NAME = "comprehensive"
}

# Create timestamp-based update directory
$TIMESTAMP = Get-Date -Format "yyyyMMdd-HHmmss"
$UPDATE_DIR = "$REPO_ROOT/specs/big-model-update-$SCOPE_NAME-$TIMESTAMP"
New-Item -ItemType Directory -Force -Path $UPDATE_DIR | Out-Null

# Create update report file
$UPDATE_REPORT_FILE = "$UPDATE_DIR/big-model-update-report.md"

# Create knowledge directory
$KNOWLEDGE_DIR = "$UPDATE_DIR/knowledge"
New-Item -ItemType Directory -Force -Path $KNOWLEDGE_DIR | Out-Null

# Create changes directory
$CHANGES_DIR = "$UPDATE_DIR/changes"
New-Item -ItemType Directory -Force -Path $CHANGES_DIR | Out-Null

# Create validation directory
$VALIDATION_DIR = "$UPDATE_DIR/validation"
New-Item -ItemType Directory -Force -Path $VALIDATION_DIR | Out-Null

# Create basic template for big model update report
@'
# Big Model Update Report

**Update ID**: big-model-update-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Update Scope**: [Update scope or comprehensive]
**Update Focus**: [Specific focus area or comprehensive big model synchronization]

## Executive Summary

[High-level summary of big model updates, key changes, and impact on domain understanding]

## Update Overview

### Update Objectives
- **Primary Goal**: [Main update objective]
- **Scope**: [Update scope and boundaries]
- **Success Criteria**: [Measurable success criteria]
- **Key Metrics**: [Metrics used for evaluation]

### Update Methodology
- **Analysis Approach**: [How feature insights were analyzed]
- **Integration Strategy**: [How insights were integrated into big model]
- **Validation Method**: [How consistency was validated]
- **Quality Assurance**: [Quality measures applied]

## Current Big Model State

### High-Level Domain Model Structure
**Bounded Contexts**:
- [Context 1]: [Description and scope]
- [Context 2]: [Description and scope]

**Major Aggregates**:
- [Aggregate 1]: [Entities and responsibilities]
- [Aggregate 2]: [Entities and responsibilities]

**Domain Events**:
- [Event 1]: [Business significance and triggers]
- [Event 2]: [Business significance and triggers]

### Business Rules and Constraints
**Key Business Rules**:
- [Rule 1]: [Description and scope]
- [Rule 2]: [Description and scope]

**Domain Constraints**:
- [Constraint 1]: [Description and impact]
- [Constraint 2]: [Description and impact]

## Feature Insights Analysis

### Features Analyzed for Update
**Feature-Level Event Storming Results**:
- [Feature 1]: [Key insights and domain contributions]
- [Feature 2]: [Key insights and domain contributions]

**Feature-to-Domain Mapping**:
- [Feature 1]: [Relationship to big model elements]
- [Feature 2]: [Relationship to big model elements]

### New Domain Elements Discovered
**New Entities**:
- [Entity 1]: [Description and relationships]
- [Entity 2]: [Description and relationships]

**New Relationships**:
- [Relationship 1]: [Description and significance]
- [Relationship 2]: [Description and significance]

**New Business Rules**:
- [Rule 1]: [Description and applicability]
- [Rule 2]: [Description and applicability]

## Big Model Updates Applied

### Entity and Relationship Updates
**Added Entities**:
- [Entity 1]: [Rationale for addition]
- [Entity 2]: [Rationale for addition]

**Refined Entities**:
- [Entity 1]: [Refinements made and rationale]
- [Entity 2]: [Refinements made and rationale]

**New Relationships**:
- [Relationship 1]: [Description and impact]
- [Relationship 2]: [Description and impact]

### Business Rule Enhancements
**Added Business Rules**:
- [Rule 1]: [Source feature and business value]
- [Rule 2]: [Source feature and business value]

**Refined Business Rules**:
- [Rule 1]: [Refinements and source insights]
- [Rule 2]: [Refinements and source insights]

**Constraint Updates**:
- [Constraint 1]: [Updates and rationale]
- [Constraint 2]: [Updates and rationale]

### Domain Event and Process Updates
**New Domain Events**:
- [Event 1]: [Source feature and significance]
- [Event 2]: [Source feature and significance]

**Refined Domain Events**:
- [Event 1]: [Refinements and feature insights]
- [Event 2]: [Refinements and feature insights]

**Process Enhancements**:
- [Process 1]: [Enhancements and feature workflows]
- [Process 2]: [Enhancements and feature workflows]

## Integration Point Synchronization

### External System Integration Updates
**API Contract Updates**:
- [Endpoint 1]: [Updates and feature requirements]
- [Endpoint 2]: [Updates and feature requirements]

**Data Model Enhancements**:
- [Model 1]: [Enhancements and rationale]
- [Model 2]: [Enhancements and rationale]

### Cross-Context Communication
**Event-Driven Updates**:
- [Event 1]: [Enhanced communication pattern]
- [Event 2]: [Enhanced communication pattern]

**Integration Patterns**:
- [Pattern 1]: [Refinements and feature insights]
- [Pattern 2]: [Refinements and feature insights]

## Consistency Validation Results

### Model Consistency Validation
**Big Model vs Feature Consistency**:
- ✅ **Consistent**: [Areas of consistency]
- ❌ **Inconsistencies Resolved**: [Resolved inconsistencies]
- ⚠️ **Areas Requiring Attention**: [Areas needing monitoring]

**Cross-Feature Consistency**:
- ✅ **Consistent**: [Consistent elements across features]
- ❌ **Conflicts Addressed**: [Conflicts resolved]
- ⚠️ **Variations Managed**: [Managed variations]

### Business Rule Consistency
**Rule Validation Results**:
- ✅ **Consistent**: [Consistent business rules]
- ❌ **Conflicts Resolved**: [Resolved conflicts]
- ⚠️ **Clarifications Needed**: [Areas requiring clarification]

**Constraint Validation**:
- ✅ **Consistent**: [Consistent constraints]
- ❌ **Conflicts Addressed**: [Addressed conflicts]
- ⚠️ **Refinements Made**: [Constraint refinements]

## Quality Assessment

### Model Quality Metrics
**Completeness Score**: [Score out of 100]
**Consistency Score**: [Score out of 100]
**Accuracy Score**: [Score out of 100]
**Actionability Score**: [Score out of 100]

### Integration Quality Metrics
**Feature Integration Score**: [Score out of 100]
**Knowledge Base Integration Score**: [Score out of 100]
**Implementation Guidance Score**: [Score out of 100]

## Pattern and Best Practice Integration

### Successful Patterns Identified
**Cross-Feature Patterns**:
- [Pattern 1]: [Description and applicability]
- [Pattern 2]: [Description and applicability]

**Implementation Best Practices**:
- [Practice 1]: [Description and benefits]
- [Practice 2]: [Description and benefits]

### Anti-Patterns Documented
**Anti-Patterns Avoided**:
- [Anti-pattern 1]: [Description and alternative]
- [Anti-pattern 2]: [Description and alternative]

## Documentation Updates

### Updated Artifacts
**Domain Model Diagrams**:
- [Diagram 1]: [Updates made]
- [Diagram 2]: [Updates made]

**Documentation Sections**:
- [Section 1]: [Updates and improvements]
- [Section 2]: [Updates and improvements]

### Change Tracking
**Version Changes**:
- [Change 1]: [Description and impact]
- [Change 2]: [Description and impact]

**Decision Log**:
- [Decision 1]: [Rationale and impact]
- [Decision 2]: [Rationale and impact]

## Knowledge Base Enhancement

### New Knowledge Added
- [Knowledge item 1]: [Description and value]
- [Knowledge item 2]: [Description and value]

### Knowledge Base Improvements
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

## Impact Analysis

### Impact on Existing Features
**Features Affected**:
- [Feature 1]: [Impact and considerations]
- [Feature 2]: [Impact and considerations]

**Migration Requirements**:
- [Requirement 1]: [Description and timeline]
- [Requirement 2]: [Description and timeline]

### Impact on Future Development
**Development Guidance**:
- [Guidance 1]: [Updated approach and rationale]
- [Guidance 2]: [Updated approach and rationale]

**Planning Considerations**:
- [Consideration 1]: [Impact on future planning]
- [Consideration 2]: [Impact on future planning]

## Next Steps and Recommendations

### Immediate Actions (Next 1-2 weeks)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Short-term Actions (Next 1-2 months)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Long-term Maintenance
- [Activity 1]: [Frequency and responsibility]
- [Activity 2]: [Frequency and responsibility]

## Success Metrics and Monitoring

### Key Metrics to Track
- [Metric 1]: [Target value and measurement approach]
- [Metric 2]: [Target value and measurement approach]

### Monitoring Approach
- [Monitoring method 1]: [Frequency and responsibility]
- [Monitoring method 2]: [Frequency and responsibility]

## Conclusion

[Summary of update outcomes, key achievements, and future directions]

---

**Update Status**:
- [ ] Feature insights analyzed
- [ ] Big model updates planned
- [ ] Entity and relationship updates applied
- [ ] Business rules and constraints updated
- [ ] Domain events and processes enhanced
- [ ] Integration points synchronized
- [ ] Consistency validation completed
- [ ] Quality assessment performed
- [ ] Documentation updated
- [ ] Knowledge base enhanced
- [ ] Impact analysis completed

'@ | Out-File -FilePath $UPDATE_REPORT_FILE -Encoding UTF8

if ($Json) {
    $output = @{
        UPDATE_DIR = $UPDATE_DIR
        UPDATE_REPORT_FILE = $UPDATE_REPORT_FILE
        KNOWLEDGE_DIR = $KNOWLEDGE_DIR
        CHANGES_DIR = $CHANGES_DIR
        VALIDATION_DIR = $VALIDATION_DIR
        SCOPE_NAME = $SCOPE_NAME
        CURRENT_BRANCH = $CURRENT_BRANCH
        TIMESTAMP = $TIMESTAMP
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "UPDATE_DIR: $UPDATE_DIR"
    Write-Host "UPDATE_REPORT_FILE: $UPDATE_REPORT_FILE"
    Write-Host "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    Write-Host "CHANGES_DIR: $CHANGES_DIR"
    Write-Host "VALIDATION_DIR: $VALIDATION_DIR"
    Write-Host "SCOPE_NAME: $SCOPE_NAME"
    Write-Host "CURRENT_BRANCH: $CURRENT_BRANCH"
    Write-Host "TIMESTAMP: $TIMESTAMP"
    Write-Host ""
    Write-Host "Ready for big model synchronization and update."
    if (-not [string]::IsNullOrEmpty($UPDATE_INPUT)) {
        Write-Host "Update scope: $UPDATE_INPUT"
    } else {
        Write-Host "Update scope: Comprehensive (all feature insights)"
    }
    Write-Host ""
    Write-Host "The AI will now:"
    Write-Host "1. Analyze current big model and feature insights"
    Write-Host "2. Identify updates needed for domain model synchronization"
    Write-Host "3. Apply entity, relationship, and business rule updates"
    Write-Host "4. Synchronize integration points and processes"
    Write-Host "5. Validate consistency and quality of updated model"
    Write-Host "6. Enhance knowledge base with updated domain insights"
    Write-Host "7. Generate comprehensive update report and recommendations"
    Write-Host ""
    Write-Host "Big model update will be performed in the current branch context."
}
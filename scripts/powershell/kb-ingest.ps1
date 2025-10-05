#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] <file_path_or_direct_text>"
    exit 0
}

$INGEST_INPUT = $Args -join ' '

if ([string]::IsNullOrEmpty($INGEST_INPUT)) {
    Write-Host "Usage: $PSCommandPath [--json] <file_path_or_direct_text>" -ForegroundColor Red
    exit 1
}

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

# Determine input type and create names
if ($INGEST_INPUT -match "\.") {
    $EXTENSION = [System.IO.Path]::GetExtension($INGEST_INPUT)
    if (Test-Path $INGEST_INPUT) {
        # File path input
        $INPUT_TYPE = "file"
        $FILENAME = [System.IO.Path]::GetFileName($INGEST_INPUT)
        $INGEST_NAME = [System.IO.Path]::GetFileNameWithoutExtension($FILENAME).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
        $INPUT_DISPLAY = "File: $INGEST_INPUT"
    } else {
        # Text input that looks like a file path but doesn't exist
        $INPUT_TYPE = "text"
        $INGEST_NAME = ($INGEST_INPUT | Select-Object -First 20).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
        $INPUT_DISPLAY = "Text: $($INGEST_INPUT.Substring(0, [Math]::Min(50, $INGEST_INPUT.Length)))..."
    }
} else {
    # Direct text input
    $INPUT_TYPE = "text"
    $INGEST_NAME = ($INGEST_INPUT | Select-Object -First 20).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
    $INPUT_DISPLAY = "Text: $($INGEST_INPUT.Substring(0, [Math]::Min(50, $INGEST_INPUT.Length)))..."
}

if ([string]::IsNullOrEmpty($INGEST_NAME)) {
    $INGEST_NAME = "knowledge-ingestion"
}

# Create timestamp-based ingestion directory
$TIMESTAMP = Get-Date -Format "yyyyMMdd-HHmmss"
$INGEST_DIR = "$REPO_ROOT/specs/knowledge-ingestion/$INGEST_NAME-$TIMESTAMP"
New-Item -ItemType Directory -Force -Path $INGEST_DIR | Out-Null

# Create ingestion report file
$INGEST_REPORT_FILE = "$INGEST_DIR/ingestion-report.md"

# Create knowledge directory for this ingestion
$KNOWLEDGE_DIR = "$INGEST_DIR/knowledge"
New-Item -ItemType Directory -Force -Path $KNOWLEDGE_DIR | Out-Null

# Create extraction results directory
$EXTRACTION_DIR = "$INGEST_DIR/extraction"
New-Item -ItemType Directory -Force -Path $EXTRACTION_DIR | Out-Null

# Create validation directory
$VALIDATION_DIR = "$INGEST_DIR/validation"
New-Item -ItemType Directory -Force -Path $VALIDATION_DIR | Out-Null

# Create basic template for ingestion report
@'
# Knowledge Base Ingestion Report

**Ingestion ID**: knowledge-ingestion-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Input Type**: [File/Text]
**Input**: [Input description]
**Ingestion Strategy**: [Processing approach used]

## Input Analysis

### Content Overview
**Content Type**: [Type of content ingested]
**Content Size**: [Size and complexity assessment]
**Domain Context**: [Relevant domain areas]
**Expected Value**: [Anticipated knowledge value]

### Processing Strategy
**Ingestion Method**: [File processing vs direct text]
**Processing Mode**: [Fast vs comprehensive mode]
**Chunking Strategy**: [How content was divided if needed]
**Quality Focus**: [Quality assurance approach]

## Pre-Ingestion Assessment

### Knowledge Base State
**Current Statistics**: [Size and growth metrics]
**Existing Coverage**: [Relevant existing knowledge areas]
**Schema Compatibility**: [Compatibility with existing structure]
**Integration Potential**: [Expected integration benefits]

### Risk Assessment
**Quality Risks**: [Potential quality issues]
**Integration Risks**: [Potential integration challenges]
**Consistency Risks**: [Potential consistency issues]
**Mitigation Strategies**: [Risk mitigation approaches]

## Ingestion Execution

### Content Processing
**Preprocessing Steps**:
- [Step 1]: [Description and purpose]
- [Step 2]: [Description and purpose]

**Parsing Results**:
- [Parse Result 1]: [Success and details]
- [Parse Result 2]: [Success and details]

### Entity and Relationship Extraction
**Entities Extracted**:
- [Entity 1]: [Type, attributes, and confidence]
- [Entity 2]: [Type, attributes, and confidence]

**Relationships Mapped**:
- [Relationship 1]: [Entities, type, and confidence]
- [Relationship 2]: [Entities, type, and confidence]

**Business Rules Identified**:
- [Rule 1]: [Description, scope, and confidence]
- [Rule 2]: [Description, scope, and confidence]

### Pattern and Component Extraction
**Patterns Discovered**:
- [Pattern 1]: [Description, context, and applicability]
- [Pattern 2]: [Description, context, and applicability]

**Components Identified**:
- [Component 1]: [Type, purpose, and relationships]
- [Component 2]: [Type, purpose, and relationships]

## Quality Validation

### Extraction Quality
**Entity Quality**: [Assessment of entity extraction accuracy]
**Relationship Quality**: [Assessment of relationship mapping accuracy]
**Rule Quality**: [Assessment of business rule extraction quality]
**Pattern Quality**: [Assessment of pattern identification quality]

### Consistency Validation
**Internal Consistency**: [Consistency within extracted knowledge]
**External Consistency**: [Consistency with existing knowledge base]
**Logical Consistency**: [Logical soundness of extracted information]
**Domain Consistency**: [Consistency with domain understanding]

### Completeness Assessment
**Coverage Analysis**: [How well the content was covered]
**Gap Identification**: [Areas where extraction may be incomplete]
**Confidence Levels**: [Overall confidence in extraction results]
**Quality Metrics**: [Quantitative quality measures]

## Integration Analysis

### Knowledge Base Impact
**New Knowledge Added**:
- [Knowledge Item 1]: [Type, significance, and integration]
- [Knowledge Item 2]: [Type, significance, and integration]

**Enhanced Understanding**:
- [Enhancement 1]: [Area of improvement]
- [Enhancement 2]: [Area of improvement]

**Relationship Strengthening**:
- [Relationship 1]: [New or strengthened connections]
- [Relationship 2]: [New or strengthened connections]

### Value Assessment
**Immediate Value**: [Short-term benefits of ingestion]
**Long-term Value**: [Long-term strategic benefits]
**Multiplier Effects**: [How this enhances other knowledge]
**Innovation Potential**: [Potential for new insights and approaches]

## Quality Improvement Recommendations

### Processing Enhancements
**Extraction Improvements**:
- [Improvement 1]: [Description and expected benefit]
- [Improvement 2]: [Description and expected benefit]

**Quality Control Enhancements**:
- [Enhancement 1]: [Description and expected benefit]
- [Enhancement 2]: [Description and expected benefit]

### Knowledge Base Enhancements
**Schema Improvements**:
- [Improvement 1]: [Description and rationale]
- [Improvement 2]: [Description and rationale]

**Organization Enhancements**:
- [Enhancement 1]: [Description and benefits]
- [Enhancement 2]: [Description and benefits]

## Performance Metrics

### Ingestion Performance
**Processing Time**: [Time taken for ingestion]
**Memory Usage**: [Memory consumption during processing]
**CPU Utilization**: [Processor usage during processing]
**Success Rate**: [Percentage of successful extractions]

### Quality Metrics
**Accuracy Score**: [Overall accuracy of extraction]
**Completeness Score**: [Completeness of knowledge extraction]
**Consistency Score**: [Consistency with existing knowledge]
**Actionability Score**: [Usability of extracted knowledge]

## Follow-up Actions

### Immediate Actions
**Knowledge Base Updates**:
- [Action 1]: [Description and priority]
- [Action 2]: [Description and priority]

**Quality Assurance**:
- [Action 1]: [Description and priority]
- [Action 2]: [Description and priority]

### Future Enhancements
**Process Improvements**:
- [Improvement 1]: [Description and timeline]
- [Improvement 2]: [Description and timeline]

**Knowledge Base Development**:
- [Development 1]: [Description and timeline]
- [Development 2]: [Description and timeline]

## Lessons Learned

### Success Factors
- [Success Factor 1]: [Description and impact]
- [Success Factor 2]: [Description and impact]

### Challenges Addressed
- [Challenge 1]: [Description and resolution]
- [Challenge 2]: [Description and resolution]

### Best Practices Identified
- [Best Practice 1]: [Description and applicability]
- [Best Practice 2]: [Description and applicability]

---

**Ingestion Status**:
- [ ] Input analyzed and processed
- [ ] Entity and relationship extraction completed
- [ ] Business rules and patterns identified
- [ ] Quality validation performed
- [ ] Integration analysis completed
- [ ] Value assessment conducted
- [ ] Performance metrics collected
- [ ] Recommendations generated
- [ ] Follow-up actions identified
- [ ] Lessons learned documented

'@ | Out-File -FilePath $INGEST_REPORT_FILE -Encoding UTF8

if ($Json) {
    $output = @{
        INGEST_DIR = $INGEST_DIR
        INGEST_REPORT_FILE = $INGEST_REPORT_FILE
        KNOWLEDGE_DIR = $KNOWLEDGE_DIR
        EXTRACTION_DIR = $EXTRACTION_DIR
        VALIDATION_DIR = $VALIDATION_DIR
        INGEST_NAME = $INGEST_NAME
        INPUT_TYPE = $INPUT_TYPE
        CURRENT_BRANCH = $CURRENT_BRANCH
        TIMESTAMP = $TIMESTAMP
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "INGEST_DIR: $INGEST_DIR"
    Write-Host "INGEST_REPORT_FILE: $INGEST_REPORT_FILE"
    Write-Host "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    Write-Host "EXTRACTION_DIR: $EXTRACTION_DIR"
    Write-Host "VALIDATION_DIR: $VALIDATION_DIR"
    Write-Host "INGEST_NAME: $INGEST_NAME"
    Write-Host "INPUT_TYPE: $INPUT_TYPE"
    Write-Host "CURRENT_BRANCH: $CURRENT_BRANCH"
    Write-Host "TIMESTAMP: $TIMESTAMP"
    Write-Host ""
    Write-Host "Ready for knowledge base ingestion."
    Write-Host "$INPUT_DISPLAY"
    Write-Host ""
    Write-Host "The AI will now:"
    Write-Host "1. Analyze input type and develop ingestion strategy"
    Write-Host "2. Process content and extract entities, relationships, and patterns"
    Write-Host "3. Validate extraction quality and consistency"
    Write-Host "4. Analyze integration impact and value"
    Write-Host "5. Provide quality improvement recommendations"
    Write-Host "6. Generate comprehensive ingestion report"
    Write-Host ""
    Write-Host "Knowledge base ingestion will be performed in the current branch context."
}
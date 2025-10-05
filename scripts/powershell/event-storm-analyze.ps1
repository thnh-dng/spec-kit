#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] [analysis_scope]"
    exit 0
}

$ANALYSIS_INPUT = $Args -join ' '

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

# Create analysis scope name
if (-not [string]::IsNullOrEmpty($ANALYSIS_INPUT)) {
    $SCOPE_NAME = ($ANALYSIS_INPUT | Select-Object -First 30).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
} else {
    $SCOPE_NAME = "comprehensive"
}

# Create timestamp-based analysis directory
$TIMESTAMP = Get-Date -Format "yyyyMMdd-HHmmss"
$ANALYSIS_DIR = "$REPO_ROOT/specs/event-storming-analysis-$SCOPE_NAME-$TIMESTAMP"
New-Item -ItemType Directory -Force -Path $ANALYSIS_DIR | Out-Null

# Create analysis report file
$ANALYSIS_REPORT_FILE = "$ANALYSIS_DIR/cross-artifact-analysis-report.md"

# Create knowledge directory
$KNOWLEDGE_DIR = "$ANALYSIS_DIR/knowledge"
New-Item -ItemType Directory -Force -Path $KNOWLEDGE_DIR | Out-Null

# Create findings directory
$FINDINGS_DIR = "$ANALYSIS_DIR/findings"
New-Item -ItemType Directory -Force -Path $FINDINGS_DIR | Out-Null

# Create recommendations directory
$RECOMMENDATIONS_DIR = "$ANALYSIS_DIR/recommendations"
New-Item -ItemType Directory -Force -Path $RECOMMENDATIONS_DIR | Out-Null

# Create basic template for cross-artifact analysis report
@'
# Cross-Artifact Event Storming Analysis Report

**Analysis ID**: event-storming-analysis-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Analysis Scope**: [Analysis scope or comprehensive]
**Analysis Focus**: [Specific focus area or comprehensive analysis]

## Executive Summary

[High-level summary of analysis findings, key insights, and recommendations]

## Analysis Overview

### Analysis Objectives
- **Primary Goal**: [Main analysis objective]
- **Scope**: [Analysis scope and boundaries]
- **Success Criteria**: [Measurable success criteria]
- **Key Metrics**: [Metrics used for evaluation]

### Analysis Methodology
- **Artifact Discovery**: [How artifacts were discovered and collected]
- **Consistency Validation**: [Approach for validating consistency]
- **Gap Analysis**: [Method for identifying gaps and conflicts]
- **Quality Assessment**: [Quality evaluation approach]

## Artifacts Analyzed

### High-Level Domain Models
**Domain Event Storming Diagrams**:
- [Diagram 1]: [Location and description]
- [Diagram 2]: [Location and description]

**Domain Analysis Reports**:
- [Report 1]: [Location and description]
- [Report 2]: [Location and description]

### Feature-Level Domain Models
**Feature Event Storming Reports**:
- [Feature 1]: [Location and description]
- [Feature 2]: [Location and description]

**Feature Domain Models**:
- [Feature 1]: [Key domain elements]
- [Feature 2]: [Key domain elements]

### Knowledge Base Artifacts
**Domain Intelligence**:
- [Entity 1]: [Description and relationships]
- [Relationship 1]: [Description and scope]

**Business Rules and Patterns**:
- [Pattern 1]: [Description and usage]
- [Rule 1]: [Description and scope]

## Consistency Validation Results

### Model Consistency
**High-Level vs Feature-Level Consistency**:
- ✅ **Consistent**: [Areas of consistency]
- ❌ **Inconsistent**: [Areas of inconsistency]
- ⚠️ **Needs Clarification**: [Areas needing clarification]

**Cross-Feature Consistency**:
- ✅ **Consistent**: [Consistent elements across features]
- ❌ **Conflicts**: [Conflicting definitions or approaches]
- ⚠️ **Variations**: [Acceptable variations and differences]

### Business Rule Consistency
**Rule Validation**:
- ✅ **Consistent**: [Consistent business rules]
- ❌ **Conflicting**: [Conflicting business rules]
- ⚠️ **Incomplete**: [Incomplete or unclear rules]

**Constraint Validation**:
- ✅ **Consistent**: [Consistent constraints]
- ❌ **Conflicting**: [Conflicting constraints]
- ⚠️ **Missing**: [Missing constraints]

## Gap and Conflict Analysis

### Identified Gaps
**Missing Domain Elements**:
- [Gap 1]: [Description and impact]
- [Gap 2]: [Description and impact]

**Incomplete Coverage**:
- [Area 1]: [Incomplete coverage description]
- [Area 2]: [Incomplete coverage description]

### Identified Conflicts
**Definition Conflicts**:
- [Conflict 1]: [Conflicting definitions and resolution]
- [Conflict 2]: [Conflicting definitions and resolution]

**Responsibility Conflicts**:
- [Conflict 1]: [Conflicting responsibilities and resolution]
- [Conflict 2]: [Conflicting responsibilities and resolution]

### Integration Challenges
**Integration Point Issues**:
- [Challenge 1]: [Integration challenge and solution]
- [Challenge 2]: [Integration challenge and solution]

**Cross-Context Issues**:
- [Issue 1]: [Cross-context issue and impact]
- [Issue 2]: [Cross-context issue and impact]

## Pattern and Quality Analysis

### Discovered Patterns
**Common Domain Patterns**:
- [Pattern 1]: [Description and usage across features]
- [Pattern 2]: [Description and usage across features]

**Successful Approaches**:
- [Approach 1]: [Description and benefits]
- [Approach 2]: [Description and benefits]

### Anti-Patterns and Issues
**Identified Anti-Patterns**:
- [Anti-pattern 1]: [Description and recommended alternative]
- [Anti-pattern 2]: [Description and recommended alternative]

**Quality Issues**:
- [Issue 1]: [Description and severity]
- [Issue 2]: [Description and severity]

### Quality Assessment
**Overall Quality Score**: [Score out of 100]
**Consistency Score**: [Score out of 100]
**Completeness Score**: [Score out of 100]
**Integration Quality Score**: [Score out of 100]

## Recommendations

### High Priority Recommendations
**Immediate Actions**:
1. [Action 1]: [Description and rationale]
2. [Action 2]: [Description and rationale]

**Model Improvements**:
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

### Medium Priority Recommendations
**Enhancement Opportunities**:
- [Opportunity 1]: [Description and value]
- [Opportunity 2]: [Description and value]

**Process Improvements**:
- [Improvement 1]: [Description and impact]
- [Improvement 2]: [Description and impact]

### Low Priority Recommendations
**Future Considerations**:
- [Consideration 1]: [Description and context]
- [Consideration 2]: [Description and context]

## Implementation Plan

### Immediate Actions (Next 1-2 weeks)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Short-term Actions (Next 1-2 months)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Long-term Actions (Next 3-6 months)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

## Success Metrics and Monitoring

### Key Metrics to Track
- [Metric 1]: [Target value and measurement approach]
- [Metric 2]: [Target value and measurement approach]

### Monitoring Approach
- [Monitoring method 1]: [Frequency and responsibility]
- [Monitoring method 2]: [Frequency and responsibility]

### Success Criteria
- [Criterion 1]: [Definition and measurement]
- [Criterion 2]: [Definition and measurement]

## Knowledge Base Enhancements

### New Knowledge Added
- [Knowledge item 1]: [Description and value]
- [Knowledge item 2]: [Description and value]

### Knowledge Base Improvements
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

## Conclusion

[Summary of analysis outcomes, key takeaways, and next steps]

---

**Analysis Status**:
- [ ] Artifact discovery completed
- [ ] Consistency validation performed
- [ ] Gap and conflict analysis completed
- [ ] Pattern and quality analysis finished
- [ ] Recommendations generated
- [ ] Implementation plan created
- [ ] Knowledge base enhanced
- [ ] Success metrics defined

'@ | Out-File -FilePath $ANALYSIS_REPORT_FILE -Encoding UTF8

if ($Json) {
    $output = @{
        ANALYSIS_DIR = $ANALYSIS_DIR
        ANALYSIS_REPORT_FILE = $ANALYSIS_REPORT_FILE
        KNOWLEDGE_DIR = $KNOWLEDGE_DIR
        FINDINGS_DIR = $FINDINGS_DIR
        RECOMMENDATIONS_DIR = $RECOMMENDATIONS_DIR
        SCOPE_NAME = $SCOPE_NAME
        CURRENT_BRANCH = $CURRENT_BRANCH
        TIMESTAMP = $TIMESTAMP
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "ANALYSIS_DIR: $ANALYSIS_DIR"
    Write-Host "ANALYSIS_REPORT_FILE: $ANALYSIS_REPORT_FILE"
    Write-Host "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    Write-Host "FINDINGS_DIR: $FINDINGS_DIR"
    Write-Host "RECOMMENDATIONS_DIR: $RECOMMENDATIONS_DIR"
    Write-Host "SCOPE_NAME: $SCOPE_NAME"
    Write-Host "CURRENT_BRANCH: $CURRENT_BRANCH"
    Write-Host "TIMESTAMP: $TIMESTAMP"
    Write-Host ""
    Write-Host "Ready for cross-artifact Event Storming analysis."
    if (-not [string]::IsNullOrEmpty($ANALYSIS_INPUT)) {
        Write-Host "Analysis scope: $ANALYSIS_INPUT"
    } else {
        Write-Host "Analysis scope: Comprehensive (all artifacts)"
    fi
    Write-Host ""
    Write-Host "The AI will now:"
    Write-Host "1. Discover and analyze all Event Storming artifacts"
    Write-Host "2. Validate consistency across domain models"
    Write-Host "3. Identify gaps, conflicts, and areas for improvement"
    Write-Host "4. Discover patterns and assess quality"
    Write-Host "5. Generate actionable recommendations"
    Write-Host "6. Enhance knowledge base with analysis insights"
    Write-Host "7. Create implementation plan for improvements"
    Write-Host ""
    Write-Host "Cross-artifact analysis will be performed in the current branch context."
}
#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] <query>"
    exit 0
}

$QUERY_INPUT = $Args -join ' '

if ([string]::IsNullOrEmpty($QUERY_INPUT)) {
    Write-Host "Usage: $PSCommandPath [--json] <query>" -ForegroundColor Red
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

# Create query name from input
$QUERY_NAME = ($QUERY_INPUT | Select-Object -First 30).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
if ([string]::IsNullOrEmpty($QUERY_NAME)) {
    $QUERY_NAME = "knowledge-query"
}

# Create timestamp-based query directory
$TIMESTAMP = Get-Date -Format "yyyyMMdd-HHmmss"
$QUERY_DIR = "$REPO_ROOT/specs/knowledge-queries/$QUERY_NAME-$TIMESTAMP"
New-Item -ItemType Directory -Force -Path $QUERY_DIR | Out-Null

# Create query results file
$QUERY_RESULTS_FILE = "$QUERY_DIR/query-results.md"

# Create knowledge directory for this query
$KNOWLEDGE_DIR = "$QUERY_DIR/knowledge"
New-Item -ItemType Directory -Force -Path $KNOWLEDGE_DIR | Out-Null

# Create basic template for query results
@'
# Knowledge Base Query Results

**Query ID**: knowledge-query-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Query**: [Original query text]
**Query Type**: [Query type analysis]

## Query Analysis

### Query Intent
- **Primary Goal**: [Main information goal]
- **Query Type**: [Factual/Relational/Pattern/Analytical]
- **Expected Results**: [What kind of information was sought]
- **Context**: [Project or domain context]

### Query Strategy
- **Search Approach**: [How the query was optimized]
- **Scope**: [Search scope and boundaries]
- **Complexity**: [Query complexity assessment]
- **Follow-up**: [Planned follow-up queries]

## Query Results

### Primary Results
**Direct Matches Found**:
- [Result 1]: [Relevance and significance]
- [Result 2]: [Relevance and significance]

**Key Entities Identified**:
- [Entity 1]: [Description and relationships]
- [Entity 2]: [Description and relationships]

**Relationships Mapped**:
- [Relationship 1]: [Description and significance]
- [Relationship 2]: [Description and significance]

### Supplementary Results
**Related Concepts**:
- [Concept 1]: [Connection to query]
- [Concept 2]: [Connection to query]

**Supporting Evidence**:
- [Evidence 1]: [Source and relevance]
- [Evidence 2]: [Source and relevance]

### Patterns and Insights
**Discovered Patterns**:
- [Pattern 1]: [Description and applicability]
- [Pattern 2]: [Description and applicability]

**Key Insights**:
- [Insight 1]: [Significance and implications]
- [Insight 2]: [Significance and implications]

## Context and Interpretation

### Domain Context
**Relevant Domain Areas**:
- [Domain 1]: [Relevance and connection]
- [Domain 2]: [Relevance and connection]

**Business Context**:
- [Business Area 1]: [Relevance and impact]
- [Business Area 2]: [Relevance and impact]

### Technical Context
**Implementation Context**:
- [Technology 1]: [Relevance and considerations]
- [Technology 2]: [Relevance and considerations]

**Integration Context**:
- [Integration Point 1]: [Relevance and requirements]
- [Integration Point 2]: [Relevance and requirements]

## Actionable Recommendations

### Immediate Actions
**Based on Query Results**:
1. [Action 1]: [Description and rationale]
2. [Action 2]: [Description and rationale]

### Implementation Guidance
**Technical Recommendations**:
- [Recommendation 1]: [Description and benefits]
- [Recommendation 2]: [Description and benefits]

**Architecture Considerations**:
- [Consideration 1]: [Impact and implications]
- [Consideration 2]: [Impact and implications]

### Follow-up Queries
**Related Queries to Consider**:
- [Query 1]: [Rationale and expected value]
- [Query 2]: [Rationale and expected value]

## Quality Assessment

### Result Quality
**Relevance Score**: [Score out of 100]
**Completeness Score**: [Score out of 100]
**Accuracy Score**: [Score out of 100]
**Actionability Score**: [Score out of 100]

### Knowledge Base Insights
**Coverage Analysis**:
- [Strength 1]: [Areas of good coverage]
- [Gap 1]: [Areas needing additional knowledge]

**Query Effectiveness**:
- [Success Factor 1]: [What worked well]
- [Improvement Area 1]: [Areas for query refinement]

## Source References

### Primary Sources
- [Source 1]: [Description and relevance]
- [Source 2]: [Description and relevance]

### Supporting Documentation
- [Document 1]: [Description and relevance]
- [Document 2]: [Description and relevance]

## Next Steps

### Immediate Next Steps
1. [Step 1]: [Description and timeline]
2. [Step 2]: [Description and timeline]

### Knowledge Base Enhancement
**Suggested Additions**:
- [Addition 1]: [Description and value]
- [Addition 2]: [Description and value]

### Process Improvements
**Query Optimization**:
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

---

**Query Status**:
- [ ] Query intent analyzed
- [ ] Query strategy developed
- [ ] Primary query executed
- [ ] Supplementary queries performed
- [ ] Results synthesized and analyzed
- [ ] Context and interpretation provided
- [ ] Recommendations generated
- [ ] Quality assessment completed
- [ ] Next steps identified
- [ ] Knowledge base insights documented

'@ | Out-File -FilePath $QUERY_RESULTS_FILE -Encoding UTF8

if ($Json) {
    $output = @{
        QUERY_DIR = $QUERY_DIR
        QUERY_RESULTS_FILE = $QUERY_RESULTS_FILE
        KNOWLEDGE_DIR = $KNOWLEDGE_DIR
        QUERY_NAME = $QUERY_NAME
        CURRENT_BRANCH = $CURRENT_BRANCH
        TIMESTAMP = $TIMESTAMP
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "QUERY_DIR: $QUERY_DIR"
    Write-Host "QUERY_RESULTS_FILE: $QUERY_RESULTS_FILE"
    Write-Host "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    Write-Host "QUERY_NAME: $QUERY_NAME"
    Write-Host "CURRENT_BRANCH: $CURRENT_BRANCH"
    Write-Host "TIMESTAMP: $TIMESTAMP"
    Write-Host ""
    Write-Host "Ready for knowledge base query."
    Write-Host "Query: $QUERY_INPUT"
    Write-Host ""
    Write-Host "The AI will now:"
    Write-Host "1. Analyze query intent and develop search strategy"
    Write-Host "2. Execute knowledge base queries with optimization"
    Write-Host "3. Synthesize results and extract actionable insights"
    Write-Host "4. Provide context-specific recommendations"
    Write-Host "5. Assess query effectiveness and knowledge base quality"
    Write-Host "6. Suggest follow-up actions and improvements"
    Write-Host ""
    Write-Host "Knowledge base query will be performed in the current branch context."
}
#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory=$false)]
    [switch]$Json,
    [Parameter(Mandatory=$false)]
    [switch]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] [schema_filter]"
    exit 0
}

$schemaFilter = $Args -join ' '
if ([string]::IsNullOrEmpty($schemaFilter)) {
    $schemaFilter = "None"
}

# Function to find the repository root by searching for existing project markers
function Find-RepoRoot {
    param([string]$startDir)
    $dir = $startDir
    while ($dir -ne "/") {
        if (Test-Path "$dir/.git" -or Test-Path "$dir/.specify") {
            return $dir
        }
        $dir = Split-Path $dir -Parent
    }
    return $startDir  # Fallback to current directory if no markers found
}

# Get the repository root
$repoRoot = Find-RepoRoot (Get-Location)
if (-not (Test-Path "$repoRoot/.specify")) {
    Write-Host "Error: Not in a Spec Kit project (no .specify directory found)" -ForegroundColor Red
    exit 1
}

# Create timestamp and analysis directory
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$knowledgeDir = "$repoRoot/.specify/knowledge"
New-Item -ItemType Directory -Force -Path $knowledgeDir | Out-Null

# Create output files
$schemaFile = "$knowledgeDir/kb-schema-$timestamp.md"
$analysisFile = "$knowledgeDir/kb-schema-analysis-$timestamp.md"

# Generate the schema file
@"
# Knowledge Base Schema Analysis

**Analysis ID**: kb-schema-$timestamp
**Timestamp**: $(Get-Date)
**Schema Filter**: $schemaFilter
**Status**: Analyzing

## Analysis Parameters
**Filter Criteria**: $schemaFilter
**Repository**: $repoRoot
**Knowledge Directory**: $knowledgeDir

## MCP Tools Used
- schema: Retrieve knowledge base structure
- stats: Get comprehensive statistics
- query: Analyze specific domain areas

## Analysis Scope
- Node Labels and Distribution
- Relationship Types and Frequencies
- Domain Clusters and Knowledge Areas
- Schema Completeness and Coverage
- Growth Trends and Patterns

## Output Files
- Schema File: $schemaFile
- Analysis File: $analysisFile
"@ | Out-File -FilePath $schemaFile -Encoding UTF8

# Generate initial analysis structure
@"
# Knowledge Base Schema Analysis Report

**Analysis ID**: kb-schema-$timestamp
**Analysis Date**: $(Get-Date)
**Filter**: $schemaFilter

## Executive Summary
*Analysis results will be populated by MCP tools*

## Schema Structure
### Node Labels
*To be populated by schema() tool*

### Relationship Types
*To be populated by schema() tool*

## Knowledge Base Statistics
*To be populated by stats() tool*

## Domain Intelligence Summary
*To be populated by query() tool*

## Growth Analysis
*To be populated by analysis*

## Recommendations
*To be populated by analysis*
"@ | Out-File -FilePath $analysisFile -Encoding UTF8

if ($Json) {
    @{
        SCHEMA_FILE = $schemaFile
        ANALYSIS_FILE = $analysisFile
        KNOWLEDGE_DIR = $knowledgeDir
        TIMESTAMP = $timestamp
        REPO_ROOT = $repoRoot
        SCHEMA_FILTER = $schemaFilter
    } | ConvertTo-Json
} else {
    Write-Host "Knowledge base schema analysis initialized:"
    Write-Host "  Filter: $schemaFilter"
    Write-Host "  Schema File: $schemaFile"
    Write-Host "  Analysis File: $analysisFile"
    Write-Host "  Knowledge Directory: $knowledgeDir"
}
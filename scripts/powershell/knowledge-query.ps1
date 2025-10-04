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
    Write-Host "Usage: $PSCommandPath [--json] <knowledge_query_input>"
    exit 0
}

$queryInput = $Args -join ' '
if ([string]::IsNullOrEmpty($queryInput)) {
    Write-Host "Usage: $PSCommandPath [--json] <knowledge_query_input>" -ForegroundColor Red
    exit 1
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
$queryFile = "$knowledgeDir/kb-query-$timestamp.md"
$resultsFile = "$knowledgeDir/kb-query-results-$timestamp.md"

# Generate the query file
@"
# Knowledge Base Query

**Query ID**: kb-query-$timestamp
**Timestamp**: $(Get-Date)
**Query**: $queryInput
**Status**: Executing

## Query Input
$queryInput

## MCP Tools Used
- query: Search knowledge base for relevant information
- schema: Understand knowledge base structure
- stats: Get knowledge base statistics

## Execution Context
- Repository: $repoRoot
- Knowledge Directory: $knowledgeDir
- Query File: $queryFile
- Results File: $resultsFile
"@ | Out-File -FilePath $queryFile -Encoding UTF8

if ($Json) {
    @{
        QUERY_FILE = $queryFile
        RESULTS_FILE = $resultsFile
        KNOWLEDGE_DIR = $knowledgeDir
        TIMESTAMP = $timestamp
        REPO_ROOT = $repoRoot
        QUERY_INPUT = $queryInput
    } | ConvertTo-Json
} else {
    Write-Host "Knowledge base query initialized:"
    Write-Host "  Query: $queryInput"
    Write-Host "  Query File: $queryFile"
    Write-Host "  Results File: $resultsFile"
    Write-Host "  Knowledge Directory: $knowledgeDir"
}
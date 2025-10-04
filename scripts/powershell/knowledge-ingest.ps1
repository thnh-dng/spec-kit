#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory=$false)]
    [switch]$Json,
    [Parameter(Mandatory=$false)]
    [switch]$Fast,
    [Parameter(Mandatory=$false)]
    [switch]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] [--fast] <ingest_input>"
    exit 0
}

$ingestInput = $Args -join ' '
if ([string]::IsNullOrEmpty($ingestInput)) {
    Write-Host "Usage: $PSCommandPath [--json] [--fast] <ingest_input>" -ForegroundColor Red
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

# Determine if input is a file path or direct text
if ($ingestInput -match '\.') {
    $ingestType = "file"
    $filePath = if (Test-Path $ingestInput) { (Resolve-Path $ingestInput).Path } else { $ingestInput }
    if (-not (Test-Path $filePath) -and $ingestInput -match '\.') {
        Write-Host "Warning: File not found at $filePath, treating as direct text" -ForegroundColor Yellow
        $ingestType = "text"
        $ingestContent = $ingestInput
    } elseif (Test-Path $filePath) {
        $ingestContent = $filePath
    } else {
        $ingestType = "text"
        $ingestContent = $ingestInput
    }
} else {
    $ingestType = "text"
    $ingestContent = $ingestInput
}

# Create output files
$ingestFile = "$knowledgeDir/kb-ingest-$timestamp.md"
$logFile = "$knowledgeDir/kb-ingest-log-$timestamp.md"

# Generate the ingest file
@"
# Knowledge Base Ingestion

**Ingestion ID**: kb-ingest-$timestamp
**Timestamp**: $(Get-Date)
**Ingestion Type**: $ingestType
**Fast Mode**: $($Fast.IsPresent)
**Status**: Processing

## Input
**Type**: $ingestType
**Content**: $ingestContent

## MCP Tools Used
- ingest: Process document file or text content
- ingest_spec: Ingest raw text content directly
- stats: Track knowledge base growth
- schema: Verify updated structure

## Execution Context
- Repository: $repoRoot
- Knowledge Directory: $knowledgeDir
- Ingestion File: $ingestFile
- Log File: $logFile

## Processing Strategy
- Fast Mode: $($Fast.IsPresent) (recommended for large documents)
- Entity Extraction: Enabled
- Relationship Mapping: Enabled
- Business Rule Extraction: Enabled
- Pattern Recognition: Enabled
"@ | Out-File -FilePath $ingestFile -Encoding UTF8

# Generate initial log
@"
# Knowledge Base Ingestion Log

**Ingestion ID**: kb-ingest-$timestamp
**Start Time**: $(Get-Date)
**Status**: Initializing

## Processing Steps
1. [ ] Input validation
2. [ ] Content type detection
3. [ ] MCP tool execution
4. [ ] Entity extraction
5. [ ] Relationship mapping
6. [ ] Quality validation
7. [ ] Knowledge base update
8. [ ] Statistics generation

## Progress Tracking
- Input Type: $ingestType
- Fast Mode: $($Fast.IsPresent)
- Start Time: $(Get-Date)
- End Time: Pending
- Entities Extracted: Pending
- Relationships Mapped: Pending
- Processing Status: Pending
"@ | Out-File -FilePath $logFile -Encoding UTF8

if ($Json) {
    @{
        INGEST_FILE = $ingestFile
        LOG_FILE = $logFile
        KNOWLEDGE_DIR = $knowledgeDir
        TIMESTAMP = $timestamp
        REPO_ROOT = $repoRoot
        INGEST_TYPE = $ingestType
        USE_FAST_MODE = $Fast.IsPresent
        INGEST_CONTENT = $ingestContent
    } | ConvertTo-Json
} else {
    Write-Host "Knowledge base ingestion initialized:"
    Write-Host "  Type: $ingestType"
    Write-Host "  Content: $ingestContent"
    Write-Host "  Fast Mode: $($Fast.IsPresent)"
    Write-Host "  Ingestion File: $ingestFile"
    Write-Host "  Log File: $logFile"
    Write-Host "  Knowledge Directory: $knowledgeDir"
}
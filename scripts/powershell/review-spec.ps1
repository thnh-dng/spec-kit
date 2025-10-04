#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [switch]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

if ($Help) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) [-Json] <requirement_analysis_input>"
    exit 0
}

$requirementInput = $Arguments -join ' '
if ([string]::IsNullOrWhiteSpace($requirementInput)) {
    Write-Error "Usage: $($MyInvocation.MyCommand.Name) [-Json] <requirement_analysis_input>"
    exit 1
}

# Function to find the repository root by searching for existing project markers
function Find-RepoRoot {
    param([string]$startDir)

    $currentDir = $startDir
    while ($currentDir -ne "/") {
        if (Test-Path "$currentDir/.git" -PathType Container) {
            return $currentDir
        }
        if (Test-Path "$currentDir/.specify" -PathType Container) {
            return $currentDir
        }
        $currentDir = Split-Path $currentDir -Parent
        if ([string]::IsNullOrWhiteSpace($currentDir)) {
            break
        }
    }
    return $null
}

# Resolve repository root
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$repoRoot = Find-RepoRoot $scriptDir

if ([string]::IsNullOrWhiteSpace($repoRoot)) {
    Write-Error "Error: Could not determine repository root. Please run this script from within the repository."
    exit 1
}

Set-Location $repoRoot

$specsDir = Join-Path $repoRoot "specs"
if (-not (Test-Path $specsDir -PathType Container)) {
    New-Item -ItemType Directory -Path $specsDir -Force | Out-Null
}

# Check if git is available
$hasGit = $false
try {
    $gitRoot = git rev-parse --show-toplevel 2>$null
    if ($LASTEXITCODE -eq 0) {
        $hasGit = $true
    }
} catch {
    $hasGit = $false
}

# Get current branch for context (but don't create new branch)
$currentBranch = "unknown"
if ($hasGit) {
    try {
        $currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -ne 0) {
            $currentBranch = "unknown"
        }
    } catch {
        $currentBranch = "unknown"
    }
}

# Create timestamp-based analysis directory to avoid conflicts
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$analysisName = $requirementInput.Substring(0, [Math]::Min(30, $requirementInput.Length)).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
if ([string]::IsNullOrWhiteSpace($analysisName)) {
    $analysisName = "complex-requirements"
}
$analysisDir = Join-Path $specsDir "complex-requirements-analysis-$timestamp"
if (-not (Test-Path $analysisDir -PathType Container)) {
    New-Item -ItemType Directory -Path $analysisDir -Force | Out-Null
}

# Create the analysis report file
$template = Join-Path $repoRoot ".specify/templates/review-spec-template.md"
$analysisFile = Join-Path $analysisDir "analysis-report.md"

if (Test-Path $template -PathType Leaf) {
    Copy-Item $template $analysisFile -Force
} else {
    # Fallback basic template if template not found
    @"
# Complex Requirements Analysis Report

**Analysis ID**: [###-complex-requirements]
**Created**: [DATE]
**Status**: Draft
**Source Document**: User Input
**Input Analysis**: "$requirementInput"

## Feature Breakdown

*Analysis results will be populated here*

---
"@ | Out-File -FilePath $analysisFile -Encoding UTF8
}

# Create feature stub files for each identified feature (these will be populated during AI analysis)
$featureStubsDir = Join-Path $analysisDir "feature-stubs"
if (-not (Test-Path $featureStubsDir -PathType Container)) {
    New-Item -ItemType Directory -Path $featureStubsDir -Force | Out-Null
}

if ($Json) {
    $output = @{
        ANALYSIS_FILE = $analysisFile
        ANALYSIS_DIR = $analysisDir
        FEATURE_STUBS_DIR = $featureStubsDir
        CURRENT_BRANCH = $currentBranch
        TIMESTAMP = $timestamp
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "ANALYSIS_FILE: $analysisFile"
    Write-Host "ANALYSIS_DIR: $analysisDir"
    Write-Host "FEATURE_STUBS_DIR: $featureStubsDir"
    Write-Host "CURRENT_BRANCH: $currentBranch"
    Write-Host "TIMESTAMP: $timestamp"
    Write-Host ""
    Write-Host "Ready for complex requirements analysis. The AI will now analyze your requirements"
    Write-Host "and break them down into manageable features while maintaining integrity and relationships."
    Write-Host "Analysis will be performed in the current branch context."
}
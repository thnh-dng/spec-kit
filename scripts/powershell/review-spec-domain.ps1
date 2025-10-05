#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

if ($Help) {
    Write-Host "Usage: $PSCommandPath [--json] <requirement_analysis_input>"
    exit 0
}

$REQUIREMENT_INPUT = $Args -join ' '
if ([string]::IsNullOrEmpty($REQUIREMENT_INPUT)) {
    Write-Host "Usage: $PSCommandPath [--json] <requirement_analysis_input>" -ForegroundColor Red
    exit 1
}

# Function to find the repository root by searching for existing project markers
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

# Resolve repository root. Prefer git information when available, but fall back
# to searching for repository markers so the workflow still functions in repositories that
# were initialised with --no-git.
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

$SPECS_DIR = "$REPO_ROOT/specs"
New-Item -ItemType Directory -Force -Path $SPECS_DIR | Out-Null

# Get current branch for context (but don't create new branch)
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

# Create timestamp-based analysis directory to avoid conflicts
$TIMESTAMP = Get-Date -Format "yyyyMMdd-HHmmss"
$ANALYSIS_NAME = ($REQUIREMENT_INPUT | Select-Object -First 30).ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
if ([string]::IsNullOrEmpty($ANALYSIS_NAME)) {
    $ANALYSIS_NAME = "complex-requirements"
}
$ANALYSIS_DIR = "$SPECS_DIR/complex-requirements-analysis-$TIMESTAMP"
New-Item -ItemType Directory -Force -Path $ANALYSIS_DIR | Out-Null

# Create the combined analysis report file
$TEMPLATE = "$REPO_ROOT/.specify/templates/review-spec-domain-template.md"
$ANALYSIS_FILE = "$ANALYSIS_DIR/analysis-report.md"
if (Test-Path $TEMPLATE) {
    Copy-Item $TEMPLATE $ANALYSIS_FILE
} else {
    # Fallback basic template if template not found
    @'
# Complex Requirements Analysis & Domain Event Storming Report

**Analysis ID**: [###-complex-requirements-domain]
**Created**: [DATE]
**Status**: Draft
**Source Document**: User Input
**Input Analysis": "$ARGUMENTS"

## Executive Summary

*Combined analysis and domain modeling results will be populated here*

## Feature Breakdown

*Feature analysis results will be populated here*

## Domain Model & Event Storming

*Domain Event Storming results will be populated here*

## Integration Mapping

*Feature-to-domain mapping will be populated here*

---
'@ | Out-File -FilePath $ANALYSIS_FILE -Encoding UTF8
}

# Create feature stub files for each identified feature (these will be populated during AI analysis)
$FEATURE_STUBS_DIR = "$ANALYSIS_DIR/feature-stubs"
New-Item -ItemType Directory -Force -Path $FEATURE_STUBS_DIR | Out-Null

# Create Event Storming directory
$EVENT_STORMING_DIR = "$ANALYSIS_DIR/event-storming"
New-Item -ItemType Directory -Force -Path $EVENT_STORMING_DIR | Out-Null

# Create Event Storming output file path
$EVENT_STORMING_FILE = "$EVENT_STORMING_DIR/domain-event-storming.drawio"

# Create knowledge directory for this analysis
$KNOWLEDGE_DIR = "$ANALYSIS_DIR/knowledge"
New-Item -ItemType Directory -Force -Path $KNOWLEDGE_DIR | Out-Null

if ($Json) {
    $output = @{
        ANALYSIS_FILE = $ANALYSIS_FILE
        ANALYSIS_DIR = $ANALYSIS_DIR
        FEATURE_STUBS_DIR = $FEATURE_STUBS_DIR
        EVENT_STORMING_DIR = $EVENT_STORMING_DIR
        EVENT_STORMING_FILE = $EVENT_STORMING_FILE
        KNOWLEDGE_DIR = $KNOWLEDGE_DIR
        CURRENT_BRANCH = $CURRENT_BRANCH
        TIMESTAMP = $TIMESTAMP
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "ANALYSIS_FILE: $ANALYSIS_FILE"
    Write-Host "ANALYSIS_DIR: $ANALYSIS_DIR"
    Write-Host "FEATURE_STUBS_DIR: $FEATURE_STUBS_DIR"
    Write-Host "EVENT_STORMING_DIR: $EVENT_STORMING_DIR"
    Write-Host "EVENT_STORMING_FILE: $EVENT_STORMING_FILE"
    Write-Host "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    Write-Host "CURRENT_BRANCH: $CURRENT_BRANCH"
    Write-Host "TIMESTAMP: $TIMESTAMP"
    Write-Host ""
    Write-Host "Ready for combined complex requirements analysis and domain Event Storming."
    Write-Host "The AI will now:"
    Write-Host "1. Analyze your requirements and break them down into manageable features"
    Write-Host "2. Extract domain context and prepare for Event Storming"
    Write-Host "3. Create high-level domain Event Storming diagram"
    Write-Host "4. Map features to domain model and create integrated documentation"
    Write-Host "5. Enrich knowledge base with both analysis and domain insights"
    Write-Host ""
    Write-Host "Analysis and Event Storming will be performed in the current branch context."
}
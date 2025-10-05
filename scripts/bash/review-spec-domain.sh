#!/usr/bin/env bash

set -e

JSON_MODE=false
REQUIREMENT_SOURCE=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] <requirement_analysis_input>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

REQUIREMENT_INPUT="${ARGS[*]}"
if [ -z "$REQUIREMENT_INPUT" ]; then
    echo "Usage: $0 [--json] <requirement_analysis_input>" >&2
    exit 1
fi

# Function to find the repository root by searching for existing project markers
find_repo_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -d "$dir/.git" ] || [ -d "$dir/.specify" ]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

# Resolve repository root. Prefer git information when available, but fall back
# to searching for repository markers so the workflow still functions in repositories that
# were initialised with --no-git.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if git rev-parse --show-toplevel >/dev/null 2>&1; then
    REPO_ROOT=$(git rev-parse --show-toplevel)
    HAS_GIT=true
else
    REPO_ROOT="$(find_repo_root "$SCRIPT_DIR")"
    if [ -z "$REPO_ROOT" ]; then
        echo "Error: Could not determine repository root. Please run this script from within the repository." >&2
        exit 1
    fi
    HAS_GIT=false
fi

cd "$REPO_ROOT"

SPECS_DIR="$REPO_ROOT/specs"
mkdir -p "$SPECS_DIR"

# Get current branch for context (but don't create new branch)
CURRENT_BRANCH="unknown"
if [ "$HAS_GIT" = true ]; then
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
fi

# Create timestamp-based analysis directory to avoid conflicts
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
ANALYSIS_NAME=$(echo "$REQUIREMENT_INPUT" | head -c 30 | tr '[:upper:]' '[:lower:] | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
if [ -z "$ANALYSIS_NAME" ]; then
    ANALYSIS_NAME="complex-requirements"
fi
ANALYSIS_DIR="$SPECS_DIR/complex-requirements-analysis-${TIMESTAMP}"
mkdir -p "$ANALYSIS_DIR"

# Create the combined analysis report file
TEMPLATE="$REPO_ROOT/.specify/templates/review-spec-domain-template.md"
ANALYSIS_FILE="$ANALYSIS_DIR/analysis-report.md"
if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$ANALYSIS_FILE"
else
    # Fallback basic template if template not found
    cat > "$ANALYSIS_FILE" << 'EOF'
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
EOF
fi

# Create feature stub files for each identified feature (these will be populated during AI analysis)
FEATURE_STUBS_DIR="$ANALYSIS_DIR/feature-stubs"
mkdir -p "$FEATURE_STUBS_DIR"

# Create Event Storming directory
EVENT_STORMING_DIR="$ANALYSIS_DIR/event-storming"
mkdir -p "$EVENT_STORMING_DIR"

# Create Event Storming output file path
EVENT_STORMING_FILE="$EVENT_STORMING_DIR/domain-event-storming.drawio"

# Create knowledge directory for this analysis
KNOWLEDGE_DIR="$ANALYSIS_DIR/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

if $JSON_MODE; then
    printf '{"ANALYSIS_FILE":"%s","ANALYSIS_DIR":"%s","FEATURE_STUBS_DIR":"%s","EVENT_STORMING_DIR":"%s","EVENT_STORMING_FILE":"%s","KNOWLEDGE_DIR":"%s","CURRENT_BRANCH":"%s","TIMESTAMP":"%s"}\n' \
        "$ANALYSIS_FILE" "$ANALYSIS_DIR" "$FEATURE_STUBS_DIR" "$EVENT_STORMING_DIR" "$EVENT_STORMING_FILE" "$KNOWLEDGE_DIR" "$CURRENT_BRANCH" "$TIMESTAMP"
else
    echo "ANALYSIS_FILE: $ANALYSIS_FILE"
    echo "ANALYSIS_DIR: $ANALYSIS_DIR"
    echo "FEATURE_STUBS_DIR: $FEATURE_STUBS_DIR"
    echo "EVENT_STORMING_DIR: $EVENT_STORMING_DIR"
    echo "EVENT_STORMING_FILE: $EVENT_STORMING_FILE"
    echo "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    echo "CURRENT_BRANCH: $CURRENT_BRANCH"
    echo "TIMESTAMP: $TIMESTAMP"
    echo ""
    echo "Ready for combined complex requirements analysis and domain Event Storming."
    echo "The AI will now:"
    echo "1. Analyze your requirements and break them down into manageable features"
    echo "2. Extract domain context and prepare for Event Storming"
    echo "3. Create high-level domain Event Storming diagram"
    echo "4. Map features to domain model and create integrated documentation"
    echo "5. Enrich knowledge base with both analysis and domain insights"
    echo ""
    echo "Analysis and Event Storming will be performed in the current branch context."
fi
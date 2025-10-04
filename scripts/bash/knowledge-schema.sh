#!/usr/bin/env bash

set -e

JSON_MODE=false
SCHEMA_FILTER=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] [schema_filter]"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

SCHEMA_FILTER="${ARGS[*]:-}"

# Function to find the repository root by searching for existing project markers
find_repo_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -d "$dir/.git" ] || [ -d "$dir/.specify" ]; then
            echo "$dir"
            return 0
        fi
        dir=$(dirname "$dir")
    done
    echo "$1"  # Fallback to current directory if no markers found
}

# Get the repository root
REPO_ROOT=$(find_repo_root "$(pwd)")
if [ ! -d "$REPO_ROOT/.specify" ]; then
    echo "Error: Not in a Spec Kit project (no .specify directory found)" >&2
    exit 1
fi

# Create timestamp and analysis directory
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
KNOWLEDGE_DIR="$REPO_ROOT/.specify/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

# Create output files
SCHEMA_FILE="$KNOWLEDGE_DIR/kb-schema-$TIMESTAMP.md"
ANALYSIS_FILE="$KNOWLEDGE_DIR/kb-schema-analysis-$TIMESTAMP.md"

# Generate the schema file
cat > "$SCHEMA_FILE" << EOF
# Knowledge Base Schema Analysis

**Analysis ID**: kb-schema-$TIMESTAMP
**Timestamp**: $(date)
**Schema Filter**: ${SCHEMA_FILTER:-"None"}
**Status**: Analyzing

## Analysis Parameters
**Filter Criteria**: $SCHEMA_FILTER
**Repository**: $REPO_ROOT
**Knowledge Directory**: $KNOWLEDGE_DIR

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
- Schema File: $SCHEMA_FILE
- Analysis File: $ANALYSIS_FILE
EOF

# Generate initial analysis structure
cat > "$ANALYSIS_FILE" << EOF
# Knowledge Base Schema Analysis Report

**Analysis ID**: kb-schema-$TIMESTAMP
**Analysis Date**: $(date)
**Filter**: ${SCHEMA_FILTER:-"Complete Schema"}

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
EOF

if [ "$JSON_MODE" = true ]; then
    cat << EOF
{
  "SCHEMA_FILE": "$SCHEMA_FILE",
  "ANALYSIS_FILE": "$ANALYSIS_FILE",
  "KNOWLEDGE_DIR": "$KNOWLEDGE_DIR",
  "TIMESTAMP": "$TIMESTAMP",
  "REPO_ROOT": "$REPO_ROOT",
  "SCHEMA_FILTER": "$SCHEMA_FILTER"
}
EOF
else
    echo "Knowledge base schema analysis initialized:"
    echo "  Filter: ${SCHEMA_FILTER:-"None (Complete Schema)"}"
    echo "  Schema File: $SCHEMA_FILE"
    echo "  Analysis File: $ANALYSIS_FILE"
    echo "  Knowledge Directory: $KNOWLEDGE_DIR"
fi
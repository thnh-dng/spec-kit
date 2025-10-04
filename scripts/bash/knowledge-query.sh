#!/usr/bin/env bash

set -e

JSON_MODE=false
QUERY_INPUT=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] <knowledge_query_input>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

QUERY_INPUT="${ARGS[*]}"
if [ -z "$QUERY_INPUT" ]; then
    echo "Usage: $0 [--json] <knowledge_query_input>" >&2
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
QUERY_FILE="$KNOWLEDGE_DIR/kb-query-$TIMESTAMP.md"
RESULTS_FILE="$KNOWLEDGE_DIR/kb-query-results-$TIMESTAMP.md"

# Generate the query file
cat > "$QUERY_FILE" << EOF
# Knowledge Base Query

**Query ID**: kb-query-$TIMESTAMP
**Timestamp**: $(date)
**Query**: $QUERY_INPUT
**Status**: Executing

## Query Input
$QUERY_INPUT

## MCP Tools Used
- query: Search knowledge base for relevant information
- schema: Understand knowledge base structure
- stats: Get knowledge base statistics

## Execution Context
- Repository: $REPO_ROOT
- Knowledge Directory: $KNOWLEDGE_DIR
- Query File: $QUERY_FILE
- Results File: $RESULTS_FILE
EOF

if [ "$JSON_MODE" = true ]; then
    cat << EOF
{
  "QUERY_FILE": "$QUERY_FILE",
  "RESULTS_FILE": "$RESULTS_FILE",
  "KNOWLEDGE_DIR": "$KNOWLEDGE_DIR",
  "TIMESTAMP": "$TIMESTAMP",
  "REPO_ROOT": "$REPO_ROOT",
  "QUERY_INPUT": "$QUERY_INPUT"
}
EOF
else
    echo "Knowledge base query initialized:"
    echo "  Query: $QUERY_INPUT"
    echo "  Query File: $QUERY_FILE"
    echo "  Results File: $RESULTS_FILE"
    echo "  Knowledge Directory: $KNOWLEDGE_DIR"
fi
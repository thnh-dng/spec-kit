#!/usr/bin/env bash

set -e

JSON_MODE=false
INGEST_INPUT=""
USE_FAST_MODE=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --fast) USE_FAST_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] [--fast] <ingest_input>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

INGEST_INPUT="${ARGS[*]}"
if [ -z "$INGEST_INPUT" ]; then
    echo "Usage: $0 [--json] [--fast] <ingest_input>" >&2
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

# Determine if input is a file path or direct text
if [ -f "$INGEST_INPUT" ] || [[ "$INGEST_INPUT" == *.* ]]; then
    INGEST_TYPE="file"
    FILE_PATH=$(realpath "$INGEST_INPUT" 2>/dev/null || echo "$INGEST_INPUT")
    if [ ! -f "$FILE_PATH" ] && [[ "$INGEST_INPUT" == *.* ]]; then
        echo "Warning: File not found at $FILE_PATH, treating as direct text" >&2
        INGEST_TYPE="text"
        INGEST_CONTENT="$INGEST_INPUT"
    elif [ -f "$FILE_PATH" ]; then
        INGEST_CONTENT="$FILE_PATH"
    else
        INGEST_TYPE="text"
        INGEST_CONTENT="$INGEST_INPUT"
    fi
else
    INGEST_TYPE="text"
    INGEST_CONTENT="$INGEST_INPUT"
fi

# Create output files
INGEST_FILE="$KNOWLEDGE_DIR/kb-ingest-$TIMESTAMP.md"
LOG_FILE="$KNOWLEDGE_DIR/kb-ingest-log-$TIMESTAMP.md"

# Generate the ingest file
cat > "$INGEST_FILE" << EOF
# Knowledge Base Ingestion

**Ingestion ID**: kb-ingest-$TIMESTAMP
**Timestamp**: $(date)
**Ingestion Type**: $INGEST_TYPE
**Fast Mode**: $USE_FAST_MODE
**Status**: Processing

## Input
**Type**: $INGEST_TYPE
**Content**: $INGEST_CONTENT

## MCP Tools Used
- ingest: Process document file or text content
- ingest_spec: Ingest raw text content directly
- stats: Track knowledge base growth
- schema: Verify updated structure

## Execution Context
- Repository: $REPO_ROOT
- Knowledge Directory: $KNOWLEDGE_DIR
- Ingestion File: $INGEST_FILE
- Log File: $LOG_FILE

## Processing Strategy
- Fast Mode: $USE_FAST_MODE (recommended for large documents)
- Entity Extraction: Enabled
- Relationship Mapping: Enabled
- Business Rule Extraction: Enabled
- Pattern Recognition: Enabled
EOF

# Generate initial log
cat > "$LOG_FILE" << EOF
# Knowledge Base Ingestion Log

**Ingestion ID**: kb-ingest-$TIMESTAMP
**Start Time**: $(date)
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
- Input Type: $INGEST_TYPE
- Fast Mode: $USE_FAST_MODE
- Start Time: $(date)
- End Time: Pending
- Entities Extracted: Pending
- Relationships Mapped: Pending
- Processing Status: Pending
EOF

if [ "$JSON_MODE" = true ]; then
    cat << EOF
{
  "INGEST_FILE": "$INGEST_FILE",
  "LOG_FILE": "$LOG_FILE",
  "KNOWLEDGE_DIR": "$KNOWLEDGE_DIR",
  "TIMESTAMP": "$TIMESTAMP",
  "REPO_ROOT": "$REPO_ROOT",
  "INGEST_TYPE": "$INGEST_TYPE",
  "USE_FAST_MODE": "$USE_FAST_MODE",
  "INGEST_CONTENT": "$INGEST_CONTENT"
}
EOF
else
    echo "Knowledge base ingestion initialized:"
    echo "  Type: $INGEST_TYPE"
    echo "  Content: $INGEST_CONTENT"
    echo "  Fast Mode: $USE_FAST_MODE"
    echo "  Ingestion File: $INGEST_FILE"
    echo "  Log File: $LOG_FILE"
    echo "  Knowledge Directory: $KNOWLEDGE_DIR"
fi
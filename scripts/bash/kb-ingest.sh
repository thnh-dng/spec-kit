#!/usr/bin/env bash

set -e

JSON_MODE=false
INGEST_INPUT=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] <file_path_or_direct_text>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

INGEST_INPUT="${ARGS[*]}"

if [ -z "$INGEST_INPUT" ]; then
    echo "Usage: $0 [--json] <file_path_or_direct_text>" >&2
    exit 1
fi

# Function to find the repository root
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

# Resolve repository root
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

# Get current branch
CURRENT_BRANCH="unknown"
if [ "$HAS_GIT" = true ]; then
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
fi

# Determine input type and create names
if [[ "$INGEST_INPUT" == *"."* ]] && [ -f "$INGEST_INPUT" ]; then
    # File path input
    INPUT_TYPE="file"
    FILENAME=$(basename "$INGEST_INPUT")
    INGEST_NAME=$(echo "$FILENAME" | sed 's/\.[^.]*$//' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
    INPUT_DISPLAY="File: $INGEST_INPUT"
else
    # Direct text input
    INPUT_TYPE="text"
    INGEST_NAME=$(echo "$INGEST_INPUT" | head -c 20 | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
    INPUT_DISPLAY="Text: ${INGEST_INPUT:0:50}..."
fi

if [ -z "$INGEST_NAME" ]; then
    INGEST_NAME="knowledge-ingestion"
fi

# Create timestamp-based ingestion directory
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
INGEST_DIR="$REPO_ROOT/specs/knowledge-ingestion/$INGEST_NAME-$TIMESTAMP"
mkdir -p "$INGEST_DIR"

# Create ingestion report file
INGEST_REPORT_FILE="$INGEST_DIR/ingestion-report.md"

# Create knowledge directory for this ingestion
KNOWLEDGE_DIR="$INGEST_DIR/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

# Create extraction results directory
EXTRACTION_DIR="$INGEST_DIR/extraction"
mkdir -p "$EXTRACTION_DIR"

# Create validation directory
VALIDATION_DIR="$INGEST_DIR/validation"
mkdir -p "$VALIDATION_DIR"

# Create basic template for ingestion report
cat > "$INGEST_REPORT_FILE" << 'EOF'
# Knowledge Base Ingestion Report

**Ingestion ID**: knowledge-ingestion-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Input Type**: [File/Text]
**Input**: [Input description]
**Ingestion Strategy**: [Processing approach used]

## Input Analysis

### Content Overview
**Content Type**: [Type of content ingested]
**Content Size**: [Size and complexity assessment]
**Domain Context**: [Relevant domain areas]
**Expected Value**: [Anticipated knowledge value]

### Processing Strategy
**Ingestion Method**: [File processing vs direct text]
**Processing Mode**: [Fast vs comprehensive mode]
**Chunking Strategy**: [How content was divided if needed]
**Quality Focus**: [Quality assurance approach]

## Pre-Ingestion Assessment

### Knowledge Base State
**Current Statistics**: [Size and growth metrics]
**Existing Coverage**: [Relevant existing knowledge areas]
**Schema Compatibility**: [Compatibility with existing structure]
**Integration Potential**: [Expected integration benefits]

### Risk Assessment
**Quality Risks**: [Potential quality issues]
**Integration Risks**: [Potential integration challenges]
**Consistency Risks**: [Potential consistency issues]
**Mitigation Strategies**: [Risk mitigation approaches]

## Ingestion Execution

### Content Processing
**Preprocessing Steps**:
- [Step 1]: [Description and purpose]
- [Step 2]: [Description and purpose]

**Parsing Results**:
- [Parse Result 1]: [Success and details]
- [Parse Result 2]: [Success and details]

### Entity and Relationship Extraction
**Entities Extracted**:
- [Entity 1]: [Type, attributes, and confidence]
- [Entity 2]: [Type, attributes, and confidence]

**Relationships Mapped**:
- [Relationship 1]: [Entities, type, and confidence]
- [Relationship 2]: [Entities, type, and confidence]

**Business Rules Identified**:
- [Rule 1]: [Description, scope, and confidence]
- [Rule 2]: [Description, scope, and confidence]

### Pattern and Component Extraction
**Patterns Discovered**:
- [Pattern 1]: [Description, context, and applicability]
- [Pattern 2]: [Description, context, and applicability]

**Components Identified**:
- [Component 1]: [Type, purpose, and relationships]
- [Component 2]: [Type, purpose, and relationships]

## Quality Validation

### Extraction Quality
**Entity Quality**: [Assessment of entity extraction accuracy]
**Relationship Quality**: [Assessment of relationship mapping accuracy]
**Rule Quality**: [Assessment of business rule extraction quality]
**Pattern Quality**: [Assessment of pattern identification quality]

### Consistency Validation
**Internal Consistency**: [Consistency within extracted knowledge]
**External Consistency**: [Consistency with existing knowledge base]
**Logical Consistency**: [Logical soundness of extracted information]
**Domain Consistency**: [Consistency with domain understanding]

### Completeness Assessment
**Coverage Analysis**: [How well the content was covered]
**Gap Identification**: [Areas where extraction may be incomplete]
**Confidence Levels**: [Overall confidence in extraction results]
**Quality Metrics**: [Quantitative quality measures]

## Integration Analysis

### Knowledge Base Impact
**New Knowledge Added**:
- [Knowledge Item 1]: [Type, significance, and integration]
- [Knowledge Item 2]: [Type, significance, and integration]

**Enhanced Understanding**:
- [Enhancement 1]: [Area of improvement]
- [Enhancement 2]: [Area of improvement]

**Relationship Strengthening**:
- [Relationship 1]: [New or strengthened connections]
- [Relationship 2]: [New or strengthened connections]

### Value Assessment
**Immediate Value**: [Short-term benefits of ingestion]
**Long-term Value**: [Long-term strategic benefits]
**Multiplier Effects**: [How this enhances other knowledge]
**Innovation Potential**: [Potential for new insights and approaches]

## Quality Improvement Recommendations

### Processing Enhancements
**Extraction Improvements**:
- [Improvement 1]: [Description and expected benefit]
- [Improvement 2]: [Description and expected benefit]

**Quality Control Enhancements**:
- [Enhancement 1]: [Description and expected benefit]
- [Enhancement 2]: [Description and expected benefit]

### Knowledge Base Enhancements
**Schema Improvements**:
- [Improvement 1]: [Description and rationale]
- [Improvement 2]: [Description and rationale]

**Organization Enhancements**:
- [Enhancement 1]: [Description and benefits]
- [Enhancement 2]: [Description and benefits]

## Performance Metrics

### Ingestion Performance
**Processing Time**: [Time taken for ingestion]
**Memory Usage**: [Memory consumption during processing]
**CPU Utilization**: [Processor usage during processing]
**Success Rate**: [Percentage of successful extractions]

### Quality Metrics
**Accuracy Score**: [Overall accuracy of extraction]
**Completeness Score**: [Completeness of knowledge extraction]
**Consistency Score**: [Consistency with existing knowledge]
**Actionability Score**: [Usability of extracted knowledge]

## Follow-up Actions

### Immediate Actions
**Knowledge Base Updates**:
- [Action 1]: [Description and priority]
- [Action 2]: [Description and priority]

**Quality Assurance**:
- [Action 1]: [Description and priority]
- [Action 2]: [Description and priority]

### Future Enhancements
**Process Improvements**:
- [Improvement 1]: [Description and timeline]
- [Improvement 2]: [Description and timeline]

**Knowledge Base Development**:
- [Development 1]: [Description and timeline]
- [Development 2]: [Description and timeline]

## Lessons Learned

### Success Factors
- [Success Factor 1]: [Description and impact]
- [Success Factor 2]: [Description and impact]

### Challenges Addressed
- [Challenge 1]: [Description and resolution]
- [Challenge 2]: [Description and resolution]

### Best Practices Identified
- [Best Practice 1]: [Description and applicability]
- [Best Practice 2]: [Description and applicability]

---

**Ingestion Status**:
- [ ] Input analyzed and processed
- [ ] Entity and relationship extraction completed
- [ ] Business rules and patterns identified
- [ ] Quality validation performed
- [ ] Integration analysis completed
- [ ] Value assessment conducted
- [ ] Performance metrics collected
- [ ] Recommendations generated
- [ ] Follow-up actions identified
- [ ] Lessons learned documented

EOF

if $JSON_MODE; then
    printf '{"INGEST_DIR":"%s","INGEST_REPORT_FILE":"%s","KNOWLEDGE_DIR":"%s","EXTRACTION_DIR":"%s","VALIDATION_DIR":"%s","INGEST_NAME":"%s","INPUT_TYPE":"%s","CURRENT_BRANCH":"%s","TIMESTAMP":"%s"}\n' \
        "$INGEST_DIR" "$INGEST_REPORT_FILE" "$KNOWLEDGE_DIR" "$EXTRACTION_DIR" "$VALIDATION_DIR" "$INGEST_NAME" "$INPUT_TYPE" "$CURRENT_BRANCH" "$TIMESTAMP"
else
    echo "INGEST_DIR: $INGEST_DIR"
    echo "INGEST_REPORT_FILE: $INGEST_REPORT_FILE"
    echo "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    echo "EXTRACTION_DIR: $EXTRACTION_DIR"
    echo "VALIDATION_DIR: $VALIDATION_DIR"
    echo "INGEST_NAME: $INGEST_NAME"
    echo "INPUT_TYPE: $INPUT_TYPE"
    echo "CURRENT_BRANCH: $CURRENT_BRANCH"
    echo "TIMESTAMP: $TIMESTAMP"
    echo ""
    echo "Ready for knowledge base ingestion."
    echo "$INPUT_DISPLAY"
    echo ""
    echo "The AI will now:"
    echo "1. Analyze input type and develop ingestion strategy"
    echo "2. Process content and extract entities, relationships, and patterns"
    echo "3. Validate extraction quality and consistency"
    echo "4. Analyze integration impact and value"
    echo "5. Provide quality improvement recommendations"
    echo "6. Generate comprehensive ingestion report"
    echo ""
    echo "Knowledge base ingestion will be performed in the current branch context."
fi
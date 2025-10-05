#!/usr/bin/env bash

set -e

JSON_MODE=false
QUERY_INPUT=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] <query>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

QUERY_INPUT="${ARGS[*]}"

if [ -z "$QUERY_INPUT" ]; then
    echo "Usage: $0 [--json] <query>" >&2
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

# Create query name from input
QUERY_NAME=$(echo "$QUERY_INPUT" | head -c 30 | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
if [ -z "$QUERY_NAME" ]; then
    QUERY_NAME="knowledge-query"
fi

# Create timestamp-based query directory
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
QUERY_DIR="$REPO_ROOT/specs/knowledge-queries/$QUERY_NAME-$TIMESTAMP"
mkdir -p "$QUERY_DIR"

# Create query results file
QUERY_RESULTS_FILE="$QUERY_DIR/query-results.md"

# Create knowledge directory for this query
KNOWLEDGE_DIR="$QUERY_DIR/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

# Create basic template for query results
cat > "$QUERY_RESULTS_FILE" << 'EOF'
# Knowledge Base Query Results

**Query ID**: knowledge-query-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Query**: [Original query text]
**Query Type**: [Query type analysis]

## Query Analysis

### Query Intent
- **Primary Goal**: [Main information goal]
- **Query Type**: [Factual/Relational/Pattern/Analytical]
- **Expected Results**: [What kind of information was sought]
- **Context**: [Project or domain context]

### Query Strategy
- **Search Approach**: [How the query was optimized]
- **Scope**: [Search scope and boundaries]
- **Complexity**: [Query complexity assessment]
- **Follow-up**: [Planned follow-up queries]

## Query Results

### Primary Results
**Direct Matches Found**:
- [Result 1]: [Relevance and significance]
- [Result 2]: [Relevance and significance]

**Key Entities Identified**:
- [Entity 1]: [Description and relationships]
- [Entity 2]: [Description and relationships]

**Relationships Mapped**:
- [Relationship 1]: [Description and significance]
- [Relationship 2]: [Description and significance]

### Supplementary Results
**Related Concepts**:
- [Concept 1]: [Connection to query]
- [Concept 2]: [Connection to query]

**Supporting Evidence**:
- [Evidence 1]: [Source and relevance]
- [Evidence 2]: [Source and relevance]

### Patterns and Insights
**Discovered Patterns**:
- [Pattern 1]: [Description and applicability]
- [Pattern 2]: [Description and applicability]

**Key Insights**:
- [Insight 1]: [Significance and implications]
- [Insight 2]: [Significance and implications]

## Context and Interpretation

### Domain Context
**Relevant Domain Areas**:
- [Domain 1]: [Relevance and connection]
- [Domain 2]: [Relevance and connection]

**Business Context**:
- [Business Area 1]: [Relevance and impact]
- [Business Area 2]: [Relevance and impact]

### Technical Context
**Implementation Context**:
- [Technology 1]: [Relevance and considerations]
- [Technology 2]: [Relevance and considerations]

**Integration Context**:
- [Integration Point 1]: [Relevance and requirements]
- [Integration Point 2]: [Relevance and requirements]

## Actionable Recommendations

### Immediate Actions
**Based on Query Results**:
1. [Action 1]: [Description and rationale]
2. [Action 2]: [Description and rationale]

### Implementation Guidance
**Technical Recommendations**:
- [Recommendation 1]: [Description and benefits]
- [Recommendation 2]: [Description and benefits]

**Architecture Considerations**:
- [Consideration 1]: [Impact and implications]
- [Consideration 2]: [Impact and implications]

### Follow-up Queries
**Related Queries to Consider**:
- [Query 1]: [Rationale and expected value]
- [Query 2]: [Rationale and expected value]

## Quality Assessment

### Result Quality
**Relevance Score**: [Score out of 100]
**Completeness Score**: [Score out of 100]
**Accuracy Score**: [Score out of 100]
**Actionability Score**: [Score out of 100]

### Knowledge Base Insights
**Coverage Analysis**:
- [Strength 1]: [Areas of good coverage]
- [Gap 1]: [Areas needing additional knowledge]

**Query Effectiveness**:
- [Success Factor 1]: [What worked well]
- [Improvement Area 1]: [Areas for query refinement]

## Source References

### Primary Sources
- [Source 1]: [Description and relevance]
- [Source 2]: [Description and relevance]

### Supporting Documentation
- [Document 1]: [Description and relevance]
- [Document 2]: [Description and relevance]

## Next Steps

### Immediate Next Steps
1. [Step 1]: [Description and timeline]
2. [Step 2]: [Description and timeline]

### Knowledge Base Enhancement
**Suggested Additions**:
- [Addition 1]: [Description and value]
- [Addition 2]: [Description and value]

### Process Improvements
**Query Optimization**:
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

---

**Query Status**:
- [ ] Query intent analyzed
- [ ] Query strategy developed
- [ ] Primary query executed
- [ ] Supplementary queries performed
- [ ] Results synthesized and analyzed
- [ ] Context and interpretation provided
- [ ] Recommendations generated
- [ ] Quality assessment completed
- [ ] Next steps identified
- [ ] Knowledge base insights documented

EOF

if $JSON_MODE; then
    printf '{"QUERY_DIR":"%s","QUERY_RESULTS_FILE":"%s","KNOWLEDGE_DIR":"%s","QUERY_NAME":"%s","CURRENT_BRANCH":"%s","TIMESTAMP":"%s"}\n' \
        "$QUERY_DIR" "$QUERY_RESULTS_FILE" "$KNOWLEDGE_DIR" "$QUERY_NAME" "$CURRENT_BRANCH" "$TIMESTAMP"
else
    echo "QUERY_DIR: $QUERY_DIR"
    echo "QUERY_RESULTS_FILE: $QUERY_RESULTS_FILE"
    echo "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    echo "QUERY_NAME: $QUERY_NAME"
    echo "CURRENT_BRANCH: $CURRENT_BRANCH"
    echo "TIMESTAMP: $TIMESTAMP"
    echo ""
    echo "Ready for knowledge base query."
    echo "Query: $QUERY_INPUT"
    echo ""
    echo "The AI will now:"
    echo "1. Analyze query intent and develop search strategy"
    echo "2. Execute knowledge base queries with optimization"
    echo "3. Synthesize results and extract actionable insights"
    echo "4. Provide context-specific recommendations"
    echo "5. Assess query effectiveness and knowledge base quality"
    echo "6. Suggest follow-up actions and improvements"
    echo ""
    echo "Knowledge base query will be performed in the current branch context."
fi
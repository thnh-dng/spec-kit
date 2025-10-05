#!/usr/bin/env bash

set -e

JSON_MODE=false
FEATURE_CONTEXT=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] [feature_context]"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

FEATURE_INPUT="${ARGS[*]}"

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

# Determine feature context
FEATURE_NAME=""
FEATURE_DIR=""

# Check if we're in a feature directory
if [[ "$PWD" == *"/features/"* ]]; then
    CURRENT_DIR=$(basename "$PWD")
    if [[ "$CURRENT_DIR" != "features" ]]; then
        FEATURE_NAME="$CURRENT_DIR"
        FEATURE_DIR="$PWD"
    fi
fi

# If no feature detected, try to find feature from input
if [ -z "$FEATURE_NAME" ] && [ -n "$FEATURE_INPUT" ]; then
    # Try to extract feature name from input
    FEATURE_NAME=$(echo "$FEATURE_INPUT" | head -c 30 | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
    if [ -d "$REPO_ROOT/features/$FEATURE_NAME" ]; then
        FEATURE_DIR="$REPO_ROOT/features/$FEATURE_NAME"
    fi
fi

# Create timestamp-based Event Storming directory
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
if [ -n "$FEATURE_NAME" ]; then
    EVENT_STORMING_DIR="$REPO_ROOT/features/$FEATURE_NAME/event-storming-$TIMESTAMP"
    ANALYSIS_NAME="feature-$FEATURE_NAME"
else
    EVENT_STORMING_DIR="$REPO_ROOT/specs/feature-event-storming-$TIMESTAMP"
    ANALYSIS_NAME="feature-event-storming"
fi

mkdir -p "$EVENT_STORMING_DIR"

# Create Event Storming output file
EVENT_STORMING_FILE="$EVENT_STORMING_DIR/feature-event-storming.drawio"

# Create knowledge directory
KNOWLEDGE_DIR="$EVENT_STORMING_DIR/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

# Create feature Event Storming report file
FEATURE_REPORT_FILE="$EVENT_STORMING_DIR/feature-event-storming-report.md"

# Create basic template for feature Event Storming report
cat > "$FEATURE_REPORT_FILE" << 'EOF'
# Feature-Level Event Storming Report

**Feature**: [Feature Name]
**Analysis ID**: feature-event-storming-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Feature Context**: [Feature context or current working directory]

## Feature Context

### Feature Overview
**Feature Name**: [Feature Name]
**Feature Scope**: [Clear, concrete scope]
**Business Value**: [Specific value proposition]
**Current Status**: [Specification/Clarification/Planning]

### Feature Requirements
**Concrete Requirements**:
- [Requirement 1]: [Specific, implementable requirement]
- [Requirement 2]: [Specific, implementable requirement]
- [Requirement 3]: [Specific, implementable requirement]

**Business Rules**:
- [Rule 1]: [Specific business rule]
- [Rule 2]: [Specific business rule]

**Validation Logic**:
- [Validation 1]: [Clear validation criteria]
- [Validation 2]: [Clear validation criteria]

### Domain Context
**Bounded Context**: [Relevant bounded context from high-level model]
**Related Aggregates**: [Existing aggregates from high-level model]
**Domain Events**: [Relevant high-level events]
**Business Processes**: [Related business processes]

## Feature Event Storming Results

### Domain Events (Feature-Level)
- **[Event 1 Name]**: [Business significance and triggers]
- **[Event 2 Name]**: [Business significance and triggers]
- **[Event 3 Name]**: [Business significance and triggers]

### Commands and User Interactions
- **[Command 1 Name]**: [User action and business operation]
- **[Command 2 Name]**: [User action and business operation]

### Feature Aggregates and Entities
**Aggregates**:
- **[Aggregate 1 Name]**: [Entities and business rules]
- **[Aggregate 2 Name]**: [Entities and business rules]

**Entities**:
- **[Entity 1 Name]**: [Attributes and responsibilities]
- **[Entity 2 Name]**: [Attributes and responsibilities]

### Feature Business Processes
**Process 1**: [Detailed feature workflow]
- Step 1: [Specific action]
- Step 2: [Specific action]
- Step 3: [Specific action]

**Process 2**: [Detailed feature workflow]
- Step 1: [Specific action]
- Step 2: [Specific action]

### Integration Points
**External Dependencies**:
- [System 1]: [Integration purpose and requirements]
- [System 2]: [Integration purpose and requirements]

**Internal Dependencies**:
- [Feature/Component 1]: [Dependency description]
- [Feature/Component 2]: [Dependency description]

## Implementation Guidance

### Data Model Implications
**New Entities**: [List of new entities]
**Modified Entities**: [List of modified entities]
**Relationships**: [New or modified relationships]

### API and Integration Requirements
**API Endpoints**: [Required API endpoints]
**Data Contracts**: [Data structures and schemas]
**Event Contracts**: [Event structures and payloads]

### Business Rule Implementation
**Validation Logic**: [Implementation approach for validation]
**Business Rules**: [Implementation approach for business rules]
**Error Handling**: [Implementation approach for error handling]

## Big Model Update Recommendations

### New Domain Elements
**New Events**: [Events to add to high-level model]
**New Aggregates**: [Aggregates to add to high-level model]
**New Business Rules**: [Rules to add to high-level model]

### Model Enhancements
**Aggregate Refinements**: [Improvements to existing aggregates]
**Process Refinements**: [Improvements to existing processes]
**Integration Enhancements**: [New integration capabilities]

## Next Steps

### Immediate Actions
1. **Proceed to Planning**: `/plan "feature implementation"`
2. **Update Big Model**: Apply big model update recommendations
3. **Implementation**: Begin feature implementation with domain model guidance

### Success Criteria
- [ ] All feature business rules are documented
- [ ] Integration points are clearly specified
- [ ] Implementation guidance is actionable
- [ ] Domain model is consistent with high-level model
- [ ] Development team has clear understanding

---

**Execution Status**:
- [ ] Feature context analyzed
- [ ] Domain context extracted
- [ ] Event Storming executed
- [ ] Feature domain model created
- [ ] Implementation guidance prepared
- [ ] Big model update recommendations made
- [ ] Knowledge base enriched
- [ ] Implementation readiness assessed

EOF

if $JSON_MODE; then
    printf '{"EVENT_STORMING_DIR":"%s","EVENT_STORMING_FILE":"%s","FEATURE_REPORT_FILE":"%s","KNOWLEDGE_DIR":"%s","FEATURE_NAME":"%s","FEATURE_DIR":"%s","CURRENT_BRANCH":"%s","TIMESTAMP":"%s"}\n' \
        "$EVENT_STORMING_DIR" "$EVENT_STORMING_FILE" "$FEATURE_REPORT_FILE" "$KNOWLEDGE_DIR" "$FEATURE_NAME" "$FEATURE_DIR" "$CURRENT_BRANCH" "$TIMESTAMP"
else
    echo "EVENT_STORMING_DIR: $EVENT_STORMING_DIR"
    echo "EVENT_STORMING_FILE: $EVENT_STORMING_FILE"
    echo "FEATURE_REPORT_FILE: $FEATURE_REPORT_FILE"
    echo "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    echo "FEATURE_NAME: $FEATURE_NAME"
    echo "FEATURE_DIR: $FEATURE_DIR"
    echo "CURRENT_BRANCH: $CURRENT_BRANCH"
    echo "TIMESTAMP: $TIMESTAMP"
    echo ""
    echo "Ready for feature-level Event Storming."
    if [ -n "$FEATURE_NAME" ]; then
        echo "Working with feature: $FEATURE_NAME"
    else
        echo "No specific feature detected - will work with provided context or current directory"
    fi
    echo ""
    echo "The AI will now:"
    echo "1. Analyze feature context and requirements"
    echo "2. Query knowledge base for relevant domain intelligence"
    echo "3. Execute feature-level Event Storming for detailed domain modeling"
    echo "4. Create feature-specific domain model and implementation guidance"
    echo "5. Prepare big model update recommendations"
    echo "6. Enrich knowledge base with feature-specific insights"
    echo ""
    echo "Feature-level Event Storming will be performed in the current branch context."
fi
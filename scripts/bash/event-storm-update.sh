#!/usr/bin/env bash

set -e

JSON_MODE=false
UPDATE_SCOPE=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] [update_scope]"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

UPDATE_INPUT="${ARGS[*]}"

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

# Create update scope name
if [ -n "$UPDATE_INPUT" ]; then
    SCOPE_NAME=$(echo "$UPDATE_INPUT" | head -c 30 | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
else
    SCOPE_NAME="comprehensive"
fi

# Create timestamp-based update directory
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
UPDATE_DIR="$REPO_ROOT/specs/big-model-update-$SCOPE_NAME-$TIMESTAMP"
mkdir -p "$UPDATE_DIR"

# Create update report file
UPDATE_REPORT_FILE="$UPDATE_DIR/big-model-update-report.md"

# Create knowledge directory
KNOWLEDGE_DIR="$UPDATE_DIR/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

# Create changes directory
CHANGES_DIR="$UPDATE_DIR/changes"
mkdir -p "$CHANGES_DIR"

# Create validation directory
VALIDATION_DIR="$UPDATE_DIR/validation"
mkdir -p "$VALIDATION_DIR"

# Create basic template for big model update report
cat > "$UPDATE_REPORT_FILE" << 'EOF'
# Big Model Update Report

**Update ID**: big-model-update-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Update Scope**: [Update scope or comprehensive]
**Update Focus**: [Specific focus area or comprehensive big model synchronization]

## Executive Summary

[High-level summary of big model updates, key changes, and impact on domain understanding]

## Update Overview

### Update Objectives
- **Primary Goal**: [Main update objective]
- **Scope**: [Update scope and boundaries]
- **Success Criteria**: [Measurable success criteria]
- **Key Metrics**: [Metrics used for evaluation]

### Update Methodology
- **Analysis Approach**: [How feature insights were analyzed]
- **Integration Strategy**: [How insights were integrated into big model]
- **Validation Method**: [How consistency was validated]
- **Quality Assurance**: [Quality measures applied]

## Current Big Model State

### High-Level Domain Model Structure
**Bounded Contexts**:
- [Context 1]: [Description and scope]
- [Context 2]: [Description and scope]

**Major Aggregates**:
- [Aggregate 1]: [Entities and responsibilities]
- [Aggregate 2]: [Entities and responsibilities]

**Domain Events**:
- [Event 1]: [Business significance and triggers]
- [Event 2]: [Business significance and triggers]

### Business Rules and Constraints
**Key Business Rules**:
- [Rule 1]: [Description and scope]
- [Rule 2]: [Description and scope]

**Domain Constraints**:
- [Constraint 1]: [Description and impact]
- [Constraint 2]: [Description and impact]

## Feature Insights Analysis

### Features Analyzed for Update
**Feature-Level Event Storming Results**:
- [Feature 1]: [Key insights and domain contributions]
- [Feature 2]: [Key insights and domain contributions]

**Feature-to-Domain Mapping**:
- [Feature 1]: [Relationship to big model elements]
- [Feature 2]: [Relationship to big model elements]

### New Domain Elements Discovered
**New Entities**:
- [Entity 1]: [Description and relationships]
- [Entity 2]: [Description and relationships]

**New Relationships**:
- [Relationship 1]: [Description and significance]
- [Relationship 2]: [Description and significance]

**New Business Rules**:
- [Rule 1]: [Description and applicability]
- [Rule 2]: [Description and applicability]

## Big Model Updates Applied

### Entity and Relationship Updates
**Added Entities**:
- [Entity 1]: [Rationale for addition]
- [Entity 2]: [Rationale for addition]

**Refined Entities**:
- [Entity 1]: [Refinements made and rationale]
- [Entity 2]: [Refinements made and rationale]

**New Relationships**:
- [Relationship 1]: [Description and impact]
- [Relationship 2]: [Description and impact]

### Business Rule Enhancements
**Added Business Rules**:
- [Rule 1]: [Source feature and business value]
- [Rule 2]: [Source feature and business value]

**Refined Business Rules**:
- [Rule 1]: [Refinements and source insights]
- [Rule 2]: [Refinements and source insights]

**Constraint Updates**:
- [Constraint 1]: [Updates and rationale]
- [Constraint 2]: [Updates and rationale]

### Domain Event and Process Updates
**New Domain Events**:
- [Event 1]: [Source feature and significance]
- [Event 2]: [Source feature and significance]

**Refined Domain Events**:
- [Event 1]: [Refinements and feature insights]
- [Event 2]: [Refinements and feature insights]

**Process Enhancements**:
- [Process 1]: [Enhancements and feature workflows]
- [Process 2]: [Enhancements and feature workflows]

## Integration Point Synchronization

### External System Integration Updates
**API Contract Updates**:
- [Endpoint 1]: [Updates and feature requirements]
- [Endpoint 2]: [Updates and feature requirements]

**Data Model Enhancements**:
- [Model 1]: [Enhancements and rationale]
- [Model 2]: [Enhancements and rationale]

### Cross-Context Communication
**Event-Driven Updates**:
- [Event 1]: [Enhanced communication pattern]
- [Event 2]: [Enhanced communication pattern]

**Integration Patterns**:
- [Pattern 1]: [Refinements and feature insights]
- [Pattern 2]: [Refinements and feature insights]

## Consistency Validation Results

### Model Consistency Validation
**Big Model vs Feature Consistency**:
- ✅ **Consistent**: [Areas of consistency]
- ❌ **Inconsistencies Resolved**: [Resolved inconsistencies]
- ⚠️ **Areas Requiring Attention**: [Areas needing monitoring]

**Cross-Feature Consistency**:
- ✅ **Consistent**: [Consistent elements across features]
- ❌ **Conflicts Addressed**: [Conflicts resolved]
- ⚠️ **Variations Managed**: [Managed variations]

### Business Rule Consistency
**Rule Validation Results**:
- ✅ **Consistent**: [Consistent business rules]
- ❌ **Conflicts Resolved**: [Resolved conflicts]
- ⚠️ **Clarifications Needed**: [Areas requiring clarification]

**Constraint Validation**:
- ✅ **Consistent**: [Consistent constraints]
- ❌ **Conflicts Addressed**: [Addressed conflicts]
- ⚠️ **Refinements Made**: [Constraint refinements]

## Quality Assessment

### Model Quality Metrics
**Completeness Score**: [Score out of 100]
**Consistency Score**: [Score out of 100]
**Accuracy Score**: [Score out of 100]
**Actionability Score**: [Score out of 100]

### Integration Quality Metrics
**Feature Integration Score**: [Score out of 100]
**Knowledge Base Integration Score**: [Score out of 100]
**Implementation Guidance Score**: [Score out of 100]

## Pattern and Best Practice Integration

### Successful Patterns Identified
**Cross-Feature Patterns**:
- [Pattern 1]: [Description and applicability]
- [Pattern 2]: [Description and applicability]

**Implementation Best Practices**:
- [Practice 1]: [Description and benefits]
- [Practice 2]: [Description and benefits]

### Anti-Patterns Documented
**Anti-Patterns Avoided**:
- [Anti-pattern 1]: [Description and alternative]
- [Anti-pattern 2]: [Description and alternative]

## Documentation Updates

### Updated Artifacts
**Domain Model Diagrams**:
- [Diagram 1]: [Updates made]
- [Diagram 2]: [Updates made]

**Documentation Sections**:
- [Section 1]: [Updates and improvements]
- [Section 2]: [Updates and improvements]

### Change Tracking
**Version Changes**:
- [Change 1]: [Description and impact]
- [Change 2]: [Description and impact]

**Decision Log**:
- [Decision 1]: [Rationale and impact]
- [Decision 2]: [Rationale and impact]

## Knowledge Base Enhancement

### New Knowledge Added
- [Knowledge item 1]: [Description and value]
- [Knowledge item 2]: [Description and value]

### Knowledge Base Improvements
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

## Impact Analysis

### Impact on Existing Features
**Features Affected**:
- [Feature 1]: [Impact and considerations]
- [Feature 2]: [Impact and considerations]

**Migration Requirements**:
- [Requirement 1]: [Description and timeline]
- [Requirement 2]: [Description and timeline]

### Impact on Future Development
**Development Guidance**:
- [Guidance 1]: [Updated approach and rationale]
- [Guidance 2]: [Updated approach and rationale]

**Planning Considerations**:
- [Consideration 1]: [Impact on future planning]
- [Consideration 2]: [Impact on future planning]

## Next Steps and Recommendations

### Immediate Actions (Next 1-2 weeks)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Short-term Actions (Next 1-2 months)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Long-term Maintenance
- [Activity 1]: [Frequency and responsibility]
- [Activity 2]: [Frequency and responsibility]

## Success Metrics and Monitoring

### Key Metrics to Track
- [Metric 1]: [Target value and measurement approach]
- [Metric 2]: [Target value and measurement approach]

### Monitoring Approach
- [Monitoring method 1]: [Frequency and responsibility]
- [Monitoring method 2]: [Frequency and responsibility]

## Conclusion

[Summary of update outcomes, key achievements, and future directions]

---

**Update Status**:
- [ ] Feature insights analyzed
- [ ] Big model updates planned
- [ ] Entity and relationship updates applied
- [ ] Business rules and constraints updated
- [ ] Domain events and processes enhanced
- [ ] Integration points synchronized
- [ ] Consistency validation completed
- [ ] Quality assessment performed
- [ ] Documentation updated
- [ ] Knowledge base enhanced
- [ ] Impact analysis completed

EOF

if $JSON_MODE; then
    printf '{"UPDATE_DIR":"%s","UPDATE_REPORT_FILE":"%s","KNOWLEDGE_DIR":"%s","CHANGES_DIR":"%s","VALIDATION_DIR":"%s","SCOPE_NAME":"%s","CURRENT_BRANCH":"%s","TIMESTAMP":"%s"}\n' \
        "$UPDATE_DIR" "$UPDATE_REPORT_FILE" "$KNOWLEDGE_DIR" "$CHANGES_DIR" "$VALIDATION_DIR" "$SCOPE_NAME" "$CURRENT_BRANCH" "$TIMESTAMP"
else
    echo "UPDATE_DIR: $UPDATE_DIR"
    echo "UPDATE_REPORT_FILE: $UPDATE_REPORT_FILE"
    echo "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    echo "CHANGES_DIR: $CHANGES_DIR"
    echo "VALIDATION_DIR: $VALIDATION_DIR"
    echo "SCOPE_NAME: $SCOPE_NAME"
    echo "CURRENT_BRANCH: $CURRENT_BRANCH"
    echo "TIMESTAMP: $TIMESTAMP"
    echo ""
    echo "Ready for big model synchronization and update."
    if [ -n "$UPDATE_INPUT" ]; then
        echo "Update scope: $UPDATE_INPUT"
    else
        echo "Update scope: Comprehensive (all feature insights)"
    fi
    echo ""
    echo "The AI will now:"
    echo "1. Analyze current big model and feature insights"
    echo "2. Identify updates needed for domain model synchronization"
    echo "3. Apply entity, relationship, and business rule updates"
    echo "4. Synchronize integration points and processes"
    echo "5. Validate consistency and quality of updated model"
    echo "6. Enhance knowledge base with updated domain insights"
    echo "7. Generate comprehensive update report and recommendations"
    echo ""
    echo "Big model update will be performed in the current branch context."
fi
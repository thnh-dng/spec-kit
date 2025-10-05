#!/usr/bin/env bash

set -e

JSON_MODE=false
ANALYSIS_SCOPE=""
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] [analysis_scope]"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

ANALYSIS_INPUT="${ARGS[*]}"

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

# Create analysis scope name
if [ -n "$ANALYSIS_INPUT" ]; then
    SCOPE_NAME=$(echo "$ANALYSIS_INPUT" | head -c 30 | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
else
    SCOPE_NAME="comprehensive"
fi

# Create timestamp-based analysis directory
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
ANALYSIS_DIR="$REPO_ROOT/specs/event-storming-analysis-$SCOPE_NAME-$TIMESTAMP"
mkdir -p "$ANALYSIS_DIR"

# Create analysis report file
ANALYSIS_REPORT_FILE="$ANALYSIS_DIR/cross-artifact-analysis-report.md"

# Create knowledge directory
KNOWLEDGE_DIR="$ANALYSIS_DIR/knowledge"
mkdir -p "$KNOWLEDGE_DIR"

# Create findings directory
FINDINGS_DIR="$ANALYSIS_DIR/findings"
mkdir -p "$FINDINGS_DIR"

# Create recommendations directory
RECOMMENDATIONS_DIR="$ANALYSIS_DIR/recommendations"
mkdir -p "$RECOMMENDATIONS_DIR"

# Create basic template for cross-artifact analysis report
cat > "$ANALYSIS_REPORT_FILE" << 'EOF'
# Cross-Artifact Event Storming Analysis Report

**Analysis ID**: event-storming-analysis-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Analysis Scope**: [Analysis scope or comprehensive]
**Analysis Focus**: [Specific focus area or comprehensive analysis]

## Executive Summary

[High-level summary of analysis findings, key insights, and recommendations]

## Analysis Overview

### Analysis Objectives
- **Primary Goal**: [Main analysis objective]
- **Scope**: [Analysis scope and boundaries]
- **Success Criteria**: [Measurable success criteria]
- **Key Metrics**: [Metrics used for evaluation]

### Analysis Methodology
- **Artifact Discovery**: [How artifacts were discovered and collected]
- **Consistency Validation**: [Approach for validating consistency]
- **Gap Analysis**: [Method for identifying gaps and conflicts]
- **Quality Assessment**: [Quality evaluation approach]

## Artifacts Analyzed

### High-Level Domain Models
**Domain Event Storming Diagrams**:
- [Diagram 1]: [Location and description]
- [Diagram 2]: [Location and description]

**Domain Analysis Reports**:
- [Report 1]: [Location and description]
- [Report 2]: [Location and description]

### Feature-Level Domain Models
**Feature Event Storming Reports**:
- [Feature 1]: [Location and description]
- [Feature 2]: [Location and description]

**Feature Domain Models**:
- [Feature 1]: [Key domain elements]
- [Feature 2]: [Key domain elements]

### Knowledge Base Artifacts
**Domain Intelligence**:
- [Entity 1]: [Description and relationships]
- [Relationship 1]: [Description and scope]

**Business Rules and Patterns**:
- [Pattern 1]: [Description and usage]
- [Rule 1]: [Description and scope]

## Consistency Validation Results

### Model Consistency
**High-Level vs Feature-Level Consistency**:
- ✅ **Consistent**: [Areas of consistency]
- ❌ **Inconsistent**: [Areas of inconsistency]
- ⚠️ **Needs Clarification**: [Areas needing clarification]

**Cross-Feature Consistency**:
- ✅ **Consistent**: [Consistent elements across features]
- ❌ **Conflicts**: [Conflicting definitions or approaches]
- ⚠️ **Variations**: [Acceptable variations and differences]

### Business Rule Consistency
**Rule Validation**:
- ✅ **Consistent**: [Consistent business rules]
- ❌ **Conflicting**: [Conflicting business rules]
- ⚠️ **Incomplete**: [Incomplete or unclear rules]

**Constraint Validation**:
- ✅ **Consistent**: [Consistent constraints]
- ❌ **Conflicting**: [Conflicting constraints]
- ⚠️ **Missing**: [Missing constraints]

## Gap and Conflict Analysis

### Identified Gaps
**Missing Domain Elements**:
- [Gap 1]: [Description and impact]
- [Gap 2]: [Description and impact]

**Incomplete Coverage**:
- [Area 1]: [Incomplete coverage description]
- [Area 2]: [Incomplete coverage description]

### Identified Conflicts
**Definition Conflicts**:
- [Conflict 1]: [Conflicting definitions and resolution]
- [Conflict 2]: [Conflicting definitions and resolution]

**Responsibility Conflicts**:
- [Conflict 1]: [Conflicting responsibilities and resolution]
- [Conflict 2]: [Conflicting responsibilities and resolution]

### Integration Challenges
**Integration Point Issues**:
- [Challenge 1]: [Integration challenge and solution]
- [Challenge 2]: [Integration challenge and solution]

**Cross-Context Issues**:
- [Issue 1]: [Cross-context issue and impact]
- [Issue 2]: [Cross-context issue and impact]

## Pattern and Quality Analysis

### Discovered Patterns
**Common Domain Patterns**:
- [Pattern 1]: [Description and usage across features]
- [Pattern 2]: [Description and usage across features]

**Successful Approaches**:
- [Approach 1]: [Description and benefits]
- [Approach 2]: [Description and benefits]

### Anti-Patterns and Issues
**Identified Anti-Patterns**:
- [Anti-pattern 1]: [Description and recommended alternative]
- [Anti-pattern 2]: [Description and recommended alternative]

**Quality Issues**:
- [Issue 1]: [Description and severity]
- [Issue 2]: [Description and severity]

### Quality Assessment
**Overall Quality Score**: [Score out of 100]
**Consistency Score**: [Score out of 100]
**Completeness Score**: [Score out of 100]
**Integration Quality Score**: [Score out of 100]

## Recommendations

### High Priority Recommendations
**Immediate Actions**:
1. [Action 1]: [Description and rationale]
2. [Action 2]: [Description and rationale]

**Model Improvements**:
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

### Medium Priority Recommendations
**Enhancement Opportunities**:
- [Opportunity 1]: [Description and value]
- [Opportunity 2]: [Description and value]

**Process Improvements**:
- [Improvement 1]: [Description and impact]
- [Improvement 2]: [Description and impact]

### Low Priority Recommendations
**Future Considerations**:
- [Consideration 1]: [Description and context]
- [Consideration 2]: [Description and context]

## Implementation Plan

### Immediate Actions (Next 1-2 weeks)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Short-term Actions (Next 1-2 months)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

### Long-term Actions (Next 3-6 months)
- [Action 1]: [Owner and timeline]
- [Action 2]: [Owner and timeline]

## Success Metrics and Monitoring

### Key Metrics to Track
- [Metric 1]: [Target value and measurement approach]
- [Metric 2]: [Target value and measurement approach]

### Monitoring Approach
- [Monitoring method 1]: [Frequency and responsibility]
- [Monitoring method 2]: [Frequency and responsibility]

### Success Criteria
- [Criterion 1]: [Definition and measurement]
- [Criterion 2]: [Definition and measurement]

## Knowledge Base Enhancements

### New Knowledge Added
- [Knowledge item 1]: [Description and value]
- [Knowledge item 2]: [Description and value]

### Knowledge Base Improvements
- [Improvement 1]: [Description and benefits]
- [Improvement 2]: [Description and benefits]

## Conclusion

[Summary of analysis outcomes, key takeaways, and next steps]

---

**Analysis Status**:
- [ ] Artifact discovery completed
- [ ] Consistency validation performed
- [ ] Gap and conflict analysis completed
- [ ] Pattern and quality analysis finished
- [ ] Recommendations generated
- [ ] Implementation plan created
- [ ] Knowledge base enhanced
- [ ] Success metrics defined

EOF

if $JSON_MODE; then
    printf '{"ANALYSIS_DIR":"%s","ANALYSIS_REPORT_FILE":"%s","KNOWLEDGE_DIR":"%s","FINDINGS_DIR":"%s","RECOMMENDATIONS_DIR":"%s","SCOPE_NAME":"%s","CURRENT_BRANCH":"%s","TIMESTAMP":"%s"}\n' \
        "$ANALYSIS_DIR" "$ANALYSIS_REPORT_FILE" "$KNOWLEDGE_DIR" "$FINDINGS_DIR" "$RECOMMENDATIONS_DIR" "$SCOPE_NAME" "$CURRENT_BRANCH" "$TIMESTAMP"
else
    echo "ANALYSIS_DIR: $ANALYSIS_DIR"
    echo "ANALYSIS_REPORT_FILE: $ANALYSIS_REPORT_FILE"
    echo "KNOWLEDGE_DIR: $KNOWLEDGE_DIR"
    echo "FINDINGS_DIR: $FINDINGS_DIR"
    echo "RECOMMENDATIONS_DIR: $RECOMMENDATIONS_DIR"
    echo "SCOPE_NAME: $SCOPE_NAME"
    echo "CURRENT_BRANCH: $CURRENT_BRANCH"
    echo "TIMESTAMP: $TIMESTAMP"
    echo ""
    echo "Ready for cross-artifact Event Storming analysis."
    if [ -n "$ANALYSIS_INPUT" ]; then
        echo "Analysis scope: $ANALYSIS_INPUT"
    else
        echo "Analysis scope: Comprehensive (all artifacts)"
    fi
    echo ""
    echo "The AI will now:"
    echo "1. Discover and analyze all Event Storming artifacts"
    echo "2. Validate consistency across domain models"
    echo "3. Identify gaps, conflicts, and areas for improvement"
    echo "4. Discover patterns and assess quality"
    echo "5. Generate actionable recommendations"
    echo "6. Enhance knowledge base with analysis insights"
    echo "7. Create implementation plan for improvements"
    echo ""
    echo "Cross-artifact analysis will be performed in the current branch context."
fi
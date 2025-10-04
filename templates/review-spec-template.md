# Complex Requirements Analysis Report

**Analysis ID**: complex-requirements-analysis-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Source Document**: [Document name/path or "User Input"]
**Input Analysis**: "$ARGUMENTS"

## Execution Flow (main)
```
1. Parse complex requirements from input
   → If empty: ERROR "No requirements provided for analysis"
2. Analyze requirement structure and complexity
   → Identify: scope, stakeholders, business objectives
3. Extract key functional areas
   → Group related requirements into logical domains
4. Map dependencies and relationships
   → Identify: prerequisites, sequencing, integration points
5. Generate feature breakdown
   → Create manageable feature boundaries
6. Assess feature readiness
   → Validate completeness and clarity for each feature
7. Generate implementation roadmap
   → Provide sequencing recommendations
8. Return: SUCCESS (analysis complete, features ready for /specify)
```

---

## ⚡ Analysis Guidelines
- ✅ Focus on breaking down complexity, not implementation
- ❌ Avoid suggesting specific technologies or architectures
- 🎯 Maintain business value and user focus throughout
- 🔗 Preserve relationships and dependencies between features

### Analysis Principles
- **Decomposition**: Break down complex requirements into logical, manageable features
- **Cohesion**: Group related functionality within features
- **Coupling**: Minimize dependencies while preserving necessary relationships
- **Traceability**: Ensure each requirement maps to at least one feature
- **Sequencing**: Establish logical implementation order based on dependencies

---

## Requirement Document Analysis *(mandatory)*

### Document Overview
**Document Type**: [Requirements document, user story collection, RFC, etc.]
**Scope**: [High-level description of the system/domain]
**Stakeholders**: [Key user groups, business units, external systems]
**Business Objectives**: [Primary goals and value propositions]

### Knowledge Base Context *(MCP Enhanced)*
**Existing Domain Knowledge**: [Summary of similar domains in knowledge base]
**Related Entities Found**: [Key entities from similar projects]
**Established Patterns**: [Proven patterns from knowledge base]
**Knowledge Gaps Identified**: [Areas needing new domain intelligence]

### Complexity Assessment
**Overall Complexity**: [Low/Medium/High/Very High]
**Primary Complexity Factors**:
- [ ] Large number of requirements (>50)
- [ ] Multiple user roles/actors
- [ ] Complex business workflows
- [ ] Integration with external systems
- [ ] Regulatory/compliance requirements
- [ ] Technical constraints
- [ ] Geographic/cultural considerations
- [ ] Performance/scalability demands

### Requirement Categories Identified
**Functional Areas**:
- [Area 1]: [Brief description]
- [Area 2]: [Brief description]
- [Area 3]: [Brief description]

**Cross-Cutting Concerns**:
- [Security/Authentication]
- [Data Management]
- [Reporting/Analytics]
- [User Experience]
- [Integration/APIs]
- [Performance/Reliability]

---

## Feature Breakdown *(mandatory)*

### Identified Features

#### Feature 1: [Feature Name]
**Priority**: [Must Have/Should Have/Could Have/Won't Have]
**Complexity**: [Low/Medium/High]
**Business Value**: [High/Medium/Low]
**Description**: [Clear, concise description of what this feature delivers]
**Key Requirements**:
- [Requirement 1 excerpt]
- [Requirement 2 excerpt]
- [Requirement 3 excerpt]
**Dependencies**: [Features this depends on or features that depend on this]
**Integration Points**: [External systems, shared components, APIs]
**Estimated Effort**: [Relative sizing: S/M/L]

**Knowledge Base Intelligence *(MCP Enhanced)***:
**Similar Features Found**: [Related features from knowledge base]
**Established Patterns**: [Proven implementation patterns]
**Entity Relationships**: [Key entities and their relationships]
**Business Rules**: [Relevant business rules and constraints]
**Implementation Insights**: [Lessons learned from similar features]

#### Feature 2: [Feature Name]
**Priority**: [Must Have/Should Have/Could Have/Won't Have]
**Complexity**: [Low/Medium/High]
**Business Value**: [High/Medium/Low]
**Description**: [Clear, concise description of what this feature delivers]
**Key Requirements**:
- [Requirement 1 excerpt]
- [Requirement 2 excerpt]
- [Requirement 3 excerpt]
**Dependencies**: [Features this depends on or features that depend on this]
**Integration Points**: [External systems, shared components, APIs]
**Estimated Effort**: [Relative sizing: S/M/L]

[Continue for all identified features...]

### Feature Summary Table
| Feature ID | Name | Priority | Complexity | Business Value | Dependencies | Ready for /specify |
|------------|------|----------|------------|----------------|--------------|-------------------|
| F001 | [Feature 1] | [P0/P1/P2/P3] | [L/M/H] | [H/M/L] | [Dependencies] | [✓/✗] |
| F002 | [Feature 2] | [P0/P1/P2/P3] | [L/M/H] | [H/M/L] | [Dependencies] | [✓/✗] |

---

## Dependency & Relationship Mapping *(mandatory)*

### Dependency Matrix
**Legend**: → (depends on), ↔ (bidirectional), || (can be parallel)

```
Feature A → Feature B → Feature C
      ↘ Feature D → Feature E
Feature F || Feature G
Feature H ↔ Feature I
```

### Critical Dependencies
- **Critical Path**: [Sequence of features that must be implemented in order]
- **High-Impact Dependencies**: [Dependencies that significantly affect project success]
- **Parallel Development Opportunities**: [Features that can be developed simultaneously]

### Shared Components & Considerations
**Data Models**:
- [Shared entity 1]: [Description and which features use it]
- [Shared entity 2]: [Description and which features use it]

**Integration Points**:
- [External system 1]: [Features that integrate with it]
- [API contracts]: [Shared APIs between features]

**Common Workflows**:
- [Workflow 1]: [Cross-feature user journey]
- [Workflow 2]: [Cross-feature business process]

---

## Implementation Roadmap *(mandatory)*

### Recommended Phasing
**Phase 1**: Foundation Features
- [Feature list for phase 1]
- **Rationale**: [Why these features first]
- **Timeline**: [Estimated duration/relative effort]

**Phase 2**: Core Functionality
- [Feature list for phase 2]
- **Rationale**: [Why these features next]
- **Timeline**: [Estimated duration/relative effort]

**Phase 3**: Advanced Features
- [Feature list for phase 3]
- **Rationale**: [Why these features last]
- **Timeline**: [Estimated duration/relative effort]

### Risk Assessment
**High-Risk Features**: [Features with high complexity or uncertainty]
**Mitigation Strategies**: [Approaches to reduce risk]
**Dependencies on External Factors**: [External dependencies that could impact timeline]

---

## Feature Readiness Assessment *(mandatory)*

### Readiness Criteria for /specify
Each feature should be assessed for readiness to proceed with `/specify`:

#### Feature Readiness Checklist
**Scope Clarity**:
- [ ] Feature boundaries are well-defined
- [ ] No overlap with other features
- [ ] Clear success criteria identified

**Requirement Completeness**:
- [ ] All requirements for the feature are identified
- [ ] Requirements are testable and measurable
- [ ] No critical ambiguities remain

**Dependency Understanding**:
- [ ] All dependencies are mapped
- [ ] Prerequisites are clear
- [ ] Integration points are defined

**Business Value**:
- [ ] Clear value proposition
- [ ] Aligned with stakeholder needs
- [ ] Justifies implementation effort

### Feature-Specific Notes
#### [Feature 1 Name]
**Readiness Status**: [Ready/Needs Clarification/Not Ready]
**Clarifications Needed**: [Specific questions or areas needing more detail]
**Recommended Next Steps**: [Actions to make feature ready]

#### [Feature 2 Name]
**Readiness Status**: [Ready/Needs Clarification/Not Ready]
**Clarifications Needed**: [Specific questions or areas needing more detail]
**Recommended Next Steps**: [Actions to make feature ready]

---

## Quality Gates & Validation *(mandatory)*

### Analysis Completeness
- [ ] All requirements from source document are accounted for
- [ ] No orphan requirements (requirements without a feature)
- [ ] Feature boundaries are logical and manageable
- [ ] Dependencies are properly mapped and understood

### Integrity Preservation
- [ ] Business process flows are maintained across features
- [ ] Data consistency is ensured between features
- [ ] User experience continuity is preserved
- [ ] Integration points are clearly defined

### Actionable Outputs
- [ ] Each feature has sufficient detail for `/specify`
- [ ] Implementation sequencing is clear
- [ ] Risks are identified and mitigated
- [ ] Success criteria are defined

---

## Next Steps & Recommendations *(mandatory)*

### Immediate Actions
1. **Start with highest priority ready features**:
   - [Feature 1]: `/specify [Feature 1 description]`
   - [Feature 2]: `/specify [Feature 2 description]`

2. **Address clarification needs**:
   - [Feature 3]: [Specific clarification needed]
   - [Feature 4]: [Specific clarification needed]

3. **Coordinate dependent features**:
   - [Note about timing and coordination needs]

### Knowledge Base Enhancement Actions *(MCP Enhanced)*
1. **Domain Intelligence Ingestion**:
   - Ingest analysis document: Entities, relationships, and business rules
   - Add feature breakdown patterns to knowledge base
   - Document dependency mapping and sequencing insights
   - Capture cross-domain relationships and integration points

2. **Knowledge Base Expansion Recommendations**:
   - Research similar domains for additional patterns
   - Document architectural decisions and rationale
   - Capture implementation lessons learned
   - Establish best practices for similar features

3. **Ongoing Knowledge Management**:
   - Query knowledge base before each `/specify` command
   - Ingest specifications to grow domain intelligence
   - Leverage patterns during `/plan` phase
   - Continuously enrich knowledge base with implementation insights

### Success Metrics
- **Feature Completeness**: % of requirements mapped to features
- **Dependency Clarity**: % of dependencies clearly mapped
- **Readiness**: % of features ready for `/specify`
- **Coverage**: % of business objectives addressed
- **Knowledge Base Growth**: New entities, relationships, and patterns added
- **Pattern Reusability**: % of features leveraging existing knowledge

### Executive Summary
[High-level summary of analysis outcomes, key findings, and recommendations for stakeholders, including knowledge base strategy and expected intelligence growth]

---

## Execution Status
*Updated by main() during processing*

- [ ] Requirements parsed and analyzed
- [ ] Feature breakdown completed
- [ ] Dependencies mapped
- [ ] Implementation roadmap generated
- [ ] Feature readiness assessed
- [ ] Quality gates validated
- [ ] Next steps identified

---
# Complex Requirements Analysis & Domain Event Storming Report

**Analysis ID**: complex-requirements-domain-analysis-[TIMESTAMP]
**Created**: [DATE]
**Status**: Draft
**Current Branch**: [CURRENT_BRANCH]
**Source Document**: [Document name/path or "User Input"]
**Input Analysis**: "$ARGUMENTS"

## Execution Flow (combined)
```
1. Parse complex requirements from input
   → If empty: ERROR "No requirements provided for analysis"
2. Query knowledge base for existing domain intelligence (MCP)
   → Retrieve similar domains, patterns, and entities
3. Analyze requirement structure and complexity
   → Identify: scope, stakeholders, business objectives
4. Extract domain context for Event Storming
   → Map business processes, entities, and relationships
5. Generate feature breakdown with domain context
   → Create manageable feature boundaries with domain awareness
6. Create high-level domain Event Storming diagram
   → Execute Event Storming agent with prepared input
7. Map features to domain model
   → Create feature-to-domain relationships and dependencies
8. Generate integrated documentation and knowledge enrichment
   → Produce combined analysis and domain modeling results
9. Return: SUCCESS (analysis complete, domain model created, features ready for /specify)
```

---

## ⚡ Combined Analysis Guidelines
- ✅ Focus on breaking down complexity AND domain modeling
- ❌ Avoid suggesting specific technologies or architectures
- 🎯 Maintain business value and domain focus throughout
- 🔗 Preserve relationships between features AND domain elements
- 🏗️ Create domain model that informs feature development

### Combined Analysis Principles
- **Decomposition**: Break down complex requirements into logical, manageable features
- **Domain-First**: Model business domain before technical implementation
- **Cohesion**: Group related functionality within features AND domain contexts
- **Traceability**: Ensure each requirement maps to features AND domain elements
- **Integration**: Maintain consistency between feature analysis and domain model

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
- [ ] Domain complexity (multiple bounded contexts)
- [ ] Performance/scalability demands

### Domain Context Extraction
**Business Processes Identified**:
- [Process 1]: [Brief description of key business process]
- [Process 2]: [Brief description of key business process]
- [Process 3]: [Brief description of key business process]

**Key Entities & Relationships**:
- [Entity 1]: [Description and key attributes]
- [Entity 2]: [Description and key attributes]
- [Entity 3]: [Description and key attributes]
- [Relationship 1-2]: [Description of relationship]
- [Relationship 2-3]: [Description of relationship]

**External System Dependencies**:
- [System 1]: [Purpose and integration nature]
- [System 2]: [Purpose and integration nature]
- [System 3]: [Purpose and integration nature]

---

## Domain Event Storming Results *(mandatory)*

### Event Storming Execution
**Event Storming Agent Input**: [Summary of input provided to agent]
**Domain Scope**: [Scope of domain modeling]
**Key Stakeholders**: [Actors identified for domain modeling]
**Business Objectives**: [Objectives reflected in domain model]

### Domain Model Overview
**Bounded Contexts Identified**:
1. **[Context 1 Name]**: [Description and scope]
   - **Key Entities**: [Entities within this context]
   - **Business Processes**: [Processes within this context]
   - **External Integrations**: [External system interactions]

2. **[Context 2 Name]**: [Description and scope]
   - **Key Entities**: [Entities within this context]
   - **Business Processes**: [Processes within this context]
   - **External Integrations**: [External system interactions]

### Key Domain Events
**Domain Events Identified**:
- **[Event 1 Name]**: [Business significance and triggers]
- **[Event 2 Name]**: [Business significance and triggers]
- **[Event 3 Name]**: [Business significance and triggers]

### Major Aggregates & Policies
**Aggregates**:
- **[Aggregate 1 Name]**: [Entities and business rules]
- **[Aggregate 2 Name]**: [Entities and business rules]

**Business Policies**:
- **[Policy 1 Name]**: [Business rule and enforcement]
- **[Policy 2 Name]**: [Business rule and enforcement]

### Event Storming Diagram Details
**Diagram File**: [event-storming/domain-event-storming.drawio]
**Diagram Elements**: [Count of events, aggregates, policies, etc.]
**Flow Organization**: [Description of flow structure]
**Integration Points**: [Cross-context and external system integrations]

**Event Storming Validation**:
- [ ] All elements follow proper Event Storming methodology
- [ ] Temporal flow is correct (left-to-right)
- [ ] Business language is used throughout
- [ ] Domain boundaries are well-defined
- [ ] Integration points are clearly mapped

---

## Feature Breakdown *(mandatory)*

### Identified Features (with Domain Context)

#### Feature 1: [Feature Name]
**Priority**: [Must Have/Should Have/Could Have/Won't Have]
**Complexity**: [Low/Medium/High]
**Business Value**: [High/Medium/Low]
**Description**: [Clear, concise description of what this feature delivers]

**Domain Context**:
- **Bounded Context**: [Which domain context this feature belongs to]
- **Related Aggregates**: [Domain aggregates this feature interacts with]
- **Domain Events**: [Domain events this feature triggers or responds to]
- **Business Processes**: [Business processes this feature participates in]

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

**Domain Context**:
- **Bounded Context**: [Which domain context this feature belongs to]
- **Related Aggregates**: [Domain aggregates this feature interacts with]
- **Domain Events**: [Domain events this feature triggers or responds to]
- **Business Processes**: [Business processes this feature participates in]

**Key Requirements**:
- [Requirement 1 excerpt]
- [Requirement 2 excerpt]
- [Requirement 3 excerpt]

**Dependencies**: [Features this depends on or features that depend on this]
**Integration Points**: [External systems, shared components, APIs]
**Estimated Effort**: [Relative sizing: S/M/L]

[Continue for all identified features...]

### Feature Summary Table
| Feature ID | Name | Priority | Complexity | Business Value | Domain Context | Dependencies | Ready for /specify |
|------------|------|----------|------------|----------------|----------------|--------------|-------------------|
| F001 | [Feature 1] | [P0/P1/P2/P3] | [L/M/H] | [H/M/L] | [Context] | [Dependencies] | [✓/✗] |
| F002 | [Feature 2] | [P0/P1/P2/P3] | [L/M/H] | [H/M/L] | [Context] | [Dependencies] | [✓/✗] |

---

## Feature-to-Domain Integration Mapping *(mandatory)*

### Domain Context Distribution
**Features by Bounded Context**:
- **[Context 1 Name]**: [Feature list belonging to this context]
- **[Context 2 Name]**: [Feature list belonging to this context]
- **[Context 3 Name]**: [Feature list belonging to this context]

### Cross-Context Dependencies
**Context-Level Dependencies**:
- **[Context 1] → [Context 2]**: [Nature of dependency]
- **[Context 2] ↔ [Context 3]**: [Bidirectional dependency]
- **[Context 1] || [Context 3]**: [Can be developed in parallel]

### Feature-to-Domain Event Mapping
**Event-Feature Relationships**:
- **[Event 1 Name]**: [Features that trigger this event]
- **[Event 2 Name]**: [Features that respond to this event]
- **[Event 3 Name]**: [Features that participate in this event]

### Aggregate Utilization
**Aggregate Usage by Features**:
- **[Aggregate 1 Name]**: [Features that use this aggregate]
- **[Aggregate 2 Name]**: [Features that use this aggregate]
- **[Aggregate 3 Name]**: [Features that use this aggregate]

---

## Dependency & Relationship Mapping *(mandatory)*

### Dependency Matrix (Domain-Enhanced)
**Legend**: → (depends on), ↔ (bidirectional), || (can be parallel)

```
Feature A (Context 1) → Feature B (Context 1) → Feature C (Context 2)
                ↘ Feature D (Context 1) → Feature E (Context 2)
Feature F (Context 3) || Feature G (Context 3)
Feature H (Context 1) ↔ Feature I (Context 2)
```

### Critical Dependencies
- **Critical Path**: [Sequence of features that must be implemented in order]
- **High-Impact Dependencies**: [Dependencies that significantly affect project success]
- **Parallel Development Opportunities**: [Features that can be developed simultaneously]
- **Context-Level Dependencies**: [Dependencies between different bounded contexts]

### Shared Components & Considerations
**Data Models (Domain-Enhanced)**:
- [Shared entity 1]: [Description and which features use it]
- [Shared entity 2]: [Description and which features use it]
- [Domain Relationships]: [Key relationships from domain model]

**Integration Points**:
- [External system 1]: [Features that integrate with it]
- [API contracts]: [Shared APIs between features]
- [Domain Events]: [Events used for integration]

**Common Workflows**:
- [Workflow 1]: [Cross-feature user journey]
- [Workflow 2]: [Cross-feature business process]
- [Domain Processes]: [Processes from domain model]

---

## Implementation Roadmap *(mandatory)*

### Recommended Phasing (Domain-Informed)
**Phase 1**: Domain Foundation Features
- [Feature list for phase 1]
- **Domain Context**: [Primary bounded contexts to establish]
- **Rationale**: [Why these features first from domain perspective]
- **Timeline**: [Estimated duration/relative effort]

**Phase 2**: Core Functionality
- [Feature list for phase 2]
- **Domain Context**: [Core domain capabilities to implement]
- **Rationale**: [Why these features next from domain perspective]
- **Timeline**: [Estimated duration/relative effort]

**Phase 3**: Advanced Features
- [Feature list for phase 3]
- **Domain Context**: [Advanced domain capabilities]
- **Rationale**: [Why these features last from domain perspective]
- **Timeline**: [Estimated duration/relative effort]

### Risk Assessment (Domain-Enhanced)
**High-Risk Features**: [Features with high complexity or uncertainty]
**Domain Complexity Risks**: [Risks related to domain modeling]
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
- [ ] Domain context is understood

**Requirement Completeness**:
- [ ] All requirements for the feature are identified
- [ ] Requirements are testable and measurable
- [ ] No critical ambiguities remain
- [ ] Domain constraints are documented

**Dependency Understanding**:
- [ ] All dependencies are mapped
- [ ] Prerequisites are clear
- [ ] Integration points are defined
- [ ] Domain relationships are understood

**Business Value**:
- [ ] Clear value proposition
- [ ] Aligned with stakeholder needs
- [ ] Justifies implementation effort
- [ ] Domain impact is understood

### Feature-Specific Notes
#### [Feature 1 Name]
**Readiness Status**: [Ready/Needs Clarification/Not Ready]
**Domain Context**: [Domain context readiness assessment]
**Clarifications Needed**: [Specific questions or areas needing more detail]
**Recommended Next Steps**: [Actions to make feature ready]
**Event Storming Guidance**: [Guidance for feature-level Event Storming]

#### [Feature 2 Name]
**Readiness Status**: [Ready/Needs Clarification/Not Ready]
**Domain Context**: [Domain context readiness assessment]
**Clarifications Needed**: [Specific questions or areas needing more detail]
**Recommended Next Steps**: [Actions to make feature ready]
**Event Storming Guidance**: [Guidance for feature-level Event Storming]

---

## Quality Gates & Validation *(mandatory)*

### Analysis Completeness
- [ ] All requirements from source document are accounted for
- [ ] No orphan requirements (requirements without a feature)
- [ ] Feature boundaries are logical and manageable
- [ ] Dependencies are properly mapped and understood
- [ ] Domain model reflects business requirements accurately

### Domain Model Integrity
- [ ] Domain model is consistent with feature requirements
- [ ] Bounded contexts are well-defined and meaningful
- [ ] Business processes are accurately represented
- [ ] Integration points are clearly identified
- [ ] Event Storming methodology is properly applied

### Feature-Domain Consistency
- [ ] Features align with domain model boundaries
- [ ] Feature dependencies reflect domain relationships
- [ ] Business rules are consistent across features and domain
- [ ] Integration points match domain model predictions

### Actionable Outputs
- [ ] Each feature has sufficient detail for `/specify`
- [ ] Domain model provides clear guidance for implementation
- [ ] Implementation sequencing is clear and domain-informed
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
   - [Domain context coordination requirements]

### Domain-Driven Development Recommendations
1. **Event Storming Guidance**:
   - Use high-level domain model as reference for feature-level Event Storming
   - Focus feature-level Event Storming on specific bounded contexts
   - Maintain consistency with high-level domain events and aggregates
   - Leverage domain model for integration point identification

2. **Knowledge Base Strategy**:
   - Query domain model before each `/specify` command
   - Use domain context to inform feature specification
   - Ingest feature specifications to enrich domain understanding
   - Continuously validate features against domain model

### Knowledge Base Enhancement Actions *(MCP Enhanced)*
1. **Domain Intelligence Ingestion**:
   - Ingest analysis document: Entities, relationships, and business rules
   - Ingest Event Storming diagram: Domain model and business processes
   - Add feature breakdown patterns with domain context to knowledge base
   - Document domain-to-feature mapping and integration insights
   - Capture cross-domain relationships and bounded context definitions

2. **Knowledge Base Expansion Recommendations**:
   - Research similar domains for additional patterns
   - Document architectural decisions and domain model rationale
   - Capture implementation lessons learned with domain context
   - Establish best practices for domain-driven development
   - Document Event Storming patterns and approaches

3. **Ongoing Knowledge Management**:
   - Query knowledge base (including domain model) before each workflow step
   - Ingest specifications to grow domain intelligence
   - Leverage domain patterns during `/plan` phase
   - Use domain model for consistency validation during `/analyze`
   - Continuously enrich knowledge base with implementation insights

### Success Metrics
- **Feature Completeness**: % of requirements mapped to features
- **Domain Model Quality**: Accuracy and completeness of domain representation
- **Dependency Clarity**: % of dependencies clearly mapped
- **Readiness**: % of features ready for `/specify`
- **Coverage**: % of business objectives addressed
- **Knowledge Base Growth**: New entities, relationships, patterns, and domain insights added
- **Pattern Reusability**: % of features leveraging existing knowledge and domain patterns
- **Domain Consistency**: % of features consistent with domain model

### Executive Summary
[High-level summary of combined analysis and domain modeling outcomes, key findings, and recommendations for stakeholders, including domain-driven development strategy, knowledge base strategy, and expected intelligence growth]

---

## Execution Status
*Updated by main() during processing*

- [ ] Requirements parsed and analyzed
- [ ] Domain context extracted and prepared
- [ ] Feature breakdown completed with domain context
- [ ] Domain Event Storming executed and validated
- [ ] Feature-to-domain mapping completed
- [ ] Dependencies mapped with domain relationships
- [ ] Implementation roadmap generated (domain-informed)
- [ ] Feature readiness assessed (domain-aware)
- [ ] Quality gates validated (including domain consistency)
- [ ] Knowledge base enriched with analysis and domain insights
- [ ] Next steps identified with domain guidance

---
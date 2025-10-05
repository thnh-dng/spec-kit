# Refined Spec Kit Workflow with Feature-Level Event Storming

This document presents the refined Spec Kit workflow that optimally integrates Knowledge Base MCP and Event Storming Agent, with Event Storming performed at the feature level after the clarify step.

## Executive Summary

The refined workflow addresses the challenge of when to perform Event Storming in the Spec Kit process. Instead of a single large Event Storming session, this approach uses a two-tier strategy:

1. **Combined Analysis & Domain Event Storming** after `/review-spec-domain` for integrated feature breakdown and domain modeling
2. **Feature-level Event Storming** after `/clarify` for detailed feature analysis

This approach ensures Event Storming happens when requirements are concrete and feature-specific, while maintaining a consistent overall domain model through the combined analysis and domain modeling step.

## Refined Workflow Architecture

### **Project-Level Flow**
```
/constitution → /review-spec-domain (combined analysis + domain Event Storming)
```

### **Feature-Level Flow (Repeated for each feature)**
```
/specify (feature specification) → /clarify (resolve ambiguities) → Feature-level Event Storming → /plan → /tasks → /implement
```

### **Knowledge Base Integration Points**
- **After each step**: Knowledge is ingested and enriched
- **Before each step**: Existing knowledge is queried for insights
- **Continuous updates**: Big model is updated with feature insights

## Detailed Workflow Process

### **Phase 1: Project Foundation**

#### **Step 1: Project Constitution**
```bash
/constitution
```

**Knowledge Integration:**
```bash
# Ingest foundational project knowledge
/kb-ingest "project-charter.md"
/kb-ingest "stakeholder-requirements.md"
/kb-ingest "business-objectives.md"
/kb-ingest "constraints-assumptions.md"

# Establish project context
/kb-ingest_spec """
Project Foundation:
Project: [Project Name]
Type: [Project Type]
Domain: [Business Domain]
Key Stakeholders: [List]
Primary Objectives: [List]
Constraints: [List]
Success Criteria: [List]
"""
```

#### **Step 2: Complex Requirements Analysis**
```bash
/review-spec "complex-requirements-document.md"
```

**Automatic Knowledge Processing:**
```bash
# /review-spec automatically:
# 1. Queries similar domains and patterns
# 2. Breaks down big requirements into features
# 3. Extracts entities and relationships
# 4. Identifies business rules and constraints
# 5. Ingests analysis results
```

**Output:** Individual feature specifications ready for detailed analysis

### **Phase 2: Combined Requirements Analysis & Domain Event Storming**

#### **Step 3: Combined Analysis and Domain Event Storming**
```bash
/review-spec-domain "complex requirements description"
```

**Combined Process:**
1. **Knowledge Base Query**: Query existing domain intelligence and patterns
2. **Requirements Analysis**: Break down complex requirements into features
3. **Domain Context Extraction**: Extract business processes, entities, and relationships
4. **Event Storming Execution**: Create high-level domain Event Storming diagram
5. **Feature-to-Domain Mapping**: Map features to domain model and contexts
6. **Knowledge Enrichment**: Ingest both analysis results and domain model

**Key Benefits of Combined Approach:**
- **Streamlined Workflow**: Single command instead of two separate steps
- **Better Integration**: Seamless connection between feature analysis and domain modeling
- **Consistent Knowledge**: Coherent knowledge enrichment in one step
- **Improved Context**: Features are created with domain context from the start

**Outputs:**
```bash
# Combined analysis and domain model documentation
/kb-ingest "specs/complex-requirements-analysis-[timestamp]/analysis-report.md"
/kb-ingest "specs/complex-requirements-analysis-[timestamp]/event-storming/domain-event-storming.drawio"
/kb-ingest "specs/complex-requirements-analysis-[timestamp]/feature-stubs/"
```

### **Phase 3: Feature-Level Processing (Repeated for each feature)**

#### **Step 4: Feature Specification**
```bash
/specify "[Feature Name] - [Feature Description]"
```

**Pre-Specification Knowledge Query:**
```bash
# Query combined analysis and domain model results
/kb-query "domain context for [feature] from review-spec-domain"
/kb-query "feature domain mapping and bounded contexts"
/kb-query "related aggregates and entities from domain model"
/kb-query "business processes relevant to [feature]"

# Query for similar features and patterns
/kb-query "similar features across projects"
/kb-query "implementation patterns for [feature-type]"
/kb-query "business rules affecting [feature]"
```

**Post-Specification Knowledge Enrichment:**
```bash
# Ingest feature specification
/kb-ingest "features/[feature-name]/spec.md"

# Extract feature-specific knowledge
/kb-ingest_spec """
Feature Specification:
Feature: [Feature Name]
Scope: [Feature scope]
User Stories: [Key user stories]
Acceptance Criteria: [List of criteria]
Dependencies: [Feature dependencies]
Integration Points: [Feature integrations]
Business Value: [Value proposition]
"""
```

#### **Step 5: Feature Clarification**
```bash
/clarify
```

**Purpose:** Resolve ambiguities, clarify requirements, and make feature specifications concrete

**Pre-Clarification Knowledge Query:**
```bash
/kb-query "potential ambiguities in [feature]"
/kb-query "similar clarification patterns"
/kb-query "business rules affecting [feature]"
/kb-query "integration challenges for [feature]"
```

**Post-Clarification Knowledge Update:**
```bash
# Ingest clarification results
/kb-ingest "features/[feature-name]/clarification-results.md"

# Update with concrete requirements
/kb-ingest_spec """
Clarified Requirements:
Feature: [Feature Name]
Resolved Issues: [List of resolved ambiguities]
Concrete Requirements: [Specific, implementable requirements]
Business Rules: [Specific business rules]
Validation Rules: [Clear validation criteria]
Error Handling: [Specific error handling requirements]
Performance Requirements: [Clear performance criteria]
Integration Details: [Specific integration specifications]
"""
```

#### **Step 6: Feature-Level Event Storming**
```bash
/agent event-storming-agent
```

**This is the optimal timing for feature-level Event Storming because:**
- Requirements are now concrete and specific
- Ambiguities have been resolved
- Feature scope is well-defined
- Implementation context is clear
- Stakeholder alignment has been achieved

**Preparation for Feature Event Storming:**
```bash
# Query feature-specific context
/kb-query "clarified requirements for [feature]"
/kb-query "relevant domain context from big model"
/kb-query "existing aggregates and entities"
/kb-query "business rules for [feature]"
/kb-query "integration points for [feature]"

# Query implementation patterns
/kb-query "implementation patterns for [feature-type]"
/kb-query "similar features across projects"
/kb-query "common pitfalls for [feature-type]"
```

**Feature Event Storming Input Structure:**
```markdown
# Feature Event Storming Input

## Feature Context
- **Feature Name**: [Specific feature name]
- **Feature Scope**: [Clear, concrete scope]
- **Business Value**: [Specific value proposition]
- **User Stories**: [Concrete user stories]
- **Acceptance Criteria**: [Specific, testable criteria]

## Clarified Requirements
- **Specific Requirements**: [Concrete, implementable requirements]
- **Business Rules**: [Specific business rules and constraints]
- **Validation Rules**: [Clear validation criteria]
- **Error Handling**: [Specific error handling requirements]
- **Performance Requirements**: [Clear performance criteria]

## Domain Context (from High-level Model)
- **Bounded Context**: [Relevant bounded context]
- **Related Aggregates**: [Existing aggregates from big model]
- **Domain Events**: [Relevant high-level events]
- **Business Processes**: [Related business processes]

## Implementation Context
- **Technology Stack**: [Specific technologies]
- **Existing Patterns**: [Relevant implementation patterns]
- **Dependencies**: [Specific feature dependencies]
- **Integration Points**: [Specific external integrations]
```

**Feature Event Storming Focus:**
1. **Feature-specific domain events** (detailed level)
2. **Feature commands and user interactions**
3. **Feature aggregates and entities** (specific to feature)
4. **Feature business processes** (detailed flows)
5. **Feature integration points** (specific implementations)
6. **Feature business rules** (specific validation logic)

**Feature Event Storming Outputs:**
```bash
# Ingest feature Event Storming results
/kb-ingest "features/[feature-name]/feature-event-storming.md"
/kb-ingest "features/[feature-name]/feature-domain-events.md"
/kb-ingest "features/[feature-name]/feature-aggregates.md"
/kb-ingest "features/[feature-name]/feature-processes.md"
/kb-ingest "features/[feature-name]/feature-integrations.md"

# Structured feature domain knowledge
/kb-ingest_spec """
Feature Domain Model:
Feature: [Feature Name]
Domain Events: [Feature-specific events]
Commands: [Feature-specific commands]
Aggregates: [Feature-specific aggregates]
Processes: [Feature-specific processes]
Integration Points: [Feature-specific integrations]
Business Rules: [Feature-specific rules]
Validation Logic: [Feature-specific validation]
Error Handling: [Feature-specific error handling]
"""
```

#### **Step 7: Big Model Update**
After each feature Event Storming, update the high-level domain model:

```bash
# Analyze impact on big model
/kb-query "impact of [feature] on big domain model"
/kb-query "new events to add to big model"
/kb-query "aggregate enhancements needed"
/kb-query "business rule refinements required"

# Update big domain model
/kb-ingest_spec """
Big Model Update - [Feature Name]:
Update Date: [Current Date]
Feature Analyzed: [Feature Name]

New Domain Events: [Events to add to big model]
Enhanced Aggregates: [Aggregate refinements]
Refined Business Rules: [Rule improvements]
New Integration Points: [Additional integrations]
Process Refinements: [Process improvements]

Consistency Validation: [Validation results]
Affected Features: [Other features impacted]
"""
```

#### **Step 8: Implementation Planning**
```bash
/plan "feature implementation"
```

**Knowledge-Informed Planning:**
```bash
# Query feature domain model for implementation guidance
/kb-query "implementation guidance from [feature] Event Storming"
/kb-query "aggregate implementations for [feature]"
/kb-query "business rule implementation for [feature]"
/kb-query "integration implementation for [feature]"

# Query for implementation patterns
/kb-query "implementation patterns for [technology]"
/kb-query "similar implementations across projects"
/kb-query "best practices for [feature-type]"
```

**Post-Planning Knowledge Update:**
```bash
# Ingest implementation plan
/kb-ingest "features/[feature-name]/implementation-plan.md"

# Add implementation knowledge
/kb-ingest_spec """
Implementation Approach:
Feature: [Feature Name]
Architecture: [Architectural decisions]
Technology Choices: [Technology selections]
Data Model: [Database design decisions]
API Design: [API contracts]
Security: [Security implementation]
Performance: [Performance optimizations]
Testing Strategy: [Testing approach]
"""
```

#### **Step 9: Task Generation and Implementation**
```bash
/tasks
/implement
```

**Implementation Knowledge Integration:**
```bash
# Query knowledge during implementation
/kb-query "specific implementation patterns for [task]"
/kb-query "business rule implementation guidance"
/kb-query "integration implementation details"

# Document implementation insights
/kb-ingest "features/[feature-name]/implementation-notes.md"
/kb-ingest "features/[feature-name]/lessons-learned.md"
/kb-ingest "features/[feature-name]/optimization-notes.md"
```

## Knowledge Base Maintenance Strategy

### **Progressive Enrichment Schedule**

#### **After Each Major Step**
1. **After `/review-spec`**: High-level domain knowledge, feature breakdown
2. **After high-level Event Storming**: Domain overview, bounded contexts
3. **After `/specify`**: Feature specifications, scope, and requirements
4. **After `/clarify`**: Concrete requirements, resolved ambiguities
5. **After feature Event Storming**: Detailed domain models, implementation guidance
6. **After `/plan`**: Technical decisions, architecture patterns
7. **After implementation**: Lessons learned, optimization insights

#### **Quality Assurance Checkpoints**
```bash
# Daily
/kb-stats
/kb-query "recent knowledge additions"

# Weekly
/kb-schema
/kb-query "consistency across features"
/kb-query "knowledge quality metrics"

# Monthly
/kb-query "comprehensive knowledge audit"
/kb-query "knowledge gap analysis"
/kb-query "value assessment"
```

## Benefits of the Refined Workflow

### **1. Optimal Timing for Event Storming**
- **After Clarify**: Requirements are concrete and specific
- **Feature Focus**: Each Event Storming session has clear scope
- **Implementation Ready**: Detailed models directly guide implementation
- **Stakeholder Alignment**: Clarification ensures shared understanding

### **2. Progressive Domain Understanding**
- **High-level Overview**: Big Event Storming provides context
- **Feature-Level Detail**: Feature Event Storming provides specifics
- **Continuous Refinement**: Big model improves with each feature
- **Bidirectional Learning**: Knowledge flows both ways

### **3. Enhanced Knowledge Base**
- **Concrete Knowledge**: Requirements are concrete when documented
- **Feature Context**: Each feature has rich domain context
- **Implementation Guidance**: Detailed models guide development
- **Pattern Discovery**: Cross-feature patterns are identified

### **4. Improved Development Efficiency**
- **Better Specifications**: Concrete requirements lead to better specs
- **Implementation Guidance**: Detailed domain models guide coding
- **Reduced Rework**: Better upfront understanding reduces rework
- **Pattern Reuse**: Common patterns are identified and reused

## Implementation Example: E-Commerce Platform

### **Phase 1: Project Foundation**
```bash
/constitution
# Establishes e-commerce platform governance and objectives

/review-spec-domain "complex-e-commerce-requirements.md"
# Combined analysis and domain Event Storming:
# - Breaks down into: Order Management, Payment Processing, Inventory Management, Customer Management
# - Creates high-level domain model with bounded contexts, aggregates, and business processes
# - Maps features to domain model and establishes integration points
```

### **Phase 3: Feature-Level Processing (Payment Processing Example)**

#### **Step 4-5: Feature Specification and Clarification**
```bash
/specify "Payment Processing - Support credit card and PayPal payments"
/clarify
# Results in concrete requirements:
# - Support Visa, MasterCard, PayPal
# - Integration with Stripe and PayPal APIs
# - Specific validation and error handling
# - Clear security requirements
```

#### **Step 6: Feature-Level Event Storming**
```bash
/agent event-storming-agent
# Focus on payment processing specifics:
# - PaymentValidationStarted, PaymentValidationCompleted events
# - CreditCard, PayPalAccount aggregates
# - Payment authorization processes
# - Integration with Stripe and PayPal APIs
```

#### **Step 7: Big Model Update**
```bash
# Updates big model with payment insights:
# - Enhanced Payment aggregate with specific payment methods
# - New payment validation events
# - Detailed integration specifications
# - Refined payment business rules
```

#### **Step 8-9: Planning and Implementation**
```bash
/plan "payment processing implementation"
/tasks
/implement
# Implementation guided by detailed feature domain model
```

## Success Metrics

### **Process Metrics**
- **Event Storming Effectiveness**: Time and quality of Event Storming sessions
- **Knowledge Base Growth**: Rate of knowledge accumulation
- **Consistency Maintenance**: Consistency across all domain models
- **Update Efficiency**: Time between feature analysis and model updates

### **Quality Metrics**
- **Specification Quality**: Reduction in specification defects
- **Implementation Quality**: Reduction in implementation defects
- **Domain Understanding**: Stakeholder understanding of domain
- **Model Accuracy**: Accuracy of domain models compared to reality

### **Efficiency Metrics**
- **Development Speed**: Improvement in development velocity
- **Rework Reduction**: Reduction in rework due to better upfront analysis
- **Decision Quality**: Improvement in technical decision quality
- **Stakeholder Satisfaction**: Satisfaction with the process and outcomes

## Best Practices

### **Event Storming Best Practices**
1. **Feature-Level Focus**: Keep Event Storming sessions focused on specific features
2. **Concrete Requirements**: Ensure requirements are concrete before Event Storming
3. **Implementation Context**: Consider technical constraints and requirements
4. **Stakeholder Involvement**: Include relevant stakeholders in feature sessions
5. **Documentation**: Thoroughly document all Event Storming results

### **Knowledge Base Best Practices**
1. **Progressive Enrichment**: Add knowledge at strategic points in the workflow
2. **Consistency Maintenance**: Ensure consistency across all knowledge artifacts
3. **Quality Focus**: Focus on high-quality, well-structured knowledge entries
4. **Regular Maintenance**: Perform regular knowledge base maintenance
5. **Team Engagement**: Ensure all team members contribute and benefit

### **Process Best Practices**
1. **Iterative Approach**: Process each feature independently but consistently
2. **Communication**: Maintain clear communication across all stakeholders
3. **Flexibility**: Adapt the process to project-specific needs
4. **Continuous Improvement**: Regularly review and improve the process
5. **Tool Integration**: Leverage available tools effectively

## Conclusion

The refined Spec Kit workflow with feature-level Event Storming provides an optimal balance between high-level domain understanding and detailed feature analysis. By performing Event Storming after the clarify step, teams can:

1. **Work with Concrete Requirements**: Event Storming happens when requirements are specific and implementable
2. **Maintain Feature Focus**: Each Event Storming session has clear scope and objectives
3. **Provide Implementation Guidance**: Detailed domain models directly guide development
4. **Continuously Improve Domain Model**: Big model improves with each feature analysis
5. **Build Valuable Knowledge Asset**: Knowledge base becomes more valuable over time

This approach represents a significant evolution in spec-driven development, combining the best aspects of domain-driven design with practical, implementation-focused analysis.
# Event Storming Integration Guide for Spec Kit

This document provides comprehensive guidance on integrating Event Storming into the Spec Kit workflow to enhance domain understanding and specification quality.

## Overview

Event Storming is a powerful domain-driven design (DDD) technique that helps teams understand complex business domains through visual modeling. When integrated with Spec Kit's knowledge-driven workflow, Event Storming provides the domain foundation needed for creating high-quality, business-aligned specifications.

## When to Use Event Storming

### **Complex Projects (Recommended)**
Use Event Storming when your project has:
- **>50 requirements** or multiple features
- **Complex business domains** with multiple stakeholders
- **Enterprise applications** requiring multiple bounded contexts
- **Integration points** between different business domains
- **Legacy modernization** projects requiring domain analysis

### **Specific Indicators**
Consider Event Storming if you encounter:
- Unclear business processes or workflows
- Multiple stakeholders with different perspectives
- Complex integration requirements
- Need for shared domain understanding
- Evolution or redesign of existing systems

## Event Storming + Spec Kit Workflow

### **Optimal Integration Point**

```
/constitution → /review-spec → Event Storming → /specify → /plan → /tasks → /implement
```

**Why this order works best:**
1. **Constitution** establishes project governance and principles
2. **Review-spec** breaks down complex requirements and extracts domain concepts
3. **Event Storming** visualizes business processes and domain boundaries
4. **Specify** creates detailed specifications based on domain models
5. **Plan** translates specifications into technical implementation

### **Alternative Integration Point**

For simpler projects or when domain understanding is already clear:
```
/constitution → Event Storming → /specify → /plan → /tasks → /implement
```

## Preparation for Event Storming

### **Step 1: Knowledge Base Query**
Before starting Event Storming, query existing knowledge:
```bash
# Query for existing domain knowledge
/kb-query "existing business processes"
/kb-query "key stakeholders and actors"
/kb-query "external system integrations"
/kb-query "business rules and constraints"

# Query for similar domains
/kb-query "similar domains in other projects"
/kb-query "common patterns for [business-domain]"
```

### **Step 2: Prepare Domain Description**
Create a structured domain description:
```bash
/kb-ingest_spec """
Domain: [Domain Name]
Business Context: [Description of business context]
Key Processes: [List of key business processes]
Stakeholders: [List of key stakeholders and actors]
External Systems: [List of external integrations]
Business Objectives: [Key business goals and objectives]
Constraints: [Known constraints and limitations]
Known Issues: [Current pain points or problems]
"""
```

### **Step 3: Gather Requirements**
Collect and organize requirements:
```bash
# Review complex requirements
/review-spec "complex-requirements-document.md"

# Extract key information for Event Storming
/kb-query "extracted entities from requirements"
/kb-query "business processes identified"
/kb-query "integration points documented"
```

## Event Storming Session Structure

### **Phase 1: Domain Exploration**
```bash
/agent event-storming-agent
```

**Input for Domain Exploration:**
- Business domain description
- Key stakeholders and actors
- High-level business processes
- External system interactions
- Business objectives and constraints

**Expected Output:**
- Domain events identification
- Business process visualization
- Stakeholder interaction mapping
- External system boundary identification

### **Phase 2: Event Storming Analysis**

**Key Activities:**
1. **Domain Events**: Identify significant business events
2. **Commands**: Determine actions that trigger events
3. **Aggregates**: Group related entities and business rules
4. **Bounded Contexts**: Define domain boundaries
5. **Read Models**: Identify data views and reporting needs
6. **Policies**: Define business rules and constraints

**Knowledge Integration During Event Storming:**
```bash
# Query for additional context during analysis
/kb-query "similar events in other domains"
/kb-query "existing aggregates for [entity-type]"
/kb-query "business rules related to [process]"
```

### **Phase 3: Output Generation**

**Generated Artifacts:**
- Event Storming diagram (.drawio format)
- Bounded context documentation
- Domain event catalog
- Aggregate root definitions
- Business process flows
- Integration point mapping

## Post-Event Storming Knowledge Integration

### **Step 1: Ingest Event Storming Outputs**
```bash
# Ingest Event Storming diagram
/kb-ingest "event-storming-diagram.drawio"

# Ingest bounded contexts
/kb-ingest "bounded-contexts.md"

# Ingest domain events
/kb-ingest "domain-events.md"

# Ingest aggregate definitions
/kb-ingest "aggregate-roots.md"
```

### **Step 2: Extract and Structure Knowledge**
```bash
/kb-ingest_spec """
Event Storming Results:
Domain: [Domain Name]
Bounded Contexts: [List of contexts]
Key Events: [List of domain events]
Aggregate Roots: [List of aggregates]
Business Processes: [Documented processes]
Integration Points: [Mapped integrations]
Business Rules: [Identified rules]
"""
```

### **Step 3: Update Domain Knowledge**
```bash
# Query for existing related knowledge
/kb-query "existing entities in [domain]"

# Update knowledge base with new insights
/kb-ingest_spec """
Domain Model Updates:
New Entities: [List of new entities]
Updated Relationships: [Changes to relationships]
New Business Rules: [Additional rules discovered]
Clarified Processes: [Improved process understanding]
"""
```

## Integration with Specification Phase

### **Pre-Specification Knowledge Query**
```bash
# Query Event Storming results before specification
/kb-query "domain events related to [feature]"
/kb-query "aggregate roots affected by [feature]"
/kb-query "business processes impacted by [feature]"
/kb-query "integration points for [feature]"

# Query for similar patterns
/kb-query "similar features across projects"
/kb-query "implementation patterns for [feature-type]"
```

### **Creating Knowledge-Informed Specifications**
Use Event Storming insights to create better specifications:
- Reference domain events and business processes
- Leverage aggregate boundaries and relationships
- Incorporate business rules and constraints
- Consider integration points and external systems

### **Post-Specification Knowledge Update**
```bash
# Ingest new specifications
/kb-ingest "specs/[feature]/spec.md"

# Extract and add to knowledge base
/kb-ingest_spec """
Feature Specification:
Feature: [Feature Name]
Domain Events: [Events triggered/used]
Aggregates: [Aggregates affected]
Business Rules: [Rules implemented]
Integration Points: [New or modified integrations]
Dependencies: [Dependencies on other features]
"""
```

## Event Storming Templates and Patterns

### **Business Domain Description Template**
```markdown
# Business Domain Description

## Domain Overview
- **Domain Name**: [Clear domain name]
- **Business Context**: [Description of business context]
- **Primary Objectives**: [Key business goals]

## Key Stakeholders
- **Primary Actors**: [Main users/customers]
- **Secondary Actors**: [Supporting users]
- **External Systems**: [External integrations]
- **Business Owners**: [Decision makers]

## Business Processes
1. **Process Name**: [Description]
   - **Triggers**: [What starts the process]
   - **Steps**: [Key steps in the process]
   - **Outcomes**: [Expected results]
   - **Exceptions**: [Error conditions]

## Business Rules and Constraints
- **Mandatory Rules**: [Required business rules]
- **Optional Rules**: [Flexible guidelines]
- **Technical Constraints**: [System limitations]
- **Business Constraints**: [Business limitations]

## Known Issues and Pain Points
- **Current Problems**: [Existing issues]
- **Desired Improvements**: [Target improvements]
- **Success Criteria**: [How success is measured]
```

### **Event Storming Output Structure**
```markdown
# Event Storming Results

## Bounded Contexts
1. **Context Name**: [Description]
   - **Responsibilities**: [What this context owns]
   - **Relationships**: [Connections to other contexts]

## Domain Events
1. **Event Name**: [Description]
   - **Context**: [Which bounded context]
   - **Trigger**: [What causes this event]
   - **Data**: [Key data elements]

## Aggregate Roots
1. **Aggregate Name**: [Description]
   - **Entities**: [Contained entities]
   - **Business Rules**: [Rules enforced]
   - **Invariants**: [Consistency rules]

## Business Processes
1. **Process Flow**: [Step-by-step flow]
   - **Events**: [Events in the process]
   - **Commands**: [Actions taken]
   - **Decisions**: [Decision points]

## Integration Points
1. **External System**: [System name]
   - **Purpose**: [Integration purpose]
   - **Protocol**: [Communication method]
   - **Data**: [Information exchanged]
```

## Best Practices

### **Event Storming Session Best Practices**

#### **Preparation**
- **Clear Objectives**: Define what you want to achieve
- **Right Participants**: Include domain experts and stakeholders
- **Good Facilitation**: Use experienced facilitator for complex domains
- **Proper Tools**: Use visual collaboration tools or physical whiteboard

#### **During Session**
- **Focus on Events**: Start with domain events, not technical details
- **Business Language**: Use domain terminology, not technical jargon
- **Visual Organization**: Group related events and processes
- **Continuous Refinement**: Iterate and improve the model as you go

#### **Post-Session**
- **Document Thoroughly**: Capture all insights and decisions
- **Validate with Stakeholders**: Ensure model matches business understanding
- **Integrate with Knowledge Base**: Make insights available for future work
- **Plan for Evolution**: Domain models should evolve as understanding grows

### **Knowledge Integration Best Practices**

#### **Consistent Updates**
- **Event Storming Outputs**: Always ingest Event Storming results
- **Domain Evolution**: Update knowledge as domain understanding changes
- **Cross-Reference**: Link Event Storming results to specifications
- **Version Control**: Track evolution of domain models over time

#### **Quality Assurance**
- **Validation**: Regularly validate knowledge against business reality
- **Consistency**: Ensure consistency across domain models and specifications
- **Completeness**: Check that all aspects of the domain are covered
- **Usability**: Ensure knowledge is easily accessible and understandable

## Success Metrics

### **Event Storming Effectiveness**
- **Domain Understanding**: Stakeholder alignment on domain concepts
- **Process Clarity**: Clear understanding of business processes
- **Boundary Definition**: Well-defined bounded contexts
- **Integration Mapping**: Clear external system interfaces

### **Knowledge Base Impact**
- **Query Success**: Relevant results for domain-related queries
- **Pattern Reuse**: Domain patterns applied across features
- **Consistency**: Alignment between domain models and implementations
- **Efficiency**: Reduced time for domain-related decisions

### **Overall Project Impact**
- **Specification Quality**: Better alignment with business needs
- **Implementation Speed**: Faster development through clear domain models
- **Defect Reduction**: Fewer domain-related defects
- **Stakeholder Satisfaction**: Better business-IT alignment

## Troubleshooting

### **Common Event Storming Challenges**

#### **Lack of Domain Expertise**
- **Solution**: Use knowledge base to query similar domains
- **Approach**: Leverage existing patterns and insights
- **Fallback**: Conduct additional stakeholder interviews

#### **Complex Integration Scenarios**
- **Solution**: Focus on integration points during Event Storming
- **Approach**: Use knowledge base to research integration patterns
- **Fallback**: Break down into smaller, manageable integration points

#### **Conflicting Stakeholder Views**
- **Solution**: Use Event Storming to visualize different perspectives
- **Approach**: Focus on business outcomes rather than implementations
- **Fallback**: Document conflicts and escalate for resolution

### **Knowledge Integration Issues**

#### **Inconsistent Domain Models**
- **Solution**: Regular knowledge base consistency checks
- **Approach**: Use schema and stats to monitor knowledge health
- **Fallback**: Manual review and reconciliation of domain models

#### **Outdated Knowledge**
- **Solution**: Regular knowledge base updates and validation
- **Approach**: Version control and change tracking
- **Fallback**: Periodic knowledge audits and cleanup

## Conclusion

Event Storming integration with Spec Kit creates a powerful, knowledge-driven approach to spec-driven development. By combining domain modeling with intelligent knowledge management, teams can:

1. **Understand Complex Domains**: Visual modeling makes complex business processes understandable
2. **Create Better Specifications**: Domain-informed specifications align with business needs
3. **Maintain Consistency**: Knowledge base ensures consistency across all project artifacts
4. **Accelerate Development**: Clear domain models and reusable patterns speed up implementation

The key to success lies in the strategic integration of Event Storming at the right point in the workflow, followed by systematic knowledge enrichment that maintains and builds upon the domain understanding gained during the Event Storming process.
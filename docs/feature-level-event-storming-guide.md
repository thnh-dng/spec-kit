# Feature-Level Event Storming Integration Guide

This document provides a refined approach for integrating Event Storming at the feature level, after the `/review-spec` command breaks down large requirements into manageable features and after the `/clarify` step resolves ambiguities.

## Overview

The refined workflow recognizes that Event Storming is most effective when performed at the feature level, after requirements have been clarified and made concrete. This approach ensures that each feature has sufficient detail and context for meaningful domain modeling.

## Refined Workflow Architecture

### **High-Level Project Flow**
```
/constitution → /review-spec (big requirements analysis) → Big Event Storming (domain overview)
```

### **Feature-Level Flow**
```
/specify (individual feature) → /clarify (resolve ambiguities) → Feature Event Storming → /plan → /tasks → /implement
```

## Why Event Storming After Clarify?

### **Benefits of Post-Clarify Event Storming**

1. **Concrete Requirements**: Clarification resolves ambiguities and makes requirements specific
2. **Feature Context**: Individual features have clear scope and boundaries
3. **Stakeholder Alignment**: Clarification ensures shared understanding before modeling
4. **Implementation Readiness**: Event Storming outputs directly inform technical planning
5. **Knowledge Enrichment**: Feature-specific details enhance the overall domain model

### **Knowledge Base State After Clarify**
- **Specific Requirements**: Clear, unambiguous feature requirements
- **Domain Entities**: Identified entities and their relationships
- **Business Rules**: Documented constraints and validation rules
- **Integration Points**: Known external system dependencies
- **Stakeholder Decisions**: Resolved questions and decisions

## Feature-Level Event Storming Process

### **Step 1: Post-Clarify Knowledge Preparation**
```bash
# After /clarify completes, query feature-specific knowledge
/kb-query "entities related to [feature-name]"
/kb-query "business rules affecting [feature-name]"
/kb-query "integration points for [feature-name]"
/kb-query "similar features across projects"

# Query big Event Storming context
/kb-query "domain context for [feature-name]"
/kb-query "bounded context containing [feature-name]"
/kb-query "related domain events"
```

### **Step 2: Feature-Specific Event Storming**
```bash
/agent event-storming-agent
```

**Input for Feature Event Storming:**
```markdown
# Feature Event Storming Input

## Feature Context
- **Feature Name**: [Specific feature name]
- **Feature Scope**: [Clear scope and boundaries]
- **Business Value**: [Value proposition]
- **User Stories**: [Specific user stories]
- **Acceptance Criteria**: [Clear acceptance criteria]

## Domain Context (from Big Event Storming)
- **Bounded Context**: [Relevant bounded context]
- **Related Aggregates**: [Existing aggregates]
- **Domain Events**: [Relevant domain events]
- **Business Processes**: [Related business processes]

## Clarified Requirements
- **Specific Requirements**: [Clarified requirements]
- **Business Rules**: [Specific business rules]
- **Constraints**: [Technical and business constraints]
- **Integration Points**: [External system integrations]

## Implementation Context
- **Technology Stack**: [Relevant technologies]
- **Existing Patterns**: [Existing implementation patterns]
- **Dependencies**: [Feature dependencies]
```

**Feature Event Storming Focus Areas:**
1. **Feature-Specific Events**: Events directly related to the feature
2. **Feature Commands**: User actions and system triggers
3. **Feature Aggregates**: Entities and business rules within scope
4. **Feature Processes**: Business processes affected by the feature
5. **Feature Integration**: How the feature integrates with existing systems

### **Step 3: Feature Event Storming Outputs**
```markdown
# Feature Event Storming Results

## Feature-Specific Domain Events
1. **EventName**: [Description]
   - **Trigger**: [What triggers the event]
   - **Data**: [Event data structure]
   - **Context**: [Business context]

## Feature Commands
1. **CommandName**: [Description]
   - **Handler**: [What handles the command]
   - **Validation**: [Validation rules]
   - **Events Produced**: [Events generated]

## Feature Aggregates
1. **AggregateName**: [Description]
   - **Entities**: [Contained entities]
   - **Business Rules**: [Business rules enforced]
   - **Invariants**: [Consistency rules]

## Feature Business Processes
1. **ProcessName**: [Description]
   - **Steps**: [Process steps]
   - **Decisions**: [Decision points]
   - **Outcomes**: [Expected outcomes]

## Feature Integration Points
1. **Integration**: [Description]
   - **External System**: [System name]
   - **Protocol**: [Communication method]
   - **Data Flow**: [Information exchanged]
```

### **Step 4: Knowledge Base Integration**
```bash
# Ingest feature Event Storming results
/kb-ingest "features/[feature-name]/event-storming-results.md"
/kb-ingest "features/[feature-name]/feature-domain-events.md"
/kb-ingest "features/[feature-name]/feature-aggregates.md"
/kb-ingest "features/[feature-name]/feature-processes.md"

# Structured feature knowledge
/kb-ingest_spec """
Feature Domain Model:
Feature: [Feature Name]
Domain Events: [List of feature events]
Commands: [List of feature commands]
Aggregates: [List of feature aggregates]
Processes: [List of feature processes]
Integration Points: [List of integrations]
Business Rules: [Feature-specific rules]
Dependencies: [Feature dependencies]
"""
```

## Big Event Storming Update Strategy

### **Step 1: Big Model Analysis**
```bash
# Query big Event Storming model for relevant context
/kb-query "big event storming domain events"
/kb-query "big event storming aggregates"
/kb-query "big event storming bounded contexts"

# Identify relationships between feature and big model
/kb-query "relationship between [feature] and big domain model"
/kb-query "overlap between feature events and domain events"
/kb-query "new aggregates discovered for [feature]"
```

### **Step 2: Big Model Enhancement**
```bash
# Update big Event Storming with feature insights
/kb-ingest_spec """
Big Event Storming Updates:
Feature Contributions: [Feature name]
New Domain Events: [Events discovered during feature Event Storming]
Enhanced Aggregates: [Improved aggregate definitions]
Refined Processes: [Better process understanding]
New Integration Points: [Additional integrations discovered]
Updated Business Rules: [Refined business rules]
"""
```

### **Step 3: Cross-Feature Validation**
```bash
# Validate consistency across features
/kb-query "consistency between [feature1] and [feature2]"
/kb-query "shared entities across features"
/kb-query "conflicting business rules between features"

# Identify patterns and similarities
/kb-query "similar patterns across features"
/kb-query "reusable components from feature analysis"
/kb-query "common integration points"
```

### **Step 4: Progressive Domain Model Refinement**
```bash
# Regular domain model updates
/kb-ingest_spec """
Domain Model Refinement:
Refinement Date: [Current date]
Features Analyzed: [List of features]
New Discoveries: [New domain insights]
Improved Understanding: [Better domain understanding]
Consistency Improvements: [Resolved inconsistencies]
"""
```

## Detailed Workflow Example

### **Example: E-Commerce Order Processing Feature**

#### **Step 1: Big Requirements Analysis**
```bash
/review-spec "complex e-commerce requirements.md"
```

**Output**: Features like "Order Management", "Payment Processing", "Inventory Management"

#### **Step 2: Big Event Storming**
```bash
/agent event-storming-agent
```

**Output**: High-level domain model with bounded contexts, major aggregates, and key business processes

#### **Step 3: Feature-Level Processing (for each feature)**

**For "Payment Processing" feature:**
```bash
/specify "Payment Processing - Support credit card and PayPal payments"
/clarify
```

**After Clarification:**
- Specific payment methods: Visa, MasterCard, PayPal
- Clear validation rules and error handling
- Defined integration with payment gateways
- Specific security requirements

#### **Step 4: Feature Event Storming**
```bash
# Query feature context
/kb-query "payment processing domain context"
/kb-query "existing payment aggregates"
/kb-query "payment-related business rules"

# Feature Event Storming
/agent event-storming-agent
```

**Feature Event Storming Input:**
```markdown
## Feature: Payment Processing
**Scope**: Credit card and PayPal payment processing
**User Stories**:
- As a customer, I want to pay with credit card
- As a customer, I want to pay with PayPal
- As an admin, I want to view payment history

**Acceptance Criteria**:
- Payment validation with proper error handling
- Integration with Stripe and PayPal APIs
- Secure storage of payment information
- Payment status tracking and notifications

## Domain Context (from Big Event Storming)
**Bounded Context**: Payment Processing
**Related Aggregates**: Order, Payment, Customer
**Domain Events**: OrderPlaced, PaymentProcessed, PaymentFailed
```

**Feature Event Storming Outputs:**
```markdown
## Feature-Specific Events
- PaymentValidationStarted
- PaymentValidationCompleted
- PaymentAuthorizationRequested
- PaymentAuthorizationSucceeded
- PaymentAuthorizationFailed
- PaymentProcessed
- PaymentFailed
- PaymentRefunded

## Feature Commands
- ValidatePaymentMethod
- AuthorizePayment
- ProcessPayment
- RefundPayment
- GetPaymentStatus

## Feature Aggregates
- PaymentMethod (CreditCard, PayPalAccount)
- PaymentTransaction
- PaymentAuthorization
- PaymentRefund

## Feature Integration Points
- Stripe API (credit card processing)
- PayPal API (PayPal payments)
- Order Service (order status updates)
- Notification Service (payment notifications)
```

#### **Step 5: Big Model Update**
```bash
# Update big Event Storming with payment processing insights
/kb-ingest_spec """
Big Event Storming Updates - Payment Processing Feature:
New Domain Events: PaymentValidationStarted, PaymentValidationCompleted, etc.
Enhanced Aggregates: PaymentMethod now includes CreditCard and PayPal specifics
Refined Processes: Payment authorization process detailed
New Integration Points: Stripe and PayPal APIs documented
Security Requirements: Payment data handling requirements added
"""
```

## Knowledge Base Synchronization Strategy

### **Feature-to-Big Model Synchronization**

#### **Event Synchronization**
```bash
# Feature events inform big model
/kb-ingest_spec """
Event Synchronization:
Feature Events: [List of feature events]
Big Model Events: [Corresponding big model events]
Relationships: [How feature events relate to big model events]
New Events: [Events that should be added to big model]
"""
```

#### **Aggregate Enhancement**
```bash
# Feature aggregates enhance big model aggregates
/kb-ingest_spec """
Aggregate Enhancement:
Feature Aggregates: [List of feature aggregates]
Big Model Aggregates: [Corresponding big model aggregates]
Enhancements: [How feature aggregates improve big model]
New Aggregates: [Aggregates that should be added to big model]
"""
```

#### **Business Rule Refinement**
```bash
# Business rules discovered during feature analysis
/kb-ingest_spec """
Business Rule Refinement:
Feature Rules: [Feature-specific business rules]
Big Model Rules: [Corresponding big model rules]
Refinements: [How feature rules refine big model rules]
New Rules: [Rules that should be added to big model]
"""
```

### **Consistency Maintenance**

#### **Cross-Feature Consistency Checks**
```bash
# Regular consistency validation
/kb-query "consistent business rules across features"
/kb-query "consistent entity definitions across features"
/kb-query "consistent integration patterns across features"
```

#### **Conflict Resolution**
```bash
# Identify and resolve conflicts
/kb-query "conflicting feature requirements"
/kb-query "conflicting business rules between features"
/kb-query "inconsistent entity relationships"
```

## Implementation Benefits

### **Improved Specification Quality**
- **Concrete Requirements**: Event Storming after clarification ensures specific, implementable specifications
- **Domain Alignment**: Feature-level Event Storming maintains alignment with overall domain model
- **Implementation Ready**: Detailed domain models directly inform technical implementation

### **Enhanced Knowledge Base**
- **Progressive Refinement**: Big model is continuously enhanced with feature-level insights
- **Feature Context**: Each feature has rich domain context and relationships
- **Pattern Discovery**: Cross-feature patterns are identified and documented

### **Better Stakeholder Alignment**
- **Feature Focus**: Each Event Storming session focuses on specific feature scope
- **Clear Boundaries**: Feature boundaries are well-defined and understood
- **Shared Understanding**: Both business and technical teams share the same domain model

### **Faster Implementation**
- **Detailed Models**: Feature-level domain models provide implementation guidance
- **Reusable Patterns**: Common patterns are identified and reused across features
- **Reduced Rework**: Better upfront understanding reduces implementation rework

## Best Practices

### **Feature Event Storming Best Practices**

#### **Preparation**
- **Clear Feature Scope**: Ensure feature scope is well-defined before Event Storming
- **Stakeholder Alignment**: All stakeholders understand the feature context
- **Domain Context**: Review big Event Storming model for relevant context
- **Knowledge Preparation**: Query knowledge base for relevant patterns and insights

#### **During Event Storming**
- **Feature Focus**: Keep focus on feature-specific domain events and processes
- **Big Model Alignment**: Ensure consistency with overall domain model
- **Implementation Context**: Consider technical constraints and requirements
- **Integration Planning**: Identify and plan external system integrations

#### **Post Event Storming**
- **Knowledge Integration**: Systematically ingest Event Storming results
- **Big Model Updates**: Update big Event Storming model with feature insights
- **Consistency Validation**: Ensure consistency across all domain models
- **Pattern Documentation**: Document reusable patterns and approaches

### **Big Model Maintenance Best Practices**

#### **Regular Updates**
- **Feature Integration**: Regularly integrate feature-level insights into big model
- **Consistency Checks**: Validate consistency across all domain models
- **Pattern Refinement**: Refine domain patterns based on feature implementation
- **Stakeholder Review**: Regular big model reviews with stakeholders

#### **Quality Assurance**
- **Cross-Feature Validation**: Validate consistency across all features
- **Business Rule Consistency**: Ensure consistent business rules across the domain
- **Entity Relationship Validation**: Validate entity relationships across models
- **Integration Point Mapping**: Ensure consistent integration point documentation

## Success Metrics

### **Feature-Level Metrics**
- **Event Storming Efficiency**: Time to complete feature Event Storming
- **Specification Quality**: Reduction in specification defects
- **Implementation Speed**: Faster implementation due to detailed domain models
- **Stakeholder Satisfaction**: Feature stakeholder satisfaction scores

### **Big Model Metrics**
- **Model Completeness**: Coverage of domain concepts in big model
- **Model Consistency**: Consistency across all domain models
- **Pattern Reuse**: Reuse of domain patterns across features
- **Knowledge Base Value**: Overall value of knowledge base to the project

### **Overall Project Metrics**
- **Development Efficiency**: Overall development efficiency improvements
- **Quality Improvement**: Reduction in defects and rework
- **Stakeholder Alignment**: Improved stakeholder alignment and satisfaction
- **Knowledge Asset Value**: Long-term value of accumulated domain knowledge

## Conclusion

Feature-level Event Storming after the `/clarify` step provides a powerful approach to domain modeling that combines the benefits of both high-level domain understanding and detailed feature analysis. This approach ensures that:

1. **Each Feature Gets Proper Attention**: Individual features receive focused domain modeling
2. **Requirements Are Concrete**: Event Storming happens after requirements are clarified
3. **Big Model Continuously Improves**: The overall domain model is enhanced with feature insights
4. **Implementation Is Better Informed**: Detailed domain models directly guide implementation
5. **Knowledge Base Grows Organically**: Both feature-specific and general domain knowledge are captured

This refined workflow represents a significant improvement in spec-driven development, providing the right level of domain analysis at the right time while maintaining consistency across the entire project.
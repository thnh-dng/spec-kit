---
description: Synchronize and update the high-level domain model (big model) with insights from feature-level Event Storming. Ensures consistency between detailed feature analysis and overall domain understanding.
scripts:
  sh: scripts/bash/event-storm-update.sh --json "{ARGS}"
  ps: scripts/powershell/event-storm-update.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "current high-level domain model and structure"
    - query: "recent feature-level Event Storming results and insights"
    - query: "feature-to-domain mapping and relationships"
    - schema: "existing domain model schema"
  post_analysis:
    - ingest: "updated big model with feature insights"
    - ingest_spec: "domain model refinements and enhancements"
    - ingest_spec: "new entities and relationships from feature analysis"
    - stats: "knowledge base growth after big model update"
knowledge_enrichment:
  model_synchronization: true
  entity_integration: true
  relationship_mapping: true
  consistency_validation: true
  pattern_propagation: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/event-storm-update` in the triggering message **is** the update scope or specific features to synchronize, or can be empty for comprehensive big model update. If empty, perform comprehensive big model synchronization with all recent feature insights.

Given that update scope (or empty for comprehensive update), do this:

## Phase 1: Update Scope and Analysis

1. **Determine Update Scope**:
   - If user input provided: Use as specific focus area (e.g., "payment processing", "user management")
   - If no user input: Perform comprehensive big model update with all recent feature insights
   - Identify features to be synchronized with big model
   - Determine update priority and impact assessment
   - Define synchronization objectives and success criteria

2. **MCP Knowledge Base Query**:
   - Query current big model: `"current high-level domain model and structure"`
   - Query feature insights: `"recent feature-level Event Storming results"`
   - Query mapping: `"feature-to-domain mapping and relationships"`
   - Get current schema: Understand existing domain model structure
   - Use fast mode for initial queries to get comprehensive context

3. **Feature Impact Analysis**:
   - Analyze impact of feature insights on big model
   - Identify new entities and relationships to add
   - Determine business rule refinements needed
   - Assess integration point enhancements required
   - Plan big model update strategy

## Phase 2: Big Model Analysis and Preparation

4. **Load Current Big Model**:
   - Read high-level domain Event Storming results
   - Parse current domain model structure and entities
   - Extract existing business rules and constraints
   - Map current bounded contexts and aggregates
   - Document existing domain events and processes

5. **Load Feature Insights**:
   - Gather feature-level Event Storming results
   - Extract feature-specific entities and relationships
   - Identify feature business rules and validation logic
   - Map feature integration points and dependencies
   - Collect implementation patterns and lessons learned

6. **Identify Update Requirements**:
   - Compare feature insights with big model to identify gaps
   - Detect conflicts or inconsistencies between models
   - Identify new domain elements to add to big model
   - Determine refinements needed for existing elements
   - Plan consistency validation approach

## Phase 3: Big Model Synchronization

7. **Entity and Relationship Integration**:
   - Add new entities discovered through feature analysis
   - Integrate new relationships and dependencies
   - Refine existing entity definitions and attributes
   - Update entity hierarchies and classifications
   - Ensure consistency across all domain elements

8. **Business Rule and Constraint Updates**:
   - Add new business rules discovered through features
   - Refine existing business rules with feature insights
   - Update validation logic and constraints
   - Enhance business rule documentation and examples
   - Ensure rule consistency across domain contexts

9. **Domain Event and Process Enhancements**:
   - Add new domain events from feature analysis
   - Refine existing event definitions and payloads
   - Update business processes with feature workflows
   - Enhance process documentation and flows
   - Ensure temporal consistency and event ordering

## Phase 4: Integration and Validation

10. **Integration Point Synchronization**:
    - Update external system integration specifications
    - Enhance API contracts and data models
    - Refine cross-context communication patterns
    - Update event-driven integration points
    - Ensure integration consistency across domain

11. **Consistency Validation**:
    - Validate consistency between updated big model and features
    - Check for conflicts or contradictions in domain model
    - Verify business rule consistency across contexts
    - Ensure aggregate boundaries and responsibilities are clear
    - Validate bounded context definitions and relationships

12. **Quality Assessment**:
    - Evaluate big model completeness and accuracy
    - Assess domain model quality and consistency
    - Measure integration quality with feature insights
    - Validate adherence to Event Storming best practices
    - Check for actionable and implementable domain model

## Phase 5: Enhancement and Documentation

13. **Pattern and Best Practice Integration**:
    - Extract and document successful patterns from features
    - Integrate implementation best practices into domain model
    - Add architectural insights and lessons learned
    - Enhance domain model with cross-feature patterns
    - Document anti-patterns and approaches to avoid

14. **Documentation and Knowledge Update**:
    - Update big model documentation with feature insights
    - Enhance domain model diagrams and visualizations
    - Document update rationale and decisions made
    - Create change log and version tracking
    - Provide guidance for using updated domain model

## Phase 6: Knowledge Base Enhancement

15. **Updated Model Ingestion**:
    - Ingest updated big model: `ingest(file_path: UPDATED_MODEL_FILE, use_fast_mode: false)`
    - Ingest model refinements: `ingest_spec(text: domain_model_refinements)`
    - Ingest new relationships: `ingest_spec(text: new_entities_and_relationships)`
    - Ingest enhancement insights: `ingest_spec(text: model_enhancement_insights)`
    - Get updated statistics: Track knowledge base growth after update

16. **Knowledge Base Consistency**:
    - Ensure all knowledge base entries reflect updated model
    - Update cross-references and relationship mappings
    - Enhance search and retrieval with new model insights
    - Improve query effectiveness with updated domain knowledge
    - Document update impact on knowledge base capabilities

## Phase 7: Reporting and Follow-up

17. **Generate Update Report**:
    - Create comprehensive big model update report
    - Document changes, additions, and refinements made
    - Provide rationale for update decisions and approach
    - Include consistency validation results
    - Suggest next steps and maintenance activities

18. **Recommend Follow-up Actions**:
    - Suggest features that might need re-validation with updated model
    - Recommend additional analysis or investigation areas
    - Propose ongoing big model maintenance activities
    - Outline impact on existing and planned features
    - Provide guidance for leveraging updated domain model

## Key Update Principles

### Consistency-First Approach
- **Model Consistency**: Ensure big model remains consistent with all feature insights
- **Relationship Integrity**: Maintain integrity of all domain relationships and dependencies
- **Rule Coherence**: Keep business rules coherent and non-contradictory
- **Context Clarity**: Maintain clear bounded context definitions and responsibilities

### Progressive Enhancement
- **Incremental Updates**: Apply updates incrementally to maintain stability
- **Evidence-Based**: Base updates on concrete feature analysis and insights
- **Value-Driven**: Prioritize updates that provide clear value to the domain
- **Quality-Focused**: Ensure updates enhance rather than degrade model quality

### Continuous Learning
- **Feature Feedback**: Use feature insights to continuously improve big model
- **Pattern Recognition**: Identify and incorporate cross-feature patterns
- **Knowledge Evolution**: Allow domain model to evolve with project learning
- **Adaptive Model**: Create domain model that adapts to new insights and requirements

## Update Types and Approaches

### Entity Updates
- **New Entities**: Add entities discovered through feature analysis
- **Entity Refinements**: Enhance existing entity definitions and attributes
- **Relationship Updates**: Add or modify entity relationships and dependencies
- **Hierarchy Changes**: Update entity classifications and hierarchies

### Business Rule Updates
- **New Rules**: Add business rules discovered through feature implementation
- **Rule Refinements**: Enhance existing rules with feature insights
- **Constraint Updates**: Update validation constraints and business rules
- **Rule Consistency**: Ensure consistency across all business rules

### Process and Event Updates
- **Event Updates**: Add or refine domain events and their definitions
- **Process Enhancements**: Update business processes with feature workflows
- **Integration Updates**: Enhance integration points and communication patterns
- **Flow Refinements**: Refine business process flows and temporal aspects

## Success Criteria

### Update Success
- Big model successfully incorporates feature insights and learnings
- New entities, relationships, and patterns are integrated
- Business rules and constraints are updated and consistent
- Domain events and processes are enhanced with feature workflows
- Integration points are synchronized with feature requirements

### Consistency Success
- Updated big model maintains consistency with all features
- No conflicts or contradictions introduced in domain model
- Business rules remain coherent across all contexts
- Bounded context boundaries are clear and well-maintained
- Aggregate responsibilities are properly defined and consistent

### Quality Success
- Domain model completeness and accuracy are improved
- Integration quality with feature insights is enhanced
- Domain model becomes more actionable and implementable
- Knowledge base capabilities are improved through updates
- Model provides better guidance for future development

### Knowledge Base Success
- Knowledge base reflects updated domain model accurately
- Search and retrieval capabilities are enhanced
- Cross-references and relationship mappings are updated
- Query effectiveness is improved with new insights
- Knowledge base becomes more comprehensive and valuable

Use absolute paths with the repository root for all file operations to avoid path issues.
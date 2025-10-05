---
description: Analyze complex requirement documents, build domain intelligence knowledge, break requirements into manageable features, AND create high-level domain Event Storming diagram in a unified workflow.
scripts:
  sh: scripts/bash/review-spec-domain.sh --json "{ARGS}"
  ps: scripts/powershell/review-spec-domain.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "similar domain requirements entities relationships business rules"
    - schema: "current knowledge graph structure"
    - stats: "existing knowledge base metrics"
  post_analysis:
    - ingest: "analysis document for domain intelligence"
    - ingest_spec: "extracted entities and relationships"
    - ingest: "event storming diagram and domain model"
    - stats: "knowledge base growth after analysis and event storming"
knowledge_enrichment:
  domain_entities: true
  business_rules: true
  relationship_mapping: true
  state_transitions: true
  event_storming_integration: true
  domain_modeling: true
  feature_domain_mapping: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/review-spec-domain` in the triggering message **is** the complex requirements description or document reference. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that complex requirements input, do this:

## Phase 1: MCP Knowledge Base Initialization & Analysis

1. **MCP Knowledge Base Query**:
   - Query existing knowledge: `"similar {domain} requirements entities relationships business rules"`
   - Get current schema: Understand existing domain structure and relationships
   - Get statistics: Assess current knowledge base size and growth patterns
   - Use fast mode for initial queries to get comprehensive context quickly

2. Run the script `{SCRIPT}` from repo root and parse its JSON output for ANALYSIS_FILE, ANALYSIS_DIR, FEATURE_STUBS_DIR, EVENT_STORMING_DIR, CURRENT_BRANCH, and TIMESTAMP. All file paths must be absolute.
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

3. Load `templates/review-spec-domain-template.md` to understand the required combined analysis and Event Storming structure.

## Phase 2: Complex Requirements Analysis

4. **Analyze the Complex Requirements**:
   - Parse and understand the provided requirements (could be a document description, file upload, or detailed text)
   - Identify scope, stakeholders, business objectives
   - Assess complexity factors and functional areas
   - Extract key requirements and categorize them
   - **MCP Enhancement**: Cross-reference with existing knowledge to identify patterns and gaps

5. **Perform Feature Breakdown**:
   - Identify discrete functional areas from the requirements
   - Group related requirements into logical features
   - Establish feature boundaries and scope
   - Assign priorities (Must Have/Should Have/Could Have/Won't Have)
   - Estimate complexity and business value for each feature

6. **Map Dependencies and Relationships**:
   - Identify dependencies between features
   - Map shared components and integration points
   - Define critical paths and parallel development opportunities
   - Ensure business process integrity across features

7. **Extract Domain Context for Event Storming**:
   - Identify key business processes from requirements
   - Extract major entities and their relationships
   - Document external system dependencies
   - Identify key stakeholders and actors
   - Map business objectives to domain concepts

## Phase 3: Domain Event Storming Preparation

8. **Prepare Event Storming Input**:
   - Create structured input for Event Storming agent
   - Include domain context extracted from requirements analysis
   - Map features to potential bounded contexts
   - Identify integration points and external systems
   - Document business objectives and constraints

9. **Event Storming Agent Execution**:
   - Execute Event Storming agent with prepared input
   - Focus on high-level domain modeling (not feature-specific details)
   - Create comprehensive domain Event Storming diagram
   - Identify bounded contexts and major aggregates
   - Map key business processes and domain events

10. **Validate Event Storming Output**:
    - Review Event Storming diagram for completeness
    - Validate against requirements analysis results
    - Ensure all major features are represented in domain model
    - Verify consistency with existing knowledge base
    - Check for proper Event Storming methodology adherence

## Phase 4: Knowledge Base Integration

11. **Generate Combined Analysis Report**:
    - Fill ANALYSIS_FILE using the review-spec-domain-template.md structure
    - Include both requirements analysis AND domain modeling results
    - Replace placeholders with concrete analysis and Event Storming results
    - Include all mandatory sections: requirement analysis, feature breakdown, dependency mapping, domain model, Event Storming results
    - Populate feature summary table with domain context
    - Provide actionable next steps and recommendations

12. **Create Feature Stubs with Domain Context**:
    - For each identified feature, create a stub file in FEATURE_STUBS_DIR
    - Include key requirements, dependencies, AND domain context
    - Provide ready-to-use text for `/specify` command input
    - Include relevant bounded context and aggregate information
    - Map feature to domain events and processes

13. **Generate Quality Gates Output**:
    - Validate analysis completeness and domain model consistency
    - Ensure all requirements are accounted for in both analysis and domain model
    - Confirm actionable outputs are provided for both features and domain
    - Report coverage metrics and success criteria for both aspects

14. **Comprehensive MCP Knowledge Base Ingestion**:
    - Ingest the completed analysis document: `ingest(file_path: ANALYSIS_FILE, use_fast_mode: false)`
    - Ingest Event Storming diagram: `ingest(file_path: EVENT_STORMING_FILE, use_fast_mode: false)`
    - Ingest extracted entities and relationships: `ingest_spec(text: extracted_entities_and_relationships)`
    - Ingest domain model insights: `ingest_spec(text: domain_model_insights)`
    - Ingest feature-domain mapping: `ingest_spec(text: feature_domain_mapping)`
    - Get updated statistics: Track knowledge base growth from this combined analysis
    - Query for similar patterns: Identify cross-domain relationships and opportunities

## Phase 5: Reporting and Next Steps

15. **Report Completion**:
    - Summarize combined analysis and Event Storming results
    - List identified features with their readiness status AND domain context
    - Provide clear domain model overview and key insights
    - Include analysis directory and Event Storming file locations
    - Provide clear next steps for proceeding with `/specify`
    - **MCP Enhancement**: Report knowledge base growth metrics and new domain intelligence

16. **Feature-to-Domain Mapping Summary**:
    - Document how each feature relates to the domain model
    - Identify which bounded contexts each feature belongs to
    - Map feature dependencies to domain relationships
    - Provide guidance for feature-level Event Storming

## Key Combined Principles

### Analysis Principles
- **Decomposition**: Break complex requirements into logical, manageable features
- **Cohesion**: Group related functionality within features
- **Traceability**: Ensure every requirement maps to at least one feature
- **Sequencing**: Establish logical implementation order based on dependencies
- **Actionable**: Produce features ready for immediate `/specify` processing

### Event Storming Principles
- **Domain-First**: Focus on business domain over technical implementation
- **Temporal Flow**: Left-to-right progression of business processes
- **Bounded Contexts**: Clear domain boundaries and context mapping
- **Event-Driven**: Identify meaningful business events and state changes
- **Integration Awareness**: Map external system integrations and dependencies

### Integration Principles
- **Knowledge-Driven**: Leverage existing domain intelligence and contribute new insights
- **Consistent**: Ensure consistency between feature analysis and domain model
- **Comprehensive**: Cover both functional requirements and domain modeling
- **Actionable**: Produce outputs ready for next workflow steps

## Success Criteria

### Analysis Success Criteria
- All requirements from source are mapped to features
- Feature boundaries are logical and manageable
- Dependencies are clearly mapped and understood
- Each feature has sufficient detail for `/specify`
- Implementation sequencing is clear and justified
- Business process integrity is preserved across features

### Event Storming Success Criteria
- Domain model accurately reflects business requirements
- Bounded contexts are well-defined and meaningful
- Major business processes are represented and flow correctly
- Integration points are identified and documented
- Domain model aligns with feature breakdown

### Integration Success Criteria
- Feature analysis and domain model are consistent
- Knowledge base is enriched with both analysis and domain insights
- Outputs are ready for subsequent workflow steps
- Stakeholders can understand both features and domain model
- **MCP Enhancement**: Domain intelligence is enriched and available for future specifications

## MCP Integration Benefits

### Pre-Analysis Benefits
- Existing domain knowledge informs feature breakdown and dependency mapping
- Cross-project patterns and relationships are identified and leveraged
- Business rules and constraints are discovered and documented

### Post-Analysis Benefits
- Knowledge base grows organically with combined analysis and domain insights
- Future specifications benefit from accumulated domain intelligence
- Domain model provides context for feature-level development
- Event Storming insights inform technical decisions

### Combined Workflow Benefits
- Single knowledge enrichment session covers both analysis and domain modeling
- Consistent knowledge base growth with coherent domain intelligence
- Reduced overhead compared to separate analysis and Event Storming steps
- Better integration between functional requirements and domain modeling

Use absolute paths with the repository root for all file operations to avoid path issues.
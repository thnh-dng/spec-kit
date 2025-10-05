---
description: Perform feature-level Event Storming after clarification, when requirements are concrete and feature scope is well-defined. Creates detailed domain models specific to individual features.
scripts:
  sh: scripts/bash/event-storm-feature.sh --json "{ARGS}"
  ps: scripts/powershell/event-storm-feature.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "feature clarification results and domain context"
    - query: "similar features and implementation patterns"
    - query: "relevant aggregates and entities from domain model"
  post_analysis:
    - ingest: "feature Event Storming results and domain model"
    - ingest_spec: "feature-specific entities and relationships"
    - ingest_spec: "feature business rules and validation logic"
knowledge_enrichment:
  feature_entities: true
  business_rules: true
  integration_points: true
  validation_logic: true
  error_handling: true
  implementation_patterns: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/event-storm-feature` in the triggering message **is** the feature context or can be empty if working with current feature. If empty, you'll work with the current feature context.

Given that feature context (or empty for current feature), do this:

## Phase 1: Feature Context Analysis

1. **Identify Current Feature Context**:
   - Check if working in a feature directory (`features/[feature-name]/`)
   - Load feature specification and clarification results
   - Identify domain context from high-level model
   - Extract concrete requirements and business rules

2. **MCP Knowledge Base Query**:
   - Query feature clarification results: `"clarified requirements for [feature]"`
   - Query domain context: `"domain model context for [feature]"`
   - Query similar features: `"similar features across projects"`
   - Query implementation patterns: `"implementation patterns for [feature-type]"`
   - Use fast mode for initial queries to get comprehensive context quickly

3. **Determine Event Storming Scope**:
   - If user input provided: Use as specific guidance for Event Storming focus
   - If no user input: Perform comprehensive feature-level Event Storming
   - Identify bounded context and related aggregates
   - Map integration points and external dependencies

## Phase 2: Feature Event Storming Preparation

4. **Load Feature Artifacts**:
   - Read feature specification (`features/[feature-name]/spec.md`)
   - Read clarification results (`features/[feature-name]/clarification-results.md`)
   - Extract domain context from high-level Event Storming results
   - Identify concrete requirements and resolved ambiguities

5. **Prepare Event Storming Input**:
   - Create structured input focusing on feature-specific domain events
   - Include feature commands and user interactions
   - Map feature aggregates and entities (specific to this feature)
   - Document feature business processes and integration points
   - Include validation logic and error handling requirements

6. **Execute Event Storming Agent**:
   - Run Event Storming agent with feature-specific input
   - Focus on detailed domain modeling (not high-level overview)
   - Create feature-specific Event Storming diagram
   - Identify feature aggregates, entities, and business rules
   - Map feature business processes and integration points

## Phase 3: Feature Domain Model Integration

7. **Generate Feature Event Storming Report**:
   - Create comprehensive feature-level domain model documentation
   - Document feature-specific domain events and commands
   - Map feature aggregates and their business rules
   - Detail feature business processes and workflows
   - Identify integration points and external system interactions

8. **Create Feature Implementation Guidance**:
   - Provide implementation guidance based on feature domain model
   - Document data model implications
   - Specify API contracts and integration requirements
   - Define validation logic and business rule enforcement
   - Outline error handling and edge cases

## Phase 4: Knowledge Base Enhancement

9. **Feature Knowledge Ingestion**:
   - Ingest feature Event Storming results: `ingest(file_path: FEATURE_EVENT_STORMING_FILE, use_fast_mode: false)`
   - Ingest feature domain model: `ingest_spec(text: feature_domain_model)`
   - Ingest business rules: `ingest_spec(text: feature_business_rules)`
   - Ingest integration specifications: `ingest_spec(text: feature_integration_specs)`
   - Get updated statistics: Track knowledge base growth from feature analysis

10. **Big Model Update Preparation**:
    - Analyze impact on high-level domain model
    - Identify new entities and relationships to add
    - Document refined business rules and constraints
    - Prepare big model update recommendations

## Phase 5: Implementation Readiness

11. **Feature Implementation Readiness Assessment**:
    - Validate feature domain model completeness
    - Ensure all business rules are documented
    - Confirm integration points are well-defined
    - Verify implementation guidance is actionable
    - Assess readiness for `/plan` phase

12. **Generate Next Steps**:
    - Provide clear guidance for proceeding to `/plan`
    - Document feature domain model artifacts
    - Identify any remaining ambiguities or gaps
    - Recommend implementation approach based on domain model

## Key Feature-Level Event Storming Principles

### Feature Focus
- **Concrete Requirements**: Event Storming happens after clarification when requirements are specific
- **Feature Scope**: Limited to specific feature boundaries and context
- **Implementation Ready**: Detailed models directly guide feature development
- **Integration Aware**: Considers feature integration points and dependencies

### Domain Model Consistency
- **High-Level Alignment**: Maintains consistency with high-level domain model
- **Feature-Specific Detail**: Provides detailed modeling specific to feature needs
- **Bidirectional Learning**: Feature insights inform big model updates
- **Context Awareness**: Understands feature's place in overall domain

### Knowledge Base Integration
- **Progressive Enrichment**: Adds feature-specific domain intelligence
- **Pattern Discovery**: Identifies cross-feature patterns and relationships
- **Implementation Guidance**: Provides concrete implementation insights
- **Quality Assurance**: Validates consistency with existing domain knowledge

## Success Criteria

### Event Storming Success
- Feature domain model accurately reflects clarified requirements
- All feature business rules and validation logic are documented
- Integration points and dependencies are clearly identified
- Implementation guidance is actionable and comprehensive
- Domain model maintains consistency with high-level model

### Knowledge Base Success
- Feature-specific domain intelligence is captured and structured
- Implementation patterns and insights are documented
- Cross-feature relationships and patterns are identified
- Big model update recommendations are prepared
- Knowledge base grows with feature-specific insights

### Implementation Readiness
- Feature is ready for `/plan` phase with detailed domain model
- Implementation approach is clear and well-guided
- Integration requirements are fully specified
- Business rules and validation logic are documented
- Development team has comprehensive domain understanding

Use absolute paths with the repository root for all file operations to avoid path issues.
---
description: Analyze complex requirement documents and build domain intelligence knowledge while breaking them down into manageable features.
scripts:
  sh: scripts/bash/review-spec.sh --json "{ARGS}"
  ps: scripts/powershell/review-spec.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "similar domain requirements entities relationships business rules"
    - schema: "current knowledge graph structure"
    - stats: "existing knowledge base metrics"
  post_analysis:
    - ingest: "analysis document for domain intelligence"
    - ingest_spec: "extracted entities and relationships"
    - stats: "knowledge base growth after analysis"
knowledge_enrichment:
  domain_entities: true
  business_rules: true
  relationship_mapping: true
  state_transitions: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/review-spec` in the triggering message **is** the complex requirements description or document reference. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that complex requirements input, do this:

1. **MCP Knowledge Base Initialization**:
   - Query existing knowledge: `"similar {domain} requirements entities relationships business rules"`
   - Get current schema: Understand existing domain structure and relationships
   - Get statistics: Assess current knowledge base size and growth patterns
   - Use fast mode for initial queries to get comprehensive context quickly

2. Run the script `{SCRIPT}` from repo root and parse its JSON output for ANALYSIS_FILE, ANALYSIS_DIR, FEATURE_STUBS_DIR, CURRENT_BRANCH, and TIMESTAMP. All file paths must be absolute.
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

3. Load `templates/review-spec-template.md` to understand the required analysis structure and sections.

4. **Analyze the Complex Requirements**:
   - Parse and understand the provided requirements (could be a document description, file upload, or detailed text)
   - Identify scope, stakeholders, business objectives
   - Assess complexity factors and functional areas
   - Extract key requirements and categorize them
   - **MCP Enhancement**: Cross-reference with existing knowledge to identify patterns and gaps

4. **Perform Feature Breakdown**:
   - Identify discrete functional areas from the requirements
   - Group related requirements into logical features
   - Establish feature boundaries and scope
   - Assign priorities (Must Have/Should Have/Could Have/Won't Have)
   - Estimate complexity and business value for each feature

5. **Map Dependencies and Relationships**:
   - Identify dependencies between features
   - Map shared components and integration points
   - Define critical paths and parallel development opportunities
   - Ensure business process integrity across features

6. **Generate Implementation Roadmap**:
   - Create recommended phasing for implementation
   - Assess risks and identify mitigation strategies
   - Provide timeline estimates (relative sizing)
   - Identify coordination needs between features

7. **Assess Feature Readiness**:
   - Evaluate each feature for readiness to proceed with `/specify`
   - Identify clarifications needed for each feature
   - Validate completeness and testability
   - Ensure proper scoping and boundaries

8. **Write Analysis Report**:
   - Fill ANALYSIS_FILE using the review-spec-template.md structure
   - Replace placeholders with concrete analysis results
   - Include all mandatory sections: requirement analysis, feature breakdown, dependency mapping, implementation roadmap, readiness assessment
   - Populate feature summary table and dependency matrix
   - Provide actionable next steps and recommendations

9. **Create Feature Stubs** (optional but recommended):
   - For each identified feature, create a stub file in FEATURE_STUBS_DIR
   - Include key requirements and dependencies for each feature
   - Provide ready-to-use text for `/specify` command input

10. **Generate Quality Gates Output**:
    - Validate analysis completeness and integrity preservation
    - Ensure all requirements are accounted for
    - Confirm actionable outputs are provided
    - Report coverage metrics and success criteria

12. **MCP Knowledge Base Ingestion**:
    - Ingest the completed analysis document: `ingest(file_path: ANALYSIS_FILE, use_fast_mode: false)`
    - Ingest extracted entities and relationships: `ingest_spec(text: extracted_entities_and_relationships)`
    - Ingest feature breakdown and dependencies: `ingest_spec(text: feature_breakdown_with_dependencies)`
    - Get updated statistics: Track knowledge base growth from this analysis
    - Query for similar patterns: Identify cross-domain relationships and opportunities

13. **Report Completion**:
    - Summarize analysis results and key findings
    - List identified features with their readiness status
    - Provide clear next steps for proceeding with `/specify`
    - Include analysis directory location and current branch context for reference
    - **MCP Enhancement**: Report knowledge base growth metrics and new domain intelligence

**Key Analysis Principles**:
- **Decomposition**: Break complex requirements into logical, manageable features
- **Cohesion**: Group related functionality within features
- **Traceability**: Ensure every requirement maps to at least one feature
- **Sequencing**: Establish logical implementation order based on dependencies
- **Actionable**: Produce features ready for immediate `/specify` processing
- **Knowledge-Driven**: Leverage existing domain intelligence and contribute new insights

**Success Criteria**:
- All requirements from source are mapped to features
- Feature boundaries are logical and manageable
- Dependencies are clearly mapped and understood
- Each feature has sufficient detail for `/specify`
- Implementation sequencing is clear and justified
- Business process integrity is preserved across features
- **MCP Enhancement**: Domain intelligence is enriched and available for future specifications

**MCP Integration Benefits**:
- Existing domain knowledge informs feature breakdown and dependency mapping
- Cross-project patterns and relationships are identified and leveraged
- Business rules and constraints are discovered and documented
- Knowledge base grows organically with each complex requirements analysis
- Future specifications benefit from accumulated domain intelligence

Use absolute paths with the repository root for all file operations to avoid path issues.
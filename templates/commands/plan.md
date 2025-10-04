---
description: Execute the implementation planning workflow with knowledge base integration to generate enhanced design artifacts.
scripts:
  sh: scripts/bash/setup-plan.sh --json
  ps: scripts/powershell/setup-plan.ps1 -Json
mcp_integration:
  pre_planning:
    - query: "{tech_stack} implementation patterns architecture decisions"
    - query: "similar features technical approaches data models"
    - query: "existing domain entities relationships for implementation"
    - schema: "technical implementation patterns structure"
  post_planning:
    - ingest: "complete implementation plan document"
    - ingest_spec: "technical decisions and rationale"
    - ingest_spec: "architecture patterns and design choices"
    - ingest_spec: "data models and API contracts"
    - stats: "technical knowledge growth after planning"
knowledge_enrichment:
  architecture_patterns: true
  technology_decisions: true
  implementation_strategies: true
  cross_feature_consistency: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

Given the implementation details provided as an argument, do this:

1. **MCP Knowledge Base Query**:
   - Query tech stack patterns: `"{tech_stack} implementation patterns architecture decisions"`
   - Query similar features: `"similar features technical approaches data models"`
   - Query domain entities: `"existing domain entities relationships for implementation"`
   - Get technical schema: Understand implementation patterns structure
   - Use limit: 10 for comprehensive technical context

2. Run `{SCRIPT}` from the repo root and parse JSON for FEATURE_SPEC, IMPL_PLAN, SPECS_DIR, BRANCH. All future file paths must be absolute.
   - BEFORE proceeding, inspect FEATURE_SPEC for a `## Clarifications` section with at least one `Session` subheading. If missing or clearly ambiguous areas remain (vague adjectives, unresolved critical choices), PAUSE and instruct the user to run `/clarify` first to reduce rework. Only continue if: (a) Clarifications exist OR (b) an explicit user override is provided (e.g., "proceed without clarification"). Do not attempt to fabricate clarifications yourself.

3. Read and analyze the feature specification to understand:
   - The feature requirements and user stories
   - Functional and non-functional requirements
   - Success criteria and acceptance criteria
   - Any technical constraints or dependencies mentioned
   - **MCP Enhancement**: Cross-reference with knowledge base for implementation insights

4. Read the constitution at `/memory/constitution.md` to understand constitutional requirements.
   - **MCP Enhancement**: Query for constitutional compliance patterns in similar projects

5. Execute the implementation plan template:
   - Load `/templates/plan-template.md` (already copied to IMPL_PLAN path)
   - Set Input path to FEATURE_SPEC
   - Run the Execution Flow (main) function steps 1-9
   - The template is self-contained and executable
   - Follow error handling and gate checks as specified
   - **MCP Enhancement**: Enrich artifact generation with knowledge base insights:
     * Research.md: Include similar implementation patterns and architecture decisions
     * Data-model.md: Reference existing domain entities and relationships
     * Contracts/: Include API patterns from similar features
     * Tasks.md: Leverage task decomposition patterns from similar features
   - Let the template guide artifact generation in $SPECS_DIR:
     * Phase 0 generates research.md (enhanced with MCP insights)
     * Phase 1 generates data-model.md, contracts/, quickstart.md (with knowledge base references)
     * Phase 2 generates tasks.md (with implementation pattern insights)
   - Incorporate user-provided details from arguments into Technical Context: {ARGS}
   - Update Progress Tracking as you complete each phase

6. **MCP Knowledge Base Ingestion**:
   - Ingest implementation plan: `ingest(file_path: IMPL_PLAN, use_fast_mode: false)`
   - Ingest technical decisions: `ingest_spec(text: technical_decisions_and_rationale)`
   - Ingest architecture patterns: `ingest_spec(text: architecture_patterns_and_choices)`
   - Ingest data models: `ingest_spec(text: data_models_and_api_contracts)`
   - Get updated statistics: Track technical knowledge growth

7. Verify execution completed:
   - Check Progress Tracking shows all phases complete
   - Ensure all required artifacts were generated
   - Confirm no ERROR states in execution

8. Report results with branch name, file paths, generated artifacts, and technical knowledge enrichment summary.

**MCP Integration Benefits**:
- Implementation plans leverage proven architectural patterns
- Technical decisions are informed by similar project outcomes
- Data models benefit from existing domain intelligence
- Task decomposition uses proven patterns from similar features
- Cross-feature consistency is maintained through shared knowledge
- Technical knowledge base grows with each implementation plan

Use absolute paths with the repository root for all file operations to avoid path issues.

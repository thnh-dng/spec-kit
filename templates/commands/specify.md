---
description: Create or update the feature specification with knowledge base enhancement and domain intelligence integration.
scripts:
  sh: scripts/bash/create-new-feature.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json "{ARGS}"
mcp_integration:
  pre_specification:
    - query: "existing {feature_domain} entities relationships business rules"
    - query: "similar features implementation patterns requirements"
    - schema: "domain model structure for context"
  post_specification:
    - ingest: "complete specification document"
    - ingest_spec: "user stories and functional requirements"
    - ingest_spec: "entities and business rules extracted"
    - stats: "knowledge base growth after specification"
knowledge_enrichment:
  entity_extraction: true
  requirement_enrichment: true
  pattern_matching: true
  cross_domain_linking: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/specify` in the triggering message **is** the feature description. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that feature description, do this:

1. **MCP Knowledge Base Query**:
   - Query existing domain knowledge: `"existing {feature_domain} entities relationships business rules"`
   - Query similar features: `"similar features implementation patterns requirements"`
   - Get schema context: Understand current domain model structure
   - Use limit: 8 for comprehensive but focused results

2. Run the script `{SCRIPT}` from repo root and parse its JSON output for BRANCH_NAME and SPEC_FILE. All file paths must be absolute.
  **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

3. Load `templates/spec-template.md` to understand required sections.

4. **Enhanced Specification Creation**:
   - Write the specification to SPEC_FILE using the template structure
   - **MCP Enhancement**: Enrich specification with existing domain intelligence:
     * Suggest related entities and relationships from knowledge base
     * Recommend similar feature patterns and requirements
     * Identify potential missing requirements based on domain gaps
     * Cross-reference with business rules and constraints
   - Replace placeholders with concrete details derived from feature description and knowledge base insights

5. **MCP Knowledge Base Ingestion**:
   - Ingest complete specification: `ingest(file_path: SPEC_FILE, use_fast_mode: false)`
   - Ingest user stories: `ingest_spec(text: user_stories_and_acceptance_criteria)`
   - Ingest entities: `ingest_spec(text: extracted_entities_and_relationships)`
   - Ingest business rules: `ingest_spec(text: business_rules_and_constraints)`
   - Get updated statistics: Track knowledge base growth

6. Report completion with branch name, spec file path, knowledge enrichment summary, and readiness for the next phase.

**MCP Integration Benefits**:
- Specifications leverage existing domain intelligence
- Missing requirements are identified and suggested
- Entity relationships are enriched with domain context
- Business rules are discovered and documented
- Knowledge base grows with each specification created
- Future plans benefit from accumulated feature intelligence

Note: The script creates and checks out the new branch and initializes the spec file before writing.

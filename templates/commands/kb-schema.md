---
description: Display and analyze the knowledge base schema including entities, relationships, and patterns.
scripts:
  sh: scripts/bash/knowledge-schema.sh --json "{ARGS}"
  ps: scripts/powershell/knowledge-schema.ps1 -Json "{ARGS}"
mcp_integration:
  pre_schema_analysis:
    - query: "knowledge base schema structure and entity relationships"
    - query: "domain patterns and architectural frameworks"
    - schema: "complete knowledge graph structure"
    - stats: "knowledge base growth metrics and patterns"
  post_schema_analysis:
    - ingest: "schema analysis results and insights"
    - ingest_spec: "domain intelligence and architectural patterns"
knowledge_enrichment:
  schema_analysis: true
  pattern_recognition: true
  domain_intelligence: true
  architectural_frameworks: true
usage_examples:
  - "Show me the current knowledge base structure"
  - "What entities and relationships exist in the e-commerce domain?"
  - "Display schema statistics and growth patterns"
  - "Analyze the knowledge base architecture"
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/kb-schema` in the triggering message **is** optional filter criteria for schema analysis. If empty, show complete schema.

Given that schema request, do this:

1. **MCP Schema Retrieval**:
   - Get current schema: `schema()`
   - Get knowledge base statistics: `stats()`
   - If filters provided in $ARGUMENTS, apply them to schema analysis

2. **Schema Analysis**:
   - Analyze node labels and their distribution
   - Examine relationship types and their frequencies
   - Identify domain clusters and knowledge areas
   - Assess schema completeness and coverage

3. **Knowledge Base Insights**:
   - Provide growth trends and patterns
   - Identify knowledge gaps and areas for expansion
   - Highlight well-developed vs. emerging domains
   - Show cross-domain connections and integrations

4. **Domain Intelligence Summary**:
   - Summarize key entities and their relationships
   - Highlight business rules and constraints captured
   - Show architectural patterns and decisions documented
   - Identify implementation strategies and approaches

5. **Recommendations**:
   - Suggest areas for knowledge base expansion
   - Recommend relationship types to develop
   - Identify entities that need more detail
   - Propose integration opportunities

**Success Criteria**:
- Schema is presented clearly and comprehensively
- Insights are actionable and context-aware
- Growth patterns are identified and explained
- Gaps and opportunities are clearly highlighted
- Recommendations are specific and practical

**Use Cases**:
- Understand current knowledge base structure
- Identify areas for knowledge expansion
- Plan domain intelligence development
- Assess knowledge base maturity and coverage

Use absolute paths with the repository root for all file operations to avoid path issues.
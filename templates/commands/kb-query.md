---
description: Query the knowledge base for existing requirements, entities, patterns, and implementation insights.
scripts:
  sh: scripts/bash/knowledge-query.sh --json "{ARGS}"
  ps: scripts/powershell/knowledge-query.ps1 -Json "{ARGS}"
mcp_tools:
  - query
  - schema
  - stats
usage_examples:
  - "Find similar user authentication patterns"
  - "What entities are related to order processing?"
  - "Show me React Node.js implementation patterns"
  - "What are the business rules for payment processing?"
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/kb-query` in the triggering message **is** the search query for the knowledge base. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that knowledge query, do this:

1. **MCP Query Execution**:
   - Execute query: `query(query: "$ARGUMENTS", limit: 8)`
   - If results are too broad, refine with domain-specific context
   - If results are too narrow, expand with related concepts
   - Use schema and stats to provide context about knowledge base coverage

2. **Knowledge Context Analysis**:
   - Analyze query results for relevant entities, relationships, and patterns
   - Identify cross-domain connections and related concepts
   - Extract implementation patterns and architectural decisions
   - Highlight business rules and constraints

3. **Insight Synthesis**:
   - Synthesize query results into actionable insights
   - Provide context about source documents and confidence levels
   - Suggest related queries for deeper exploration
   - Identify gaps in knowledge that might need additional research

4. **Recommendations**:
   - Recommend specific patterns or approaches based on query results
   - Suggest related features or components to consider
   - Identify potential integration points with existing knowledge
   - Highlight best practices and lessons learned

**Success Criteria**:
- Query results are relevant and comprehensive
- Insights are actionable and context-aware
- Recommendations are specific and practical
- Knowledge gaps are clearly identified
- Follow-up queries are suggested for deeper exploration

**Use Cases**:
- Before `/specify`: Understand existing domain patterns
- Before `/plan`: Research implementation approaches
- During clarification: Find similar requirement patterns
- For architecture decisions: Leverage proven patterns

Use absolute paths with the repository root for all file operations to avoid path issues.
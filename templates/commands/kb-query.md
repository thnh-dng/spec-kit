---
description: Query the knowledge base for domain intelligence, patterns, relationships, and insights. Provides intelligent search and analysis capabilities across all accumulated project knowledge.
scripts:
  sh: scripts/bash/kb-query.sh --json "{ARGS}"
  ps: scripts/powershell/kb-query.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "current knowledge base structure and statistics"
    - schema: "knowledge graph schema and relationships"
    - stats: "knowledge base size and growth metrics"
  post_analysis:
    - ingest: "query results and analysis insights"
    - ingest_spec: "query patterns and successful searches"
    - stats: "query effectiveness metrics"
knowledge_enrichment:
  query_optimization: true
  pattern_discovery: true
  relationship_analysis: true
  insight_extraction: true
  usage_tracking: true
usage_examples:
  - "Find similar user authentication patterns"
  - "What entities are related to order processing?"
  - "Show me React Node.js implementation patterns"
  - "What are the business rules for payment processing?"
  - "Domain context for payment processing feature"
  - "Similar features across e-commerce projects"
  - "Implementation patterns for real-time updates"
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/kb-query` in the triggering message **is** the search query. This is the knowledge base query to execute.

Given that query, do this:

## Phase 1: Query Analysis and Strategy

1. **Analyze Query Intent**:
   - Parse the user's query to understand information needs
   - Identify query type (factual, relational, pattern-based, analytical)
   - Determine search scope and specificity
   - Extract key concepts and relationships
   - Identify potential context requirements

2. **MCP Knowledge Base Strategy**:
   - Query knowledge base: `"$QUERY"` (using the user's exact query)
   - Use fast mode for quick results if query is straightforward
   - Use comprehensive mode for complex analytical queries
   - Set appropriate limit (1-20) based on query complexity
   - Determine if source documents should be included

3. **Query Optimization**:
   - Refine query for optimal knowledge base search
   - Identify related concepts and terminology
   - Expand query with synonyms and related terms
   - Plan multi-query strategy for complex information needs
   - Prepare follow-up queries for deeper investigation

## Phase 2: Knowledge Base Query Execution

4. **Execute Primary Query**:
   - Run the optimized query against knowledge base
   - Capture results including metadata and relationships
   - Analyze result relevance and completeness
   - Identify patterns and connections in results
   - Extract key insights and actionable information

5. **Execute Supplementary Queries** (if needed):
   - Run related queries to fill gaps in information
   - Query for specific patterns or relationships
   - Search for similar cases or precedents
   - Investigate related domain concepts
   - Gather supporting evidence and examples

6. **Result Analysis and Synthesis**:
   - Synthesize information from multiple queries
   - Identify key patterns and insights
   - Resolve conflicting or ambiguous information
   - Organize results by relevance and importance
   - Structure information for actionable use

## Phase 3: Insight Generation and Context

7. **Generate Actionable Insights**:
   - Extract practical insights from query results
   - Identify applicable patterns and approaches
   - Provide context-specific recommendations
   - Highlight relevant relationships and dependencies
   - Suggest related areas for further investigation

8. **Context Enhancement**:
   - Provide background context for results
   - Explain relationships between concepts
   - Highlight domain-specific implications
   - Connect results to current project context
   - Map findings to business objectives and requirements

## Phase 4: Query Optimization and Learning

9. **Query Effectiveness Analysis**:
   - Evaluate query effectiveness and result quality
   - Identify successful search strategies
   - Document query patterns and approaches
   - Suggest improvements for future queries
   - Capture lessons learned for query optimization

10. **Knowledge Base Enhancement**:
    - Document successful query patterns
    - Identify gaps in knowledge base coverage
    - Suggest areas for knowledge base enrichment
    - Contribute query insights to knowledge base
    - Improve search and retrieval capabilities

## Phase 5: Reporting and Follow-up

11. **Generate Query Report**:
    - Create comprehensive query results report
    - Document key findings and insights
    - Provide context and interpretation
    - Include source references and evidence
    - Suggest next steps and related queries

12. **Recommend Follow-up Actions**:
    - Suggest specific next steps based on results
    - Recommend additional queries for deeper investigation
    - Propose knowledge base enrichment activities
    - Outline implementation implications
    - Provide guidance for applying findings

## Key Query Principles

### User-Centric Approach
- **Intent Understanding**: Focus on understanding user's real information needs
- **Context Awareness**: Consider project and domain context in query interpretation
- **Actionable Results**: Provide practical, applicable information and insights
- **Follow-up Guidance**: Suggest next steps and related areas for investigation

### Intelligent Search
- **Multi-Strategy Approach**: Use different query strategies for different information types
- **Pattern Recognition**: Identify patterns and relationships in query results
- **Context Expansion**: Expand search to include related concepts and contexts
- **Quality Focus**: Prioritize relevance, accuracy, and usefulness of results

### Knowledge Base Learning
- **Continuous Improvement**: Learn from query patterns to improve future searches
- **Gap Identification**: Identify areas where knowledge base needs enhancement
- **Pattern Documentation**: Document successful query approaches and strategies
- **Relationship Mapping**: Capture and document relationships between concepts

## Query Types and Approaches

### Factual Queries
- **Purpose**: Retrieve specific facts, definitions, or information
- **Approach**: Direct search with specific terminology
- **Follow-up**: Validate sources and cross-reference information

### Relational Queries
- **Purpose**: Find relationships between concepts or entities
- **Approach**: Search for connections, dependencies, and interactions
- **Follow-up**: Explore related relationships and implications

### Pattern-Based Queries
- **Purpose**: Identify patterns, trends, or recurring approaches
- **Approach**: Search for similar cases, best practices, or methodologies
- **Follow-up**: Analyze pattern applicability and variations

### Analytical Queries
- **Purpose**: Gain insights, analysis, or strategic understanding
- **Approach**: Complex queries requiring synthesis of multiple information sources
- **Follow-up**: Deep dive into specific aspects or implications

## Success Criteria

### Query Success
- Query results directly address user's information needs
- Results are relevant, accurate, and comprehensive
- Information is presented in clear, actionable format
- Sources and evidence are properly documented
- Follow-up recommendations are provided and relevant

### Insight Success
- Practical insights are extracted from query results
- Context-specific recommendations are provided
- Relationships and implications are clearly explained
- Results can be directly applied to project needs
- New areas for investigation are identified

### Knowledge Base Success
- Query effectiveness is documented and analyzed
- Knowledge base gaps and improvements are identified
- Search patterns and strategies are captured
- Knowledge base is enhanced with query insights
- Future query capabilities are improved

**Use Cases**:
- Before `/specify`: Understand existing domain patterns
- Before `/plan`: Research implementation approaches
- During clarification: Find similar requirement patterns
- For architecture decisions: Leverage proven patterns
- For Event Storming: Gather domain context and intelligence
- For quality assurance: Validate against existing knowledge

Use absolute paths with the repository root for all file operations to avoid path issues.
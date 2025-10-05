---
description: Ingest documents, files, or text directly into the knowledge base for comprehensive entity extraction, relationship mapping, and intelligence enhancement. Provides structured knowledge ingestion with quality validation and integration analysis.
scripts:
  sh: scripts/bash/kb-ingest.sh --json "{ARGS}"
  ps: scripts/powershell/kb-ingest.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "current knowledge base structure and statistics"
    - schema: "existing knowledge graph schema"
    - stats: "knowledge base size and growth patterns"
  post_analysis:
    - ingest: "ingestion results and quality validation"
    - ingest_spec: "extraction quality metrics and insights"
    - stats: "knowledge base growth after ingestion"
    - query: "integration analysis with existing knowledge"
knowledge_enrichment:
  entity_extraction: true
  relationship_mapping: true
  business_rule_extraction: true
  pattern_identification: true
  quality_validation: true
  integration_analysis: true
usage_examples:
  - "Ingest the requirements document at specs/requirements.md"
  - "Process this text about user authentication flows"
  - "Add the architecture decisions document to knowledge base"
  - "Extract entities from the API specification"
  - "Ingest Event Storming diagram for domain modeling"
  - "Process feature specification for domain intelligence"
  - "Add implementation lessons learned to knowledge base"
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/kb-ingest` in the triggering message **is** either a file path or direct text content to ingest. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that ingestion request, do this:

## Phase 1: Input Analysis and Strategy

1. **Input Type Analysis**:
   - Determine if input is a file path (contains .md, .txt, .docx, .pdf, .drawio, etc.) or direct text
   - Validate file existence and accessibility if path is provided
   - Assess content type, size, and complexity for processing strategy
   - Identify domain context and potential knowledge value
   - Estimate processing requirements and resource needs

2. **MCP Knowledge Base Assessment**:
   - Query current knowledge base: `"existing knowledge structure and statistics"`
   - Get current schema: Understand existing entity types and relationships
   - Get statistics: Assess current knowledge base size and growth patterns
   - Identify relevant domain contexts for integration
   - Plan ingestion approach based on existing knowledge structure

3. **Ingestion Strategy Development**:
   - For file paths: Use `ingest(file_path: "$ARGUMENTS", use_fast_mode: false)` for comprehensive processing
   - For direct text: Use `ingest_spec(text: "$ARGUMENTS", use_fast_mode: false)` for detailed analysis
   - For large documents: Consider strategic chunking with use_fast_mode: true for initial processing
   - For complex specifications: Use detailed processing mode with quality validation
   - Plan for entity, relationship, and pattern extraction

## Phase 2: Content Processing and Ingestion

4. **Content Preprocessing**:
   - Read and parse input content appropriately
   - Clean and normalize text for optimal processing
   - Identify document structure and key sections
   - Extract metadata and context information
   - Prepare content for entity and relationship extraction

5. **MCP Ingestion Execution**:
   - Execute appropriate ingestion method based on input type
   - Monitor ingestion process for progress and issues
   - Track entity extraction and relationship mapping
   - Observe business rule and constraint extraction
   - Monitor pattern and component identification

6. **Real-time Quality Monitoring**:
   - Monitor extraction quality and completeness
   - Track relationship mapping accuracy
   - Validate business rule extraction
   - Ensure pattern identification is meaningful
   - Identify any processing issues or anomalies

## Phase 3: Post-Ingestion Analysis

7. **Knowledge Base Impact Analysis**:
   - Get post-ingestion statistics: `stats()` to measure knowledge growth
   - Query updated schema: Understand new relationships and structures
   - Analyze extraction quality and completeness metrics
   - Verify successful ingestion and integration
   - Identify new knowledge domains and connections

8. **Entity and Relationship Validation**:
   - Validate extracted entities are accurate and well-formed
   - Verify relationships make logical sense
   - Check for consistency with existing knowledge
   - Ensure business rules are properly captured and complete
   - Validate patterns are meaningful and applicable

9. **Integration Quality Assessment**:
   - Analyze how new knowledge integrates with existing domain
   - Identify new connections and relationships
   - Assess impact on existing knowledge structures
   - Validate no conflicts or contradictions introduced
   - Measure overall knowledge base enhancement

## Phase 4: Enhancement and Optimization

10. **Knowledge Base Enhancement**:
    - Identify opportunities for knowledge base improvement
    - Suggest additional related content for ingestion
    - Recommend relationship strengthening and clarification
    - Propose new entity types or relationship categories
    - Outline areas for further knowledge development

11. **Pattern and Insight Extraction**:
    - Extract meaningful patterns from ingested content
    - Identify best practices and lessons learned
    - Discover cross-domain connections and insights
    - Highlight valuable approaches and methodologies
    - Document innovative solutions and approaches

12. **Quality Improvement Recommendations**:
    - Suggest improvements for future ingestion processes
    - Recommend content organization and structuring improvements
    - Propose enhancement to extraction algorithms
    - Outline validation and quality control improvements
    - Document lessons learned for optimal ingestion

## Phase 5: Reporting and Follow-up

13. **Generate Ingestion Report**:
    - Create comprehensive ingestion results report
    - Document entities, relationships, and patterns extracted
    - Provide quality metrics and validation results
    - Include integration analysis and impact assessment
    - Suggest next steps and related activities

14. **Recommend Follow-up Actions**:
    - Suggest related queries to explore new knowledge
    - Recommend additional content for ingestion
    - Propose knowledge base enhancement activities
    - Outline integration with existing workflows
    - Provide guidance for leveraging new knowledge

## Key Ingestion Principles

### Quality-Focused Approach
- **Validation First**: Prioritize quality and accuracy of extracted knowledge
- **Consistency Maintenance**: Ensure new knowledge integrates well with existing knowledge
- **Completeness Focus**: Strive for comprehensive extraction of entities and relationships
- **Context Awareness**: Maintain domain and project context throughout ingestion

### Intelligent Processing
- **Adaptive Strategy**: Adjust processing approach based on content type and complexity
- **Pattern Recognition**: Identify and extract meaningful patterns and approaches
- **Relationship Mapping**: Build comprehensive relationship networks between entities
- **Business Rule Capture**: Extract and formalize business rules and constraints

### Continuous Improvement
- **Learning from Ingestion**: Use ingestion results to improve future processes
- **Feedback Integration**: Incorporate quality feedback into processing algorithms
- **Knowledge Evolution**: Allow knowledge base to evolve and improve with each ingestion
- **Quality Tracking**: Monitor and track quality metrics over time

## Content Type Handling

### Document Files (.md, .txt, .docx, .pdf)
- **Processing**: Full document parsing and analysis
- **Extraction**: Entities, relationships, business rules, patterns
- **Integration**: Structured knowledge integration with context

### Diagram Files (.drawio, .xml)
- **Processing**: Visual element and relationship extraction
- **Extraction**: Domain events, aggregates, processes, flows
- **Integration**: Domain model and Event Storming integration

### Code Files (.js, .py, .java, etc.)
- **Processing**: Code structure and pattern analysis
- **Extraction**: Implementation patterns, architectural decisions
- **Integration**: Technical knowledge and best practices

### Direct Text Input
- **Processing**: Immediate text analysis and extraction
- **Extraction**: Entities, relationships, rules from text
- **Integration**: Contextual knowledge integration

## Success Criteria

### Ingestion Success
- Content is successfully processed and ingested
- Entities, relationships, and patterns are accurately extracted
- Business rules and constraints are properly captured
- Processing completes without errors or data loss
- Knowledge base shows measurable growth and enhancement

### Quality Success
- Extracted knowledge is accurate and meaningful
- Relationships are logical and well-formed
- Business rules are complete and consistent
- Patterns are valuable and applicable
- Integration with existing knowledge is seamless

### Value Success
- New knowledge provides tangible value to the project
- Insights and patterns are actionable and applicable
- Integration enhances existing knowledge base capabilities
- Quality metrics show improvement over time
- Knowledge base becomes more comprehensive and useful

**Use Cases**:
- Add external requirements documents to knowledge base
- Ingest Event Storming diagrams and domain models
- Process feature specifications and clarification results
- Add implementation plans and architectural decisions
- Incorporate meeting notes and stakeholder feedback
- Process legacy documentation for pattern extraction
- Add research findings and competitive analysis
- Integrate lessons learned and best practices

Use absolute paths with the repository root for all file operations to avoid path issues.
---
description: Ingest documents or text directly into the knowledge base for entity extraction and relationship mapping.
scripts:
  sh: scripts/bash/knowledge-ingest.sh --json "{ARGS}"
  ps: scripts/powershell/knowledge-ingest.ps1 -Json "{ARGS}"
mcp_tools:
  - ingest
  - ingest_spec
  - stats
  - schema
usage_examples:
  - "Ingest the requirements document at specs/requirements.md"
  - "Process this text about user authentication flows"
  - "Add the architecture decisions document to knowledge base"
  - "Extract entities from the API specification"
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/kb-ingest` in the triggering message **is** either a file path or direct text content to ingest. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that ingestion request, do this:

1. **Input Analysis**:
   - Determine if input is a file path (contains .md, .txt, .docx, etc.) or direct text
   - Validate file existence if path is provided
   - Assess content type and complexity for processing strategy

2. **MCP Ingestion Strategy**:
   - For file paths: Use `ingest(file_path: "$ARGUMENTS", use_fast_mode: false)`
   - For direct text: Use `ingest_spec(text: "$ARGUMENTS", use_fast_mode: false)`
   - For large documents: Consider chunking with use_fast_mode: true
   - For complex specifications: Use detailed processing mode

3. **Entity and Relationship Extraction**:
   - Monitor ingestion process for entity extraction
   - Track relationship mapping between identified concepts
   - Observe business rule and constraint extraction
   - Note pattern and component identification

4. **Knowledge Base Analysis**:
   - Get post-ingestion statistics to measure knowledge growth
   - Query updated schema to understand new relationships
   - Verify successful ingestion and extraction quality
   - Identify any gaps or areas needing additional clarification

5. **Integration Recommendations**:
   - Suggest how this new knowledge connects to existing domain
   - Identify features or components that might benefit from this knowledge
   - Highlight new entities or relationships that should be considered
   - Recommend related queries to explore connections

6. **Quality Validation**:
   - Validate extracted entities and relationships make sense
   - Check for conflicts with existing knowledge
   - Ensure business rules are properly captured
   - Verify completeness of extraction

**Success Criteria**:
- Content is successfully ingested and processed
- Entities and relationships are accurately extracted
- Business rules and constraints are properly captured
- Knowledge base shows measurable growth
- New knowledge integrates well with existing domain

**Use Cases**:
- Add external requirements documents to knowledge base
- Ingest meeting notes or stakeholder feedback
- Process legacy documentation for pattern extraction
- Add research findings or competitive analysis

Use absolute paths with the repository root for all file operations to avoid path issues.
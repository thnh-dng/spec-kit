# Knowledge Agent MCP Server Usage Guide

This document provides comprehensive guidelines for using the `mcp__knowledge-agent-mcp` server, which provides knowledge base management and query capabilities with Neo4j integration.

## Overview

The `mcp__knowledge-agent-mcp` server enables intelligent knowledge management by:
- Ingesting documents and text into a Neo4j graph database
- Extracting entities and relationships automatically
- Creating vector embeddings for hybrid search
- Providing powerful query capabilities with Retrieval Augmented Generation (RAG)

## Available Functions

### 1. Ingest Document Files
```python
# Standard ingestion
result = mcp__knowledge-agent-mcp__ingest(file_path="/path/to/document.md")

# Fast processing mode (smaller chunks, more workers)
result = mcp__knowledge-agent-mcp__ingest(file_path="/path/to/document.md", use_fast_mode=True)
```

**Parameters**:
- `file_path` (required): Path to the document file to ingest
- `use_fast_mode` (optional, default: False): Use fast processing with smaller chunks and more workers

**Supported File Types**:
- **Text Files**: `.txt`, `.md`, `.docx`, etc.
- **PDF Files**: `.pdf` (extracts text and visual content)
- **Images**: `.png`, `.jpg`, etc. (extracts visual content)
- **Jupyter Notebooks**: `.ipynb` (extracts code, text, and visualizations)

### 2. Ingest Text Directly
```python
# Standard text ingestion
result = mcp__knowledge-agent-mcp__ingest_spec(text="Your text content here")

# Fast processing mode
result = mcp__knowledge-agent-mcp__ingest_spec(text="Your text content here", use_fast_mode=True)
```

**Parameters**:
- `text` (required): Raw text content to ingest into the knowledge graph
- `use_fast_mode` (optional, default: False): Use fast processing with smaller chunks and more workers

### 3. Query Knowledge Base
```python
# Basic query (default: 5 source documents, no sources in response)
result = mcp__knowledge-agent-mcp__query(query="What are the key features of our system?")

# Query with custom parameters
result = mcp__knowledge-agent-mcp__query(
    query="Explain the architecture patterns used",
    limit=10,                    # Retrieve up to 10 source documents
    with_source=True             # Include source documents in response
)
```

**Parameters**:
- `query` (required): Natural language query to search the knowledge base
- `limit` (optional, default: 5): Maximum number of source documents to retrieve (1-20)
- `with_source` (optional, default: False): Include source documents in the response

### 4. View Database Schema
```python
# Get current schema information
schema = mcp__knowledge-agent-mcp__schema()
```

**Returns**:
- Node labels and their properties
- Relationship types and their properties
- Database structure overview

### 5. Get Database Statistics
```python
# Get database statistics
stats = mcp__knowledge-agent-mcp__stats()
```

**Returns**:
- Node counts by type
- Relationship counts by type
- Overall database metrics

### 6. Clear Database
```python
# Clear all data (requires explicit confirmation)
result = mcp__knowledge-agent-mcp__clear(confirm=True)
```

**⚠️ Warning**: This action is irreversible and will delete all nodes, relationships, and indexes.

## Usage Patterns and Workflows

### 1. Building a Project Knowledge Base

#### Step 1: Ingest Project Documentation
```python
# Ingest project requirements
mcp__knowledge-agent-mcp__ingest(file_path="docs/requirements.md")

# Ingest API documentation
mcp__knowledge-agent-mcp__ingest(file_path="docs/api-reference.md")

# Ingest architectural decisions
mcp__knowledge-agent-mcp__ingest(file_path="docs/architecture/decisions/")
```

#### Step 2: Add Code Documentation
```python
# Ingest code comments and documentation
mcp__knowledge-agent-mcp__ingest(file_path="src/README.md")

# Add technical specifications
mcp__knowledge-agent-mcp__ingest_spec(text="""
Our system uses a microservices architecture with the following components:
- API Gateway: Handles request routing and authentication
- User Service: Manages user accounts and profiles
- Order Service: Processes orders and payments
- Notification Service: Handles email and push notifications
""")
```

#### Step 3: Query for Insights
```python
# Find similar patterns
result = mcp__knowledge-agent-mcp__query(
    query="How is authentication implemented across services?",
    with_source=True
)

# Get architectural overview
result = mcp__knowledge-agent-mcp__query(
    query="What are the main components and their relationships?",
    limit=10
)
```

### 2. Feature Development Workflow

#### Before Implementation
```python
# Query for similar existing features
similar_features = mcp__knowledge-agent-mcp__query(
    query="Find features similar to user authentication",
    with_source=True
)

# Understand existing patterns
patterns = mcp__knowledge-agent-mcp__query(
    query="How are database migrations handled in this project?"
)
```

#### During Implementation
```python
# Add implementation notes
mcp__knowledge-agent-mcp__ingest_spec(text="""
New Feature: Two-Factor Authentication
- Implementation uses TOTP algorithm
- Integrates with existing User Service
- Uses QR code generation for setup
- Includes backup code generation
""")
```

#### After Implementation
```python
# Update knowledge base
mcp__knowledge-agent-mcp__ingest(file_path="docs/2fa-implementation.md")

# Verify knowledge graph structure
schema = mcp__knowledge-agent-mcp__schema()
stats = mcp__knowledge-agent-mcp__stats()
```

### 3. Research and Analysis

#### Competitive Analysis
```python
# Ingest competitor documentation
mcp__knowledge-agent-mcp__ingest(file_path="research/competitors/feature-comparison.md")

# Query for unique features
unique_features = mcp__knowledge-agent-mcp__query(
    query="What features do we have that competitors don't?",
    with_source=True
)
```

#### Technical Research
```python
# Add research findings
mcp__knowledge-agent-mcp__ingest_spec(text="""
Research Findings: Database Scalability
- Vertical scaling works well up to 1M users
- Horizontal scaling requires sharding strategy
- Read replicas can handle 10x read traffic
- Connection pooling is critical for performance
""")

# Query for relevant patterns
patterns = mcp__knowledge-agent-mcp__query(
    query="What database scaling patterns are relevant to our use case?"
)
```

## Best Practices

### 1. Knowledge Base Management

#### Start Small and Focused
```python
# Begin with core documentation
core_docs = [
    "docs/requirements.md",
    "docs/architecture/overview.md",
    "docs/api/README.md"
]

for doc in core_docs:
    mcp__knowledge-agent-mcp__ingest(file_path=doc)
```

#### Use Fast Mode for Development
```python
# During development and testing
mcp__knowledge-agent-mcp__ingest(file_path="test-doc.md", use_fast_mode=True)

# For final ingestion, use standard mode
mcp__knowledge-agent-mcp__ingest(file_path="production-doc.md")
```

#### Monitor Knowledge Base Health
```python
# Regular health checks
def check_knowledge_base():
    stats = mcp__knowledge-agent-mcp__stats()
    schema = mcp__knowledge-agent-mcp__schema()

    print(f"Total nodes: {sum(stats['node_counts'].values())}")
    print(f"Total relationships: {sum(stats['relationship_counts'].values())}")
    print(f"Node types: {list(stats['node_counts'].keys())}")
    print(f"Relationship types: {list(stats['relationship_counts'].keys())}")
```

### 2. Query Optimization

#### Craft Effective Queries
```python
# Good: Specific and contextual
good_query = "How is user authentication implemented in the microservices architecture?"

# Bad: Too vague
bad_query = "authentication"

# Good: Include domain context
domain_query = "In our e-commerce system, how are payment failures handled?"

# Bad: Generic
generic_query = "error handling"
```

#### Use Appropriate Limits
```python
# For specific factual queries
result = mcp__knowledge-agent-mcp__query(
    query="What is the timeout for API requests?",
    limit=3
)

# For comprehensive analysis
result = mcp__knowledge-agent-mcp__query(
    query="Analyze the security patterns across all services",
    limit=15
)
```

#### Include Sources When Needed
```python
# For research and verification
research_result = mcp__knowledge-agent-mcp__query(
    query="What are the performance characteristics of our caching strategy?",
    with_source=True
)

# For quick answers
quick_answer = mcp__knowledge-agent-mcp__query(
    query="What port does the API gateway run on?",
    with_source=False
)
```

### 3. Content Ingestion

#### Prepare Documents for Ingestion
```python
# Ensure documents are well-structured
# Use clear headings and subheadings
# Include metadata and context
# Break down large documents into logical sections
```

#### Add Contextual Information
```python
# When ingesting code or technical content
context = """
Project: E-commerce Platform
Technology Stack: Python, FastAPI, PostgreSQL, Redis
Architecture: Microservices
Last Updated: 2024-01-15
"""

mcp__knowledge-agent-mcp__ingest_spec(text=context + "\n\n" + technical_content)
```

#### Version Control Knowledge
```python
# Add version information to ingested content
versioned_content = f"""
Version: 2.1.0
Release Date: 2024-01-15
Changes: Added payment processing, improved user authentication

{content}
"""

mcp__knowledge-agent-mcp__ingest_spec(text=versioned_content)
```

## Integration with Spec Kit

### 1. Slash Command Integration

The knowledge agent MCP integrates with Spec Kit's slash command system:

```bash
# Ingest requirements
/kb-ingest requirements.md

# Query for similar features
/kb-query "Find features similar to payment processing"

# View knowledge base structure
/kb-schema

# Check database statistics
/kb-stats
```

### 2. Spec-Driven Development

#### Enhanced Specification Creation
```bash
# Query knowledge base before creating specs
/kb-query "What are the existing user management patterns?"

# Use insights to create better specifications
/specify "User profile management with social login integration"
```

#### Implementation Planning
```bash
# Query for implementation patterns
/kb-query "How are database migrations typically handled?"

# Use patterns to create implementation plans
/plan "User profile feature implementation"
```

### 3. Cross-Project Knowledge Sharing

#### Reuse Patterns Across Projects
```python
# Query for patterns from other projects
patterns = mcp__knowledge-agent-mcp__query(
    query="How have authentication patterns evolved across our projects?",
    with_source=True
)

# Apply lessons learned
mcp__knowledge-agent-mcp__ingest_spec(text="""
Lessons Learned: Authentication Patterns
- JWT tokens work better than sessions for microservices
- OAuth2 integration requires careful token management
- Password hashing should use Argon2 for new projects
- Multi-factor authentication significantly improves security
""")
```

## Troubleshooting

### 1. Common Issues

#### Empty Query Results
```python
# Check if knowledge base has data
stats = mcp__knowledge-agent-mcp__stats()
if sum(stats['node_counts'].values()) == 0:
    print("Knowledge base is empty. Ingest some documents first.")

# Try broader queries
result = mcp__knowledge-agent-mcp__query(query="authentication")
```

#### Slow Query Performance
```python
# Reduce limit for faster responses
result = mcp__knowledge-agent-mcp__query(
    query="specific question",
    limit=3
)

# Use fast mode for large ingestions
mcp__knowledge-agent-mcp__ingest(file_path="large-doc.pdf", use_fast_mode=True)
```

#### Ingestion Failures
```python
# Check file exists and is readable
import os
if not os.path.exists(file_path):
    print(f"File not found: {file_path}")

# Try with a smaller document first
mcp__knowledge-agent-mcp__ingest(file_path="small-test.md")
```

### 2. Debug Commands

```python
def debug_knowledge_base():
    """Comprehensive debugging of knowledge base"""
    try:
        # Check server availability
        schema = mcp__knowledge-agent-mcp__schema()
        print("✓ Knowledge agent server is available")

        # Get statistics
        stats = mcp__knowledge-agent-mcp__stats()
        print(f"✓ Knowledge base contains {sum(stats['node_counts'].values())} nodes")

        # Test query
        test_result = mcp__knowledge-agent-mcp__query(query="test", limit=1)
        print("✓ Query functionality is working")

        return True

    except Exception as e:
        print(f"✗ Error: {e}")
        return False
```

### 3. Recovery Strategies

#### Rebuilding Knowledge Base
```python
# 1. Export important queries and insights
important_queries = [
    "What are the key architectural patterns?",
    "How is security implemented?",
    "What are the main business workflows?"
]

saved_knowledge = []
for query in important_queries:
    result = mcp__knowledge-agent-mcp__query(query, with_source=True)
    saved_knowledge.append((query, result))

# 2. Clear and rebuild
mcp__knowledge-agent-mcp__clear(confirm=True)

# 3. Re-ingest critical documents
critical_docs = [
    "docs/requirements.md",
    "docs/architecture.md",
    "docs/api-spec.md"
]

for doc in critical_docs:
    mcp__knowledge-agent-mcp__ingest(file_path=doc)

# 4. Restore saved knowledge
for query, _ in saved_knowledge:
    mcp__knowledge-agent-mcp__ingest_spec(text=f"Important Query: {query}")
```

## Advanced Usage

### 1. Custom Knowledge Strategies

#### Domain-Specific Knowledge Graphs
```python
# Create specialized knowledge for different domains
domains = {
    "security": ["docs/security/", "docs/compliance/"],
    "performance": ["docs/performance/", "docs/scaling/"],
    "business": ["docs/requirements/", "docs/business-logic/"]
}

for domain, paths in domains.items():
    for path in paths:
        mcp__knowledge-agent-mcp__ingest(file_path=path)
```

#### Relationship Mapping
```python
# Explicitly define relationships
relationship_mappings = """
User -> Profile -> Preferences
Order -> Payment -> Receipt
Product -> Inventory -> Supplier
API -> Service -> Database
"""

mcp__knowledge-agent-mcp__ingest_spec(text=relationship_mappings)
```

### 2. Performance Optimization

#### Batch Processing
```python
def batch_ingest(file_list, batch_size=5):
    """Ingest files in batches to avoid overwhelming the system"""
    for i in range(0, len(file_list), batch_size):
        batch = file_list[i:i + batch_size]
        for file_path in batch:
            try:
                mcp__knowledge-agent-mcp__ingest(file_path=file_path)
                print(f"✓ Ingested: {file_path}")
            except Exception as e:
                print(f"✗ Failed: {file_path} - {e}")

        # Small delay between batches
        time.sleep(1)
```

#### Query Caching
```python
# Cache frequent queries
query_cache = {}

def cached_query(query, limit=5, with_source=False):
    cache_key = f"{query}_{limit}_{with_source}"

    if cache_key not in query_cache:
        query_cache[cache_key] = mcp__knowledge-agent-mcp__query(
            query=query,
            limit=limit,
            with_source=with_source
        )

    return query_cache[cache_key]
```

### 3. Integration with External Systems

#### Automated Documentation Updates
```python
# Watch for documentation changes and update knowledge base
import watchdog.observers
import watchdog.events

class DocUpdateHandler(watchdog.events.FileSystemEventHandler):
    def on_modified(self, event):
        if event.src_path.endswith('.md'):
            print(f"Document updated: {event.src_path}")
            mcp__knowledge-agent-mcp__ingest(file_path=event.src_path)
```

#### API Integration
```python
# Fetch external knowledge and ingest it
import requests

def ingest_external_api_docs(api_url):
    response = requests.get(api_url)
    if response.status_code == 200:
        mcp__knowledge-agent-mcp__ingest_spec(
            text=f"API Documentation from {api_url}:\n\n{response.text}"
        )
```

This comprehensive guide provides everything needed to effectively use the `mcp__knowledge-agent-mcp` server for intelligent knowledge management in Spec Kit projects.
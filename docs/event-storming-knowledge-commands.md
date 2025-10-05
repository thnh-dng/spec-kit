# Event Storming and Knowledge Base Commands

This document provides comprehensive usage documentation for the enhanced Event Storming and knowledge base management commands in Spec Kit.

## Overview

Spec Kit now includes a comprehensive set of commands for Event Storming and knowledge base management that integrate seamlessly with the existing Spec-Driven Development workflow. These commands enable domain-driven design with intelligent knowledge base utilization.

## Available Commands

### Core Event Storming Commands

#### `/review-spec-domain` - Combined Analysis and Domain Event Storming

**Purpose**: Analyze complex requirements and create high-level domain Event Storming in a unified workflow.

**Usage**:
```bash
/review-spec-domain "complex requirements description or file path"
```

**Key Features**:
- Combines requirements analysis with domain Event Storming
- Creates feature breakdown with domain context
- Generates high-level domain model with bounded contexts
- Integrates with knowledge base for intelligent analysis

**Example**:
```bash
/review-spec-domain "Build an e-commerce platform with user management, order processing, payment integration, and inventory management"
```

**Output**: Creates timestamped analysis directory with comprehensive report and Event Storming diagram.

#### `/event-storm-feature` - Feature-Level Event Storming

**Purpose**: Perform detailed Event Storming for specific features after clarification.

**Usage**:
```bash
# From within a feature directory
/event-storm-feature

# With specific context
/event-storm-feature "payment processing feature context"
```

**Key Features**:
- Works with concrete requirements from clarification step
- Creates feature-specific domain models
- Provides implementation guidance
- Generates big model update recommendations

**Best Used**: After `/clarify` when requirements are concrete and feature scope is well-defined.

#### `/event-storm-analyze` - Cross-Artifact Analysis

**Purpose**: Analyze consistency across all Event Storming artifacts and provide improvement recommendations.

**Usage**:
```bash
/event-storm-analyze

# With specific focus
/event-storm-analyze "consistency validation"
/event-storm-analyze "gap analysis"
```

**Key Features**:
- Validates consistency between high-level and feature-level models
- Identifies gaps, conflicts, and areas for improvement
- Discovers cross-feature patterns and best practices
- Provides actionable recommendations for enhancement

#### `/event-storm-update` - Big Model Synchronization

**Purpose**: Update the high-level domain model with insights from feature-level Event Storming.

**Usage**:
```bash
/event-storm-update

# For specific domain areas
/event-storm-update "payment processing domain"
/event-storm-update "user management context"
```

**Key Features**:
- Synchronizes feature insights with high-level domain model
- Ensures consistency between detailed and high-level models
- Maintains domain model integrity and evolution
- Provides comprehensive update reporting

### Knowledge Base Management Commands

#### `/kb-query` - Knowledge Base Query

**Purpose**: Query the knowledge base for domain intelligence, patterns, and insights.

**Usage**:
```bash
/kb-query "similar user authentication patterns"
/kb-query "entities related to order processing"
/kb-query "business rules for payment validation"
/kb-query "implementation patterns for real-time updates"
```

**Key Features**:
- Intelligent search with multi-strategy approach
- Context-aware results and actionable insights
- Query optimization and learning capabilities
- Pattern recognition and relationship mapping

**Query Types**:
- **Factual**: Retrieve specific facts and definitions
- **Relational**: Find relationships between concepts
- **Pattern-Based**: Identify recurring approaches and best practices
- **Analytical**: Gain strategic insights and analysis

#### `/kb-ingest` - Knowledge Base Ingestion

**Purpose**: Ingest documents, files, or text directly into the knowledge base.

**Usage**:
```bash
# Ingest files
/kb-ingest "specs/requirements.md"
/kb-ingest "features/payment-processing/event-storming-20241205-143000/feature-event-storming.drawio"

# Ingest direct text
/kb-ingest "User authentication flows with OAuth 2.0 and JWT tokens"
```

**Key Features**:
- Comprehensive content processing and quality validation
- Multi-format support (documents, diagrams, code, text)
- Integration analysis and relationship mapping
- Quality improvement recommendations

**Supported Formats**:
- Documents: `.md`, `.txt`, `.docx`, `.pdf`
- Diagrams: `.drawio`, `.xml`
- Code: `.js`, `.py`, `.java`, etc.
- Direct text input

## Workflow Integration

### Recommended Workflow

```
1. /constitution → Establish project principles
2. /review-spec-domain → Combined analysis and domain Event Storming
3. /specify → Feature specification (repeat for each feature)
4. /clarify → Resolve ambiguities (repeat for each feature)
5. /event-storm-feature → Feature-level Event Storming (repeat for each feature)
6. /plan → Implementation planning (repeat for each feature)
7. /event-storm-update → Synchronize big model with feature insights
8. /tasks → Task generation (repeat for each feature)
9. /implement → Implementation (repeat for each feature)
10. /event-storm-analyze → Cross-artifact analysis and validation
```

### Knowledge Base Integration Points

**Before Each Step**:
```bash
/kb-query "domain context for [feature]"
/kb-query "similar features across projects"
/kb-query "implementation patterns for [technology]"
```

**After Each Step**:
```bash
/kb-ingest "analysis-results.md"
/kb-ingest "event-storming-diagram.drawio"
/kb-ingest "feature-specification.md"
```

### Periodic Maintenance

**Weekly/Monthly**:
```bash
/event-storm-analyze "comprehensive quality assessment"
/event-storm-update "domain model synchronization"
/kb-query "knowledge base quality metrics"
```

## Advanced Usage

### Cross-Platform Support

All commands support both bash and PowerShell environments:

**Bash (Linux/macOS)**:
```bash
/review-spec-domain "requirements description"
/event-storm-feature
/kb-query "domain patterns"
```

**PowerShell (Windows)**:
```powershell
/review-spec-domain "requirements description"
/event-storm-feature
/kb-query "domain patterns"
```

### JSON Output Mode

All commands support JSON output for programmatic usage:

```bash
/review-spec-domain --json "requirements" > analysis.json
/event-storm-feature --json > feature-analysis.json
/kb-query --json "patterns" > results.json
```

### Batch Processing

**Multiple Feature Analysis**:
```bash
# Process multiple features
for feature in user-management order-processing inventory; do
    cd "features/$feature"
    /event-storm-feature
    cd ../..
done
```

**Knowledge Base Bulk Operations**:
```bash
# Ingest multiple documents
for doc in specs/*.md; do
    /kb-ingest "$doc"
done
```

## Best Practices

### Event Storming Best Practices

1. **Timing is Critical**: Perform feature-level Event Storming after clarification when requirements are concrete
2. **Domain-First Focus**: Keep Event Storming focused on business domain rather than technical implementation
3. **Consistency Maintenance**: Regularly synchronize feature insights with the high-level domain model
4. **Quality Validation**: Use cross-artifact analysis to ensure consistency and quality

### Knowledge Base Best Practices

1. **Progressive Enrichment**: Add knowledge at strategic points in the workflow
2. **Query Before Ingest**: Always query existing knowledge before adding new content
3. **Quality Focus**: Prioritize quality and accuracy over quantity of knowledge
4. **Regular Maintenance**: Perform periodic analysis and cleanup of knowledge base

### Integration Best Practices

1. **Context Awareness**: Always consider project and domain context in all operations
2. **Continuous Learning**: Use insights from each step to improve subsequent steps
3. **Pattern Recognition**: Identify and leverage cross-feature patterns and approaches
4. **Documentation**: Maintain comprehensive documentation of all Event Storming and knowledge activities

## Troubleshooting

### Common Issues

**Command Not Found**:
- Ensure Spec Kit is properly installed
- Check that you're in a Spec Kit project directory
- Verify the command template exists in `templates/commands/`

**Knowledge Base Issues**:
- Verify MCP server is running and accessible
- Check knowledge base connectivity and permissions
- Ensure proper authentication for external knowledge sources

**Event Storming Issues**:
- Ensure Event Storming agent is properly configured
- Check diagram file permissions and accessibility
- Verify domain model consistency across artifacts

### Getting Help

**Command Help**:
```bash
/review-spec-domain --help
/event-storm-feature --help
/kb-query --help
/kb-ingest --help
```

**Debug Mode**:
```bash
# Commands support debug output for troubleshooting
/review-spec-domain --json "requirements"  # Detailed JSON output
```

## Examples

### Complete Project Example

**E-Commerce Platform Setup**:
```bash
# 1. Project initialization
/constitution

# 2. Combined analysis and domain Event Storming
/review-spec-domain "Build e-commerce platform with user management, order processing, payment integration, inventory management, and customer support"

# 3. Feature processing loop
for feature in user-authentication order-management payment-processing inventory-management; do
    # Feature specification
    /specify "$feature - core functionality and business logic"

    # Feature clarification
    /clarify

    # Feature-level Event Storming
    /event-storm-feature

    # Implementation planning
    /plan "implementation for $feature"

    # Task generation and implementation
    /tasks
    /implement
done

# 4. Big model synchronization
/event-storm-update "e-commerce domain model"

# 5. Cross-artifact analysis
/event-storm-analyze "comprehensive validation"

# 6. Knowledge base queries for insights
/kb-query "e-commerce domain patterns"
/kb-query "payment processing best practices"
/kb-query "user authentication security patterns"
```

### Knowledge Base Management Example

**Building Domain Intelligence**:
```bash
# Ingest existing documentation
/kb-ingest "docs/legacy-system-architecture.md"
/kb-ingest "docs/business-requirements.pdf"
/kb-ingest "specs/api-contracts.yml"

# Query for insights during development
/kb-query "integration patterns for legacy systems"
/kb-query "business rules for order processing"
/kb-query "security considerations for user management"

# Ingest Event Storming results
/kb-ingest "specs/complex-requirements-analysis-20241205-140000/event-storming/domain-event-storming.drawio"
/kb-ingest "features/user-management/event-storming-20241205-150000/feature-event-storming.md"

# Analyze knowledge base growth
/kb-query "knowledge base quality metrics"
/kb-query "cross-domain patterns and relationships"
```

## Success Metrics

### Event Storming Metrics
- **Model Consistency**: >90% consistency between high-level and feature-level models
- **Feature Coverage**: 100% of features have detailed Event Storming models
- **Quality Scores**: >80% on all quality assessment metrics
- **Integration Success**: >95% successful integration of feature insights

### Knowledge Base Metrics
- **Query Effectiveness**: >85% relevance and actionability of query results
- **Ingestion Quality**: >90% accuracy of extracted entities and relationships
- **Knowledge Growth**: Measurable growth in domain intelligence over time
- **Pattern Discovery**: Regular identification of cross-feature patterns and best practices

### Overall Workflow Metrics
- **Development Efficiency**: Measurable improvement in development velocity
- **Quality Improvement**: Reduction in defects and rework
- **Knowledge Utilization**: Effective use of accumulated domain intelligence
- **Stakeholder Satisfaction**: Improved understanding and communication

## Conclusion

The Event Storming and knowledge base commands provide a comprehensive solution for integrating domain-driven design with intelligent knowledge management into the Spec Kit workflow. By following the recommended practices and workflows, teams can build high-quality software with better domain understanding and continuous improvement.

For additional information, see:
- [Refined Spec Kit Workflow](refined-spec-kit-workflow.md)
- [Knowledge Base MCP Guide](knowledge-agent-mcp-guide.md)
- [Event Storming Agent Guide](event-storming-agent-guide.md)
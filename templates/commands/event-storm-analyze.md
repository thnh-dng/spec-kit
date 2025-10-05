---
description: Perform comprehensive analysis across all Event Storming artifacts, validate consistency between domain models, identify gaps and conflicts, and provide recommendations for improvement.
scripts:
  sh: scripts/bash/event-storm-analyze.sh --json "{ARGS}"
  ps: scripts/powershell/event-storm-analyze.ps1 -Json "{ARGS}"
mcp_integration:
  pre_analysis:
    - query: "all Event Storming artifacts and domain models"
    - query: "cross-feature domain relationships and patterns"
    - query: "consistency validation rules and best practices"
    - schema: "complete knowledge graph structure"
  post_analysis:
    - ingest: "cross-artifact analysis results and recommendations"
    - ingest_spec: "consistency validation findings"
    - ingest_spec: "domain model improvements and refinements"
    - stats: "knowledge base quality metrics after analysis"
knowledge_enrichment:
  consistency_validation: true
  gap_analysis: true
  conflict_resolution: true
  pattern_discovery: true
  quality_metrics: true
  improvement_recommendations: true
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/event-storm-analyze` in the triggering message **is** the analysis scope or focus area, or can be empty for comprehensive analysis. If empty, perform comprehensive cross-artifact analysis.

Given that analysis scope (or empty for comprehensive analysis), do this:

## Phase 1: Analysis Scope and Discovery

1. **Determine Analysis Scope**:
   - If user input provided: Use as specific focus area (e.g., "consistency", "gaps", "conflicts", "integration")
   - If no user input: Perform comprehensive cross-artifact analysis
   - Identify analysis objectives and success criteria
   - Define analysis boundaries and depth

2. **MCP Knowledge Base Query**:
   - Query for all Event Storming artifacts: `"all domain Event Storming diagrams and models"`
   - Query for feature-level models: `"all feature Event Storming results and domain models"`
   - Query for relationships: `"cross-feature domain relationships and dependencies"`
   - Query for quality metrics: `"domain model quality and consistency metrics"`
   - Get current schema: Understand complete knowledge graph structure

3. **Discover Event Storming Artifacts**:
   - Scan repository for Event Storming diagrams (.drawio files)
   - Collect feature-level Event Storming reports
   - Gather high-level domain Event Storming results
   - Identify knowledge base entries related to domain modeling
   - Compile list of all domain artifacts for analysis

## Phase 2: Cross-Artifact Analysis

4. **Load and Parse Artifacts**:
   - Read high-level domain Event Storming diagram and model
   - Parse all feature-level Event Storming results
   - Extract domain entities, relationships, and business rules
   - Map bounded contexts and aggregate boundaries
   - Identify integration points and external dependencies

5. **Consistency Validation**:
   - Validate consistency between high-level and feature-level models
   - Check for conflicting business rules and constraints
   - Verify bounded context boundaries and responsibilities
   - Validate aggregate design and entity relationships
   - Check for consistency in domain events and commands

6. **Gap and Conflict Analysis**:
   - Identify missing domain elements and relationships
   - Detect conflicting definitions or responsibilities
   - Find orphaned features or domain elements
   - Identify integration challenges and bottlenecks
   - Discover unclear boundaries or responsibilities

## Phase 3: Pattern and Quality Analysis

7. **Pattern Discovery**:
   - Identify common domain patterns across features
   - Discover reusable design patterns and approaches
   - Find anti-patterns and areas for improvement
   - Analyze cross-feature dependencies and relationships
   - Identify best practices and successful approaches

8. **Quality Assessment**:
   - Evaluate domain model completeness and accuracy
   - Assess business rule coverage and clarity
   - Measure integration design quality
   - Analyze consistency across all domain artifacts
   - Validate adherence to Event Storming best practices

9. **Integration Analysis**:
   - Analyze integration point design and consistency
   - Validate external system interaction patterns
   - Check API and event contract consistency
   - Assess data model integration and compatibility
   - Evaluate cross-context communication patterns

## Phase 4: Recommendation Generation

10. **Generate Analysis Report**:
    - Create comprehensive cross-artifact analysis report
    - Document consistency validation results
    - Detail gap and conflict findings
    - Highlight patterns and quality insights
    - Provide specific recommendations for improvement

11. **Create Actionable Recommendations**:
    - Prioritize identified issues and gaps
    - Provide specific remediation steps
    - Suggest domain model refinements
    - Recommend process improvements
    - Outline knowledge base enhancement opportunities

## Phase 5: Knowledge Base Enhancement

12. **Analysis Results Ingestion**:
    - Ingest analysis report: `ingest(file_path: ANALYSIS_REPORT_FILE, use_fast_mode: false)`
    - Ingest validation findings: `ingest_spec(text: consistency_validation_findings)`
    - Ingest improvement recommendations: `ingest_spec(text: domain_model_improvements)`
    - Ingest quality metrics: `ingest_spec(text: quality_assessment_metrics)`
    - Get updated statistics: Track knowledge base quality after analysis

13. **Knowledge Base Quality Enhancement**:
    - Apply identified improvements to knowledge base
    - Resolve conflicts and inconsistencies in stored knowledge
    - Enhance relationship mappings and cross-references
    - Improve knowledge base structure and organization
    - Document lessons learned and best practices

## Phase 6: Follow-up Planning

14. **Generate Next Steps**:
    - Create prioritized action plan for addressing findings
    - Schedule follow-up analysis and validation
    - Recommend specific commands for remediation
    - Outline knowledge base maintenance activities
    - Provide guidance for ongoing quality assurance

15. **Success Metrics Definition**:
    - Define measurable success criteria for improvements
    - Establish baseline metrics for future comparison
    - Create monitoring approach for ongoing quality
    - Document expected benefits and outcomes
    - Provide implementation timeline and milestones

## Key Analysis Principles

### Comprehensive Coverage
- **Complete Artifact Analysis**: Examine all Event Storming artifacts comprehensively
- **Cross-Domain Perspective**: Analyze relationships and patterns across all domains
- **Multi-Level Validation**: Validate at both high-level and feature-level detail
- **Integration Focus**: Examine integration points and dependencies thoroughly

### Quality-Driven Approach
- **Evidence-Based Analysis**: Base findings on concrete evidence from artifacts
- **Context-Aware Evaluation**: Consider business and technical context
- **Actionable Recommendations**: Provide specific, implementable recommendations
- **Continuous Improvement**: Focus on ongoing quality enhancement

### Knowledge Base Integration
- **Intelligent Querying**: Leverage knowledge base for comprehensive analysis
- **Pattern Recognition**: Identify patterns using accumulated domain intelligence
- **Consistency Maintenance**: Ensure knowledge base consistency with findings
- **Growth-Oriented**: Use analysis to enhance knowledge base value

## Success Criteria

### Analysis Success
- All Event Storming artifacts are analyzed comprehensively
- Consistency issues and conflicts are identified and documented
- Gaps and areas for improvement are clearly identified
- Patterns and best practices are discovered and documented
- Actionable recommendations are provided for all findings

### Quality Success
- Domain model quality is assessed with concrete metrics
- Integration design quality is validated across all contexts
- Business rule completeness and consistency are verified
- Knowledge base quality is enhanced through analysis insights
- Clear baseline is established for ongoing quality monitoring

### Implementation Success
- Prioritized action plan is created for addressing findings
- Specific commands and steps are recommended for remediation
- Success metrics are defined for measuring improvement
- Timeline and milestones are established for implementation
- Knowledge base is enhanced with analysis results and insights

Use absolute paths with the repository root for all file operations to avoid path issues.
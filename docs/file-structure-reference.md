# Spec Kit File Structure Reference

This document provides a comprehensive reference to the Spec Kit project structure, focusing on the enhanced Event Storming and knowledge base functionality.

## **Project Structure Overview**

```
spec-kit/
├── src/specify_cli/              # Main CLI application code
├── templates/                     # Templates and specifications
│   ├── commands/                 # Command templates (15 total)
│   ├── agent-file-template.md    # Agent configuration template
│   ├── plan-template.md          # Implementation planning template
│   ├── spec-template.md          # Feature specification template
│   └── tasks-template.md         # Task generation template
├── scripts/                      # Implementation scripts
│   ├── bash/                     # Bash scripts (Linux/macOS)
│   └── powershell/               # PowerShell scripts (Windows)
├── docs/                         # Documentation
├── .github/workflows/            # CI/CD workflows
├── memory/                       # Project constitution and principles
├── specs/                        # Generated specification outputs
├── .claude/                      # Claude-specific configurations
└── .specify/                     # Local cache and templates
```

## **Command Templates (`templates/commands/`)**

### **Enhanced Commands (New)**
| Template | Bash Script | PowerShell Script | Description |
|----------|-------------|------------------|-------------|
| `event-storm-analyze.md` | ✅ | ✅ | Cross-artifact analysis and validation |
| `event-storm-feature.md` | ✅ | ✅ | Feature-level Event Storming |
| `event-storm-update.md` | ✅ | ✅ | Big model synchronization |
| `kb-ingest.md` | ✅ | ✅ | Knowledge base ingestion |
| `kb-query.md` | ✅ | ✅ | Knowledge base querying |
| `review-spec-domain.md` | ✅ | ✅ | Combined analysis + domain Event Storming |

### **Existing Commands (Unchanged)**
| Template | Bash Script | PowerShell Script | Status |
|----------|-------------|------------------|---------|
| `analyze.md` | ❌ | ❌ | Template only |
| `clarify.md` | ❌ | ❌ | Template only |
| `constitution.md` | ❌ | ❌ | Template only |
| `implement.md` | ❌ | ❌ | Template only |
| `kb-schema.md` | ❌ | ❌ | Template only |
| `plan.md` | ❌ | ❌ | Template only |
| `review-spec.md` | ✅ | ✅ | Complete |
| `specify.md` | ❌ | ❌ | Template only |
| `tasks.md` | ❌ | ❌ | Template only |

## **Implementation Scripts**

### **Bash Scripts (`scripts/bash/`)**
```bash
# New Enhanced Scripts
event-storm-analyze.sh      # Cross-artifact analysis
event-storm-feature.sh      # Feature-level Event Storming
event-storm-update.sh       # Big model synchronization
kb-ingest.sh                # Knowledge base ingestion
kb-query.sh                 # Knowledge base querying
review-spec-domain.sh       # Combined analysis + Event Storming

# Existing Scripts
check-prerequisites.sh      # Environment validation
common.sh                   # Shared utilities
create-new-feature.sh       # Feature creation
knowledge-schema.sh         # Schema management (legacy)
review-spec.sh              # Requirements analysis
setup-plan.sh               # Project setup
update-agent-context.sh     # Agent configuration
```

### **PowerShell Scripts (`scripts/powershell/`)**
```powershell
# New Enhanced Scripts
event-storm-analyze.ps1     # Cross-artifact analysis
event-storm-feature.ps1     # Feature-level Event Storming
event-storm-update.ps1      # Big model synchronization
kb-ingest.ps1               # Knowledge base ingestion
kb-query.ps1                # Knowledge base querying
review-spec-domain.ps1      # Combined analysis + Event Storming

# Existing Scripts
check-prerequisites.ps1     # Environment validation
common.ps1                  # Shared utilities
create-new-feature.ps1      # Feature creation
knowledge-schema.ps1        # Schema management (legacy)
review-spec.ps1             # Requirements analysis
setup-plan.ps1              # Project setup
update-agent-context.ps1   # Agent configuration
```

## **Key Documentation Files**

### **Enhanced Documentation (New)**
- `docs/event-storming-knowledge-commands.md` - Usage documentation
- `docs/installation-setup-guide.md` - Setup instructions
- `docs/event-storming-agent-guide.md` - Agent configuration
- `docs/knowledge-agent-mcp-guide.md` - MCP integration

### **Existing Documentation**
- `docs/event-storming-integration-guide.md` - Integration patterns
- `docs/feature-level-event-storming-guide.md` - Feature-level guidance
- `docs/event-storming-update-strategy.md` - Update strategies
- `docs/knowledge-base-maintenance-guide.md` - Maintenance procedures
- `docs/knowledge-driven-spec-workflow.md` - Workflow documentation

## **Configuration Files**

### **Agent Configuration (`.claude/`)**
```
.claude/
├── agents/
│   └── event-storming-agent.md    # Event Storming agent config
└── settings.local.json             # Claude settings
```

### **Local Cache (`.specify/`)**
```
.specify/
└── templates/
    └── review-spec-domain-template.md  # Local template cache
```

## **Naming Conventions**

### **Files**
- **Templates**: `kebab-case.md` (e.g., `event-storm-analyze.md`)
- **Scripts**: `kebab-case.{sh,ps1}` (e.g., `event-storm-analyze.sh`)
- **Documentation**: `kebab-case.md` (e.g., `event-storming-guide.md`)

### **Directories**
- **Lowercase with hyphens**: `docs/`, `scripts/bash/`
- **Platform-specific**: `bash/`, `powershell/`
- **Functional grouping**: `commands/`, `templates/`

## **File Standards**

### **Template Standards**
- **YAML Frontmatter**: All command templates include metadata
- **Script References**: Templates reference corresponding implementation scripts
- **MCP Integration**: Enhanced templates include MCP tool integration points
- **Consistent Structure**: Standard sections across all templates

### **Script Standards**
- **Cross-Platform**: Every bash script has a PowerShell equivalent
- **JSON Output**: All new scripts support `--json` flag
- **Error Handling**: Consistent error handling and exit codes
- **Directory Creation**: Standardized directory structure creation
- **Permissions**: All scripts have executable permissions

### **Documentation Standards**
- **Comprehensive Coverage**: Complex features have dedicated guides
- **Usage Examples**: All commands include practical examples
- **Integration Guides**: Cross-feature integration documentation
- **Installation Instructions**: Complete setup and configuration guides

## **Generated Output Structure**

### **Specifications Directory (`specs/`)**
```
specs/
├── knowledge-queries/           # Knowledge base query results
│   └── [query-name]-[timestamp]/
│       ├── query-results.md
│       └── knowledge/
├── knowledge-ingestion/         # Knowledge base ingestion reports
│   └── [ingestion-name]-[timestamp]/
│       ├── ingestion-report.md
│       ├── knowledge/
│       ├── extraction/
│       └── validation/
├── complex-requirements-analysis-[timestamp]/  # Review-spec-domain output
│   ├── analysis-report.md
│   ├── event-storming/
│   │   └── domain-event-storming.drawio
│   └── knowledge/
├── features/
│   └── [feature-name]/
│       └── event-storming-[timestamp]/
│           ├── feature-event-storming.drawio
│           └── feature-event-storming.md
└── event-storming-analysis-[timestamp]/  # Cross-artifact analysis
    ├── analysis-report.md
    └── recommendations/
```

## **Integration Points**

### **MCP Server Integration**
- **Knowledge Agent MCP**: Connected through template tool references
- **Neo4j Backend**: Configuration through environment variables
- **Query/Ingest Tools**: Integrated into command workflows

### **AI Agent Integration**
- **Claude Code**: Primary target agent
- **Event Storming Agent**: Specialized for domain modeling
- **Agent Context**: Updated through `update-agent-context` scripts

### **Git Integration**
- **Branch Awareness**: Scripts track current branch context
- **Repository Root Detection**: Consistent across all scripts
- **Version Control**: Generated specs are designed for VCS tracking

## **Quality Assurance**

### **File Validation**
- **Template-Script Consistency**: All new commands have complete pairs
- **Cross-Platform Support**: Bash and PowerShell equivalence
- **Naming Convention Compliance**: Consistent naming throughout
- **Permission Management**: Executable scripts properly set

### **Structure Validation**
- **Directory Organization**: Logical grouping and separation
- **Dependency Management**: Clear script and template relationships
- **Configuration Isolation**: Proper config file placement
- **Output Standardization**: Consistent generated directory structure

## **Maintenance Notes**

### **Adding New Commands**
1. Create template in `templates/commands/` following naming conventions
2. Create corresponding bash script in `scripts/bash/`
3. Create corresponding PowerShell script in `scripts/powershell/`
4. Update documentation and guides
5. Test cross-platform compatibility

### **Modifying Existing Commands**
1. Update template content and metadata
2. Update corresponding implementation scripts
3. Update documentation and examples
4. Test all affected workflows
5. Verify cross-platform compatibility

### **Cleanup Guidelines**
1. Remove unused files and duplicates
2. Update documentation when removing features
3. Maintain backward compatibility where possible
4. Document breaking changes clearly

---

**This structure ensures consistency, maintainability, and cross-platform compatibility for all Spec Kit functionality.**
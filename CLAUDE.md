# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Spec Kit is a Spec-Driven Development (SDD) toolkit that flips traditional software development on its head. Instead of code being king, specifications become executable and directly generate working implementations. The project provides a CLI tool (`specify`) that bootstraps projects for structured, specification-driven development with integrated Knowledge Base MCP and Event Storming capabilities.

## Core Architecture

### CLI Tool Structure
- **Entry Point**: `src/specify_cli/__init__.py` - Main CLI application using Typer (1161 lines)
- **Dependencies**: typer (CLI framework), rich (terminal formatting), httpx (HTTP requests), platformdirs (config paths), readchar (keyboard input), truststore (SSL)
- **Installation**: Can be installed via `uv tool install` or run directly with `uvx`
- **Key Classes**:
  - `StepTracker` - Hierarchical progress tracking with live UI updates (lines 99-183)
  - `BannerGroup` - Custom Typer group showing ASCII art banner
  - `Console` - Rich terminal interface for all output

### Template Processing Pipeline
The template system follows a sophisticated pipeline:
1. **Download**: Fetch from GitHub releases (`spec-kit-template-{agent}-{script_type}.zip`)
2. **Path Mapping**: Rewrite paths from `/memory/`, `/scripts/`, `/templates/` to `.specify/` subdirectories
3. **Flattening**: Handle GitHub-style nested ZIP structures
4. **Command Generation**: Convert markdown templates to agent-specific commands
5. **Agent Integration**: Generate agent-specific configuration files

### MCP Integration Architecture
Modern templates include Model Context Protocol (MCP) integration:
- **Knowledge Base Queries**: Domain intelligence retrieval
- **Entity Extraction**: Automatic entity and relationship identification
- **Requirement Enrichment**: Missing requirement detection
- **Pattern Matching**: Similar feature analysis

### Key Components

1. **Template System**: Downloads and extracts project templates from GitHub releases
2. **AI Agent Integration**: Supports multiple AI coding assistants (Claude, Gemini, Copilot, Cursor, etc.)
3. **Multi-Platform Support**: Works on Linux, macOS, and Windows (with PowerShell scripts)
4. **Git Integration**: Automatic repository initialization and branch management

### Supported AI Agents
- Claude Code (`claude`)
- GitHub Copilot (`copilot`)
- Gemini CLI (`gemini`)
- Cursor (`cursor`)
- Qwen Code (`qwen`)
- opencode (`opencode`)
- Codex CLI (`codex`)
- Windsurf (`windsurf`)
- Kilo Code (`kilocode`)
- Auggie CLI (`auggie`)
- Roo Code (`roo`)
- Amazon Q Developer CLI (`q`)

## Development Commands

### Building and Testing
```bash
# Install dependencies
uv sync

# Run the CLI locally
python -m src.specify_cli --help
# OR using the module directly
python -m src.specify_cli init demo-project --ai claude --ignore-agent-tools

# Test installation
uv pip install -e .
specify --help

# Build package for testing
uv build

# Publish to PyPI (requires permissions)
uv publish
```

### Local Development Workflow
```bash
# Fastest feedback - run directly from source
python -m src.specify_cli --help

# Editable install for development
uv pip install -e .
specify init my-project --ai copilot --ignore-agent-tools

# Test with uvx from local repo
uvx --from . specify init test-project --ai claude --ignore-agent-tools

# Test specific branch
uvx --from git+https://github.com/thnh-dng/spec-kit.git@branch-name specify init test-project
```

### Common Development Tasks
```bash
# Initialize a new project (basic)
specify init my-project

# Initialize with specific AI assistant
specify init my-project --ai claude

# Initialize in current directory
specify init . --ai copilot

# Skip agent tool checks
specify init my-project --ignore-agent-tools

# Initialize without git
specify init my-project --no-git

# Run in debug mode
specify init my-project --debug
```

### Key CLI Options
- `--ai <agent>` - Select AI assistant (claude, copilot, gemini, cursor, qwen, opencode, codex, windsurf, kilocode, auggie, roo, q)
- `--script <type>` - Override script type detection (sh, ps)
- `--ignore-agent-tools` - Skip agent tool availability checks
- `--no-git` - Skip git repository initialization
- `--skip-tls` - Disable SSL/TLS verification
- `--debug` - Enable debug mode with detailed error output

## Project Templates

### Template Structure
Templates are stored as GitHub releases and include:
- Feature specification templates (`spec-template.md`)
- Implementation plan templates (`plan-template.md`)
- Task generation templates (`tasks-template.md`)
- AI agent-specific configuration files
- Build scripts for different platforms (bash/PowerShell)

### Template Processing
1. Downloads latest release from GitHub API
2. Extracts to target directory (handles nested structures)
3. Sets executable permissions on scripts (POSIX only)
4. Initializes git repository (unless skipped)
5. Configures AI agent-specific settings

## Enhanced Workflow with Knowledge Base and Event Storming

### Key Innovation: Two-Tier Event Storming Approach
Spec Kit implements a revolutionary two-tier Event Storming strategy that optimizes domain modeling:

1. **Combined Analysis & Domain Event Storming** (`/review-spec-domain`) - High-level domain modeling integrated with requirements analysis
2. **Feature-Level Event Storming** (`/event-storm-feature`) - Detailed modeling after requirements clarification

### Optimal Event Storming Timing
Event Storming is performed **after the clarify step** when:
- Requirements are concrete and specific
- Ambiguities have been resolved
- Feature scope is well-defined
- Implementation context is clear
- Stakeholder alignment has been achieved

### Complete Workflow

#### **Project Foundation**
```bash
/constitution                    # Establish project governance
/review-spec-domain "complex requirements"  # Combined analysis + domain Event Storming
```

#### **Feature-Level Processing (Repeated for each feature)**
```bash
/specify "feature description"   # Create feature specification
/clarify                         # Resolve ambiguities, make requirements concrete
/event-storm-feature             # Feature-level Event Storming (OPTIMAL TIMING)
/plan                            # Implementation planning
/tasks                           # Generate executable tasks
/implement                       # Execute implementation
```

### Knowledge Base Integration Strategy

#### **Knowledge Utilization Pattern**
1. **Query Before** - Leverage existing knowledge before each step
2. **Enhance During** - Use knowledge to improve processing quality
3. **Ingest After** - Contribute new insights back to knowledge base

#### **MCP Integration Points**
Every command includes:
- **Pre-analysis queries**: Query existing domain intelligence and patterns
- **Knowledge ingestion**: Contribute new insights and discoveries
- **Pattern recognition**: Identify and apply proven approaches
- **Consistency validation**: Ensure cross-artifact alignment

## Enhanced Command System

### Core Commands with MCP Integration

#### **Foundation Commands**
- `/constitution` - Project governance and principles
- `/review-spec-domain` - Combined requirements analysis + domain Event Storming
- `/specify` - Feature specification creation
- `/clarify` - Requirements clarification and ambiguity resolution

#### **Event Storming Commands**
- `/event-storm-feature` - Feature-level detailed Event Storming
- `/event-storm-analyze` - Cross-artifact consistency analysis
- `/event-storm-update` - Big model synchronization with feature insights

#### **Knowledge Base Commands**
- `/kb-query` - Intelligent knowledge search with multi-strategy approach
- `/kb-ingest` - Comprehensive knowledge ingestion with quality validation
- `/kb-schema` - Schema analysis and knowledge base structure display

#### **Implementation Commands**
- `/plan` - Technical implementation planning
- `/tasks` - Executable task generation
- `/implement` - Implementation execution
- `/analyze` - Cross-artifact consistency analysis

### Advanced Workflow for Complex Projects

For projects with >50 requirements or multiple features:
```bash
/constitution → /review-spec-domain → [repeat: /specify → /clarify → /event-storm-feature → /plan → /tasks → /implement]
```

For simple features:
```bash
/constitution → /specify → /clarify → /event-storm-feature → /plan → /tasks → /implement
```

## Template System

### Enhanced Templates with MCP Integration
All 20+ templates include:
- **MCP Integration Sections**: Pre-analysis queries and post-analysis ingestion
- **Knowledge Enhancement**: Strategic knowledge utilization points
- **Consistency Validation**: Cross-artifact quality assurance
- **Workflow Integration**: Seamless connection between commands

### Key Template Categories
1. **Command Templates** (`templates/commands/`) - 15 specialized command templates
2. **Root Templates** (`templates/`) - 5 foundational templates
3. **Agent Templates** - AI assistant-specific configuration files

### Template Processing Pipeline
The template system follows a sophisticated pipeline:
1. **Download**: Fetch from GitHub releases (`spec-kit-template-{agent}-{script_type}.zip`)
2. **Path Mapping**: Rewrite paths from `/memory/`, `/scripts/`, `/templates/` to `.specify/` subdirectories
3. **Flattening**: Handle GitHub-style nested ZIP structures
4. **Command Generation**: Convert markdown templates to agent-specific commands
5. **Agent Integration**: Generate agent-specific configuration files

### MCP Integration Architecture
Modern templates include Model Context Protocol (MCP) integration:
- **Knowledge Base Queries**: Domain intelligence retrieval
- **Entity Extraction**: Automatic entity and relationship identification
- **Requirement Enrichment**: Missing requirement detection
- **Pattern Matching**: Similar feature analysis

## Key Features

### Spec-Driven Development Workflow
1. **Intent-driven development** - Focus on "what" and "why" before "how"
2. **Multi-step refinement** - Iterative specification improvement
3. **Template-guided generation** - Structured prompts ensure quality
4. **Constitutional compliance** - Enforces architectural principles

### Security Considerations
- GitHub token support for private/corporate environments
- SSL/TLS verification (can be disabled with `--skip-tls`)
- Agent folder security warnings for credential protection
- Safe file extraction with temporary directory handling

### Error Handling
- Comprehensive error reporting with debug mode
- Graceful degradation when optional tools are missing
- Interactive recovery for common failure scenarios

## Important Implementation Details

### GitHub Integration
- Uses GitHub API to fetch latest releases from `thnh-dng/spec-kit` repository
- Supports authentication via tokens or environment variables (`GH_TOKEN`, `GITHUB_TOKEN`)
- Handles rate limiting and network failures gracefully
- Downloads template packages matching pattern: `spec-kit-template-{agent}-{script_type}.zip`

### Cross-Platform Compatibility
- Automatic script type detection (bash/PowerShell) based on OS
- Path handling for Windows/Unix differences
- Permission management for executable scripts (POSIX only)
- Special handling for Claude CLI post-migration path: `~/.claude/local/claude`

### Progress Tracking
- `StepTracker` class provides hierarchical progress tracking with live UI updates
- Rich terminal interface with step-by-step progress using Live display
- Status indicators: pending (○), running (○), done (●), error (●), skipped (○)
- Real-time progress bars for downloads with percentage completion

### Key Technical Details
- SSL context management with `truststore` for secure connections
- Temporary directory handling for safe file extraction
- Nested ZIP structure flattening (GitHub-style releases)
- Interactive arrow-key selection menus for AI agent and script type
- Comprehensive error handling with debug mode (`--debug` flag)
- Git repository detection and initialization
- Component Relationships: `CLI Entry → Banner → Interactive Selection → Progress Tracking → Template Download → Extraction → Git Init → Agent Setup`

## Testing and Validation

### Manual Testing
```bash
# Test all AI agent integrations
for agent in claude gemini copilot cursor qwen opencode codex windsurf kilocode auggie roo q; do
    echo "Testing $agent..."
    specify init test-$agent --ai $agent --ignore-agent-tools --no-git
done

# Test script type variations
specify init test-sh --script sh --ignore-agent-tools --no-git
specify init test-ps --script ps --ignore-agent-tools --no-git

# Test current directory initialization
mkdir test-current && cd test-current
specify init . --ai claude --ignore-agent-tools --no-git
```

### Quality Assurance
- **Template Validation**: All templates follow consistent MCP integration patterns
- **Script Validation**: Cross-platform script functionality verification
- **Workflow Testing**: End-to-end workflow validation
- **Knowledge Base Testing**: MCP server integration verification

### Edge Cases to Test
- Network failures during download
- Invalid GitHub tokens or authentication issues
- Existing file conflicts during project initialization
- Permission issues with script execution
- Git repository detection and initialization problems
- Nested ZIP extraction from GitHub releases

## Configuration and Environment

### Environment Variables
- `GH_TOKEN` / `GITHUB_TOKEN` - GitHub authentication for private repositories
- `SPECIFY_FEATURE` - Override feature detection for non-Git repos

### AI Agent Paths and Security
- Claude: `~/.claude/local/claude` (post-migration path)
- Other agents: Standard installation paths vary by platform
- **Security Note**: Agent folders may contain credentials - add to `.gitignore` as needed
- Agent folder mappings: `.claude/`, `.gemini/`, `.cursor/`, `.qwen/`, `.opencode/`, `.codex/`, `.windsurf/`, `.kilocode/`, `.augment/`, `.github/`, `.roo/`, `.amazonq/`

## Release Management

### Versioning
- Version defined in `pyproject.toml` (current: 0.0.17)
- GitHub releases with tagged assets for each AI agent and script type combination
- Template packages follow naming: `spec-kit-template-{agent}-{script_type}-{version}.zip`
- Automated release workflow in `.github/workflows/release.yml`

### Building Release
```bash
# Build package
uv build

# Publish to PyPI (requires permissions)
uv publish

# Release workflow triggers on changes to:
# - memory/, scripts/, templates/, .github/workflows/
```

### Release Scripts
- Location: `.github/workflows/scripts/`
- Key scripts:
  - `create-release-packages.sh` - Builds all template variants
  - `create-github-release.sh` - Creates GitHub release with assets
  - `get-next-version.sh` - Calculates next version number
  - `check-release-exists.sh` - Prevents duplicate releases

## Contributing

When working on this codebase:
1. Follow the existing code style and patterns
2. Add comprehensive error handling for all operations
3. Test cross-platform compatibility
4. Maintain backwards compatibility with existing templates
5. Update documentation for new features

## Best Practices

### Development Workflow
1. **Always work with concrete requirements** - Use `/clarify` before Event Storming
2. **Leverage knowledge base strategically** - Query before, ingest after each step
3. **Maintain consistency across artifacts** - Use `/analyze` regularly
4. **Follow constitutional principles** - Ensure compliance with project governance
5. **Document decisions and insights** - Ingest all learnings into knowledge base

### Knowledge Base Management
1. **Progressive enrichment** - Add knowledge at strategic points
2. **Consistency maintenance** - Ensure cross-artifact alignment
3. **Quality focus** - Prioritize high-quality, well-structured knowledge
4. **Regular maintenance** - Perform knowledge base audits and cleanup
5. **Team engagement** - Ensure all team members contribute and benefit

### Event Storming Best Practices
1. **Feature-level focus** - Keep Event Storming sessions focused and concrete
2. **Implementation context** - Consider technical constraints during modeling
3. **Stakeholder involvement** - Include relevant stakeholders in sessions
4. **Documentation** - Thoroughly document all Event Storming results
5. **Continuous refinement** - Update big model with feature insights

## Getting Help

### Documentation Resources
- **Quick Start**: `docs/quickstart.md`
- **Installation**: `docs/installation.md`
- **Enhanced Workflow**: `docs/refined-spec-kit-workflow.md`
- **Event Storming Guide**: `docs/event-storming-agent-guide.md`
- **Knowledge Base Guide**: `docs/knowledge-agent-mcp-guide.md`
- **Command Reference**: `docs/event-storming-knowledge-commands.md`

### Command Help
```bash
# Get help with any command
specify --help
specify init --help

# Check system requirements
specify check
```

## Template Development

When creating or modifying templates:
1. **Use structured markdown** - Clear sections and consistent formatting
2. **Include MCP integration** - Add pre-analysis queries and post-analysis ingestion
3. **Provide constitutional compliance** - Ensure alignment with project principles
4. **Include examples and validation** - Help users understand proper usage
5. **Test across AI agents** - Ensure compatibility with all supported assistants
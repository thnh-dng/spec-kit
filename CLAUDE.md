# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Spec Kit is a Spec-Driven Development (SDD) toolkit that flips traditional software development on its head. Instead of code being king, specifications become executable and directly generate working implementations. The project provides a CLI tool (`specify`) that bootstraps projects for structured, specification-driven development.

## Core Architecture

### CLI Tool Structure
- **Entry Point**: `src/specify_cli/__init__.py` - Main CLI application using Typer
- **Dependencies**: typer (CLI framework), rich (terminal formatting), httpx (HTTP requests), platformdirs (config paths)
- **Installation**: Can be installed via `uv tool install` or run directly with `uvx`

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
python -m specify_cli --help

# Test installation
uv pip install -e .
specify --help

# Check for required tools
specify check
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
```

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

## Slash Commands System

After project initialization, AI agents gain access to structured development commands:

- `/constitution` - Establish project principles and guidelines
- `/review-spec` - Analyze complex requirements and break them into manageable features
- `/specify` - Create feature specifications from user descriptions
- `/clarify` - Structured questioning to resolve ambiguities
- `/plan` - Generate technical implementation plans
- `/tasks` - Create executable task lists
- `/analyze` - Cross-artifact consistency analysis
- `/implement` - Execute implementation tasks

### Enhanced Workflows

**For Complex Requirements** (recommended for projects with >50 requirements or multiple features):
```
/constitution → /review-spec → /specify (for each feature) → /plan → /tasks → /implement
```

**For Simple Features** (traditional workflow):
```
/constitution → /specify → /plan → /tasks → /implement
```

The `/review-spec` command is particularly valuable for:
- Large requirement documents or complex business domains
- Projects requiring multiple features with dependencies
- Enterprise applications with integration points
- Legacy system modernization with phased approaches

**Note**: `/review-spec` works in the current branch and creates timestamped analysis directories (`specs/complex-requirements-analysis-[TIMESTAMP]/`) without creating new branches.

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
- Uses GitHub API to fetch latest releases
- Supports authentication via tokens or environment variables
- Handles rate limiting and network failures gracefully

### Cross-Platform Compatibility
- Automatic script type detection (bash/PowerShell)
- Path handling for Windows/Unix differences
- Permission management for executable scripts

### Progress Tracking
- Rich terminal interface with step-by-step progress
- Live updates during download and extraction
- Visual feedback for all operations

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

### Edge Cases to Test
- Network failures during download
- Invalid GitHub tokens
- Existing file conflicts
- Permission issues
- Git repository detection
- Nested ZIP extraction

## Configuration and Environment

### Environment Variables
- `GH_TOKEN` / `GITHUB_TOKEN` - GitHub authentication
- `SPECIFY_FEATURE` - Override feature detection for non-Git repos

### AI Agent Paths
- Claude: `~/.claude/local/claude` (post-migration)
- Others: Standard installation paths

## Release Management

### Versioning
- Version defined in `pyproject.toml`
- GitHub releases with tagged assets
- Template packages for each AI agent and script type

### Building Release
```bash
# Build package
uv build

# Publish to PyPI (requires permissions)
uv publish
```

## Contributing

When working on this codebase:
1. Follow the existing code style and patterns
2. Add comprehensive error handling for all operations
3. Test cross-platform compatibility
4. Maintain backwards compatibility with existing templates
5. Update documentation for new features

## Template Development

When creating or modifying templates:
1. Use structured markdown with clear sections
2. Include constitutional compliance checkpoints
3. Provide example usage and validation scenarios
4. Ensure templates work across different AI agents
5. Test with real-world feature specifications
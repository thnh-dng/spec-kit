# Installation and Setup Guide

This guide provides comprehensive instructions for setting up and configuring the enhanced Spec Kit with Event Storming and knowledge base functionality.

## Prerequisites

### System Requirements
- **Operating System**: Linux, macOS, or Windows (with PowerShell)
- **Python**: 3.8 or higher
- **Git**: Required for version control integration
- **Memory**: Minimum 4GB RAM (8GB recommended for complex projects)
- **Storage**: 1GB free space for installation and templates

### Required Dependencies
- **uv**: Python package manager (recommended)
- **Neo4j**: For knowledge base storage (optional but recommended)
- **MCP Server**: Knowledge Agent MCP server (included with templates)

## Installation Steps

### Option 1: Using UV (Recommended)
```bash
# Install Spec Kit using UV
uv tool install spec-kit

# Verify installation
specify --help
```

### Option 2: Using Pip
```bash
# Install from PyPI
pip install spec-kit

# Verify installation
specify --help
```

### Option 3: Development Installation
```bash
# Clone repository
git clone https://github.com/thnh-dng/spec-kit.git
cd spec-kit

# Install in development mode
uv pip install -e .

# Verify installation
specify --help
```

## Knowledge Base Setup

### Neo4j Installation (Recommended)

#### Using Docker
```bash
# Start Neo4j container
docker run -d \
  --name neo4j \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/password \
  -v neo4j_data:/data \
  neo4j:latest

# Access Neo4j Browser
# Open http://localhost:7474 in your browser
# Username: neo4j
# Password: password
```

#### Manual Installation
1. Download Neo4j from https://neo4j.com/download/
2. Follow installation instructions for your platform
3. Start Neo4j service
4. Verify connection at http://localhost:7474

### Knowledge Base Configuration

1. **Configure Neo4j Connection**:
   ```bash
   # Create configuration file
   mkdir -p ~/.config/spec-kit
   cat > ~/.config/spec-kit/config.json << EOF
   {
     "knowledge_base": {
       "neo4j": {
         "uri": "bolt://localhost:7687",
         "username": "neo4j",
         "password": "password"
       }
     }
   }
   EOF
   ```

2. **Test Knowledge Base Connection**:
   ```bash
   # Initialize a test project
   specify init test-kb --ai claude --ignore-agent-tools

   # Test knowledge base integration
   cd test-kb
   /kb-query "test connection"
   ```

## MCP Server Setup

### Knowledge Agent MCP Server

1. **Install MCP Server**:
   ```bash
   # Install via npm (if using Node.js version)
   npm install -g @modelcontextprotocol/server-knowledge-agent

   # Or via pip (if using Python version)
   pip install mcp-server-knowledge-agent
   ```

2. **Configure Claude Code Integration**:
   ```json
   // Add to Claude Code configuration
   {
     "mcpServers": {
       "knowledge-agent": {
         "command": "node",
         "args": ["node_modules/@modelcontextprotocol/server-knowledge-agent/dist/index.js"],
         "env": {
           "NEO4J_URI": "bolt://localhost:7687",
           "NEO4J_USERNAME": "neo4j",
           "NEO4J_PASSWORD": "password"
         }
       }
     }
   }
   ```

## Project Initialization

### Basic Setup
```bash
# Initialize new project with enhanced functionality
specify init my-project --ai claude

# Navigate to project
cd my-project

# Verify enhanced commands are available
/constitution
```

### With Knowledge Base Integration
```bash
# Initialize with knowledge base support
specify init my-project --ai claude

# Test knowledge base commands
/kb-query "project initialization patterns"
/kb-ingest "Initial project requirements and domain context"
```

## Verification and Testing

### Command Verification
```bash
# Test all enhanced commands
/review-spec-domain --help
/event-storm-feature --help
/event-storm-analyze --help
/event-storm-update --help
/kb-query --help
/kb-ingest --help
```

### Cross-Platform Script Testing
```bash
# Test bash scripts (Linux/macOS)
ls scripts/bash/
# Should show: review-spec-domain.sh, event-storm-feature.sh, etc.

# Test PowerShell scripts (Windows)
ls scripts/powershell/
# Should show: review-spec-domain.ps1, event-storm-feature.ps1, etc.
```

### Template Verification
```bash
# Check template availability
ls templates/commands/
# Should show: review-spec-domain.md, event-storm-feature.md, etc.

# Verify slash command templates
ls .specify/templates/
# Should include enhanced templates
```

## Configuration Files

### Project-Level Configuration
```json
// .specify/config.json
{
  "project": {
    "name": "my-project",
    "ai_agent": "claude",
    "knowledge_base": {
      "enabled": true,
      "auto_ingest": true,
      "query_before_analysis": true
    },
    "event_storming": {
      "auto_sync": true,
      "consistency_check": true
    }
  }
}
```

### Environment Variables
```bash
# Set environment variables
export NEO4J_URI="bolt://localhost:7687"
export NEO4J_USERNAME="neo4j"
export NEO4J_PASSWORD="password"
export SPECIFY_KB_ENABLED="true"
export SPECIFY_EVENT_STORMING_ENABLED="true"
```

## Troubleshooting

### Common Issues

#### Knowledge Base Connection Issues
```bash
# Check Neo4j status
docker ps | grep neo4j

# Test Neo4j connection
cypher-shell -u neo4j -p password "RETURN 1"

# Check MCP server logs
journalctl -u mcp-server-knowledge-agent
```

#### Command Not Found
```bash
# Verify Spec Kit installation
which specify

# Check PATH variable
echo $PATH | grep -i spec-kit

# Reinstall if necessary
uv tool uninstall spec-kit
uv tool install spec-kit
```

#### Template Issues
```bash
# Check template directory
ls -la templates/commands/

# Verify template permissions
chmod +x scripts/bash/*.sh

# Reinstall templates
specify init fresh-project --ai claude
```

#### Cross-Platform Issues
```bash
# Windows: Ensure PowerShell execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# macOS: Ensure script permissions
chmod +x scripts/bash/*.sh

# Linux: Check shell compatibility
bash --version
```

### Performance Optimization

#### Neo4j Configuration
```json
// Neo4j configuration for better performance
{
  "dbms.memory.heap.initial_size": "512m",
  "dbms.memory.heap.max_size": "2g",
  "dbms.memory.pagecache.size": "1g",
  "dbms.tx_state.memory_allocation": "ON_HEAP"
}
```

#### Knowledge Base Optimization
```bash
# Regular maintenance
/kb-query "knowledge base optimization"

# Clear old data (if needed)
/kb-query "cleanup old knowledge"

# Rebuild indexes (Neo4j)
cypher-shell -u neo4j -p password "CALL db.index.fulltext.awaitEventuallyConsistentIndexRefresh()"
```

## Security Considerations

### Credential Management
```bash
# Use environment variables for sensitive data
export NEO4J_PASSWORD="your_secure_password"

# Or use configuration files with proper permissions
chmod 600 ~/.config/spec-kit/config.json

# Never commit credentials to version control
echo ".config/spec-kit/config.json" >> .gitignore
```

### Network Security
```bash
# Use TLS/SSL for Neo4j connections
export NEO4J_URI="bolt+s://localhost:7687"

# Configure firewall rules
sudo ufw allow 7687/tcp  # Neo4j Bolt
sudo ufw allow 7474/tcp  # Neo4j Browser
```

## Integration with CI/CD

### GitHub Actions Example
```yaml
name: Spec Kit Validation
on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2

    - name: Setup Spec Kit
      run: |
        curl -LsSf https://astral.sh/uv/install.sh | sh
        uv tool install spec-kit

    - name: Validate Project
      run: |
        specify validate --verbose

    - name: Test Knowledge Base
      run: |
        /kb-query "CI/CD validation test"
```

### GitLab CI Example
```yaml
stages:
  - validate

spec_kit_validation:
  stage: validate
  script:
    - pip install spec-kit
    - specify validate --verbose
    - /kb-query "CI/CD validation test"
```

## Backup and Recovery

### Knowledge Base Backup
```bash
# Neo4j backup
docker exec neo4j neo4j-admin database backup neo4j /backups

# Export knowledge base data
/kb-query "export all knowledge" > knowledge-backup.json

# Backup configuration
cp -r ~/.config/spec-kit/ spec-kit-config-backup/
```

### Recovery
```bash
# Restore Neo4j
docker exec neo4j neo4j-admin database restore neo4j /backups/neo4j

# Import knowledge base
/kb-ingest knowledge-backup.json

# Restore configuration
cp -r spec-kit-config-backup/ ~/.config/spec-kit/
```

## Next Steps

After completing the setup:

1. **Create Your First Project**:
   ```bash
   specify init my-first-project --ai claude
   ```

2. **Follow the Enhanced Workflow**:
   ```bash
   cd my-first-project
   /constitution
   /review-spec-domain "your complex requirements"
   ```

3. **Explore the Documentation**:
   - [Event Storming Commands](event-storming-knowledge-commands.md)
   - [Refined Workflow](refined-spec-kit-workflow.md)
   - [MCP Usage Guide](mcp-usage-guide.md)

4. **Join the Community**:
   - GitHub Discussions: https://github.com/thnh-dng/spec-kit/discussions
   - Issues: https://github.com/thnh-dng/spec-kit/issues

## Support

### Getting Help
- **Documentation**: See `/docs/` directory for comprehensive guides
- **Command Help**: Use `--help` flag with any command
- **Community**: Join GitHub Discussions for community support
- **Issues**: Report bugs or request features on GitHub

### Troubleshooting Resources
- [Common Issues](https://github.com/thnh-dng/spec-kit/issues?q=is%3Aissue+is%3Aopen+label%3Abug)
- [Installation Problems](https://github.com/thnh-dng/spec-kit/issues?q=is%3Aissue+is%3Aopen+label%3Ainstallation)
- [Knowledge Base Issues](https://github.com/thnh-dng/spec-kit/issues?q=is%3Aissue+is%3Aopen+label%3Aknowledge-base)

### Contributing
We welcome contributions! Please see [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on:
- Reporting issues
- Submitting pull requests
- Adding new features
- Improving documentation

---

**Happy Spec-Driven Development with Event Storming and Knowledge Base Integration!** 🚀
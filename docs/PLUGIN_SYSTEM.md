# Plugin System

Claude Workflow Pro supports a plugin system for extending functionality with custom commands, agents, and workflows.

## Overview

The plugin system allows you to:
- Create custom slash commands
- Add specialized agents
- Define workflow templates
- Integrate third-party tools
- Share reusable workflows with the community

## Plugin Structure

### Basic Plugin

```
my-plugin/
├── plugin.json          # Plugin manifest
├── commands/            # Custom commands
│   ├── my-command.md
│   └── another-command.md
├── agents/              # Custom agents
│   └── my-agent.md
├── templates/           # Workflow templates
│   └── my-template.md
├── hooks/               # Hook scripts
│   └── pre-commit.sh
└── README.md           # Plugin documentation
```

### Plugin Manifest (`plugin.json`)

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "My custom workflow plugin",
  "author": "Your Name",
  "license": "MIT",
  "homepage": "https://github.com/username/my-plugin",
  "keywords": ["workflow", "automation"],
  "claude-workflow": {
    "minVersion": "1.0.0",
    "maxVersion": "2.x.x"
  },
  "commands": [
    {
      "name": "my-command",
      "file": "commands/my-command.md",
      "description": "Does something useful"
    }
  ],
  "agents": [
    {
      "name": "my-agent",
      "file": "agents/my-agent.md",
      "type": "specialized"
    }
  ],
  "templates": [
    {
      "name": "my-template",
      "file": "templates/my-template.md",
      "category": "feature-development"
    }
  ],
  "hooks": {
    "pre-commit": "hooks/pre-commit.sh",
    "post-checkout": "hooks/post-checkout.sh"
  },
  "dependencies": {
    "other-plugin": "^1.0.0"
  },
  "config": {
    "schema": "config-schema.json",
    "defaults": {
      "setting1": "value1"
    }
  }
}
```

## Creating Plugins

### 1. Initialize Plugin

```bash
# Using plugin CLI
claude-plugin init my-plugin

# Or manually
mkdir my-plugin
cd my-plugin
```

### 2. Create Plugin Manifest

See `plugin.json` structure above.

### 3. Add Commands

Create command files in `commands/` directory:

```markdown
# My Custom Command

Description of what this command does.

## Usage

```bash
/my-plugin/my-command [options]
```

## What It Does

1. Step 1
2. Step 2
3. Step 3
```

### 4. Add Agents (Optional)

Create agent files in `agents/` directory following agent format.

### 5. Add Templates (Optional)

Create template files in `templates/` directory following template format.

## Installing Plugins

### From NPM

```bash
claude-plugin install my-plugin
```

### From GitHub

```bash
claude-plugin install github:username/my-plugin
```

### From Local Directory

```bash
claude-plugin install ./path/to/my-plugin
```

## Plugin Configuration

### User Configuration

Add to `.claude-settings.json`:

```json
{
  "plugins": {
    "my-plugin": {
      "enabled": true,
      "config": {
        "setting1": "custom-value"
      }
    }
  }
}
```

### Plugin-Specific Config

Create `.my-plugin.json` in project root:

```json
{
  "setting1": "value1",
  "setting2": "value2"
}
```

## Plugin Examples

### Example 1: Docker Integration Plugin

```
docker-workflow/
├── plugin.json
├── commands/
│   ├── build-container.md
│   ├── run-container.md
│   └── deploy-container.md
└── templates/
    └── containerize-app.md
```

**plugin.json:**
```json
{
  "name": "docker-workflow",
  "version": "1.0.0",
  "description": "Docker integration for Claude Workflow Pro",
  "commands": [
    {
      "name": "build-container",
      "file": "commands/build-container.md"
    },
    {
      "name": "run-container",
      "file": "commands/run-container.md"
    }
  ]
}
```

**Usage:**
```bash
/docker-workflow/build-container
/docker-workflow/run-container
```

### Example 2: Database Migration Plugin

```
db-migrations/
├── plugin.json
├── commands/
│   ├── create-migration.md
│   ├── run-migration.md
│   └── rollback.md
└── agents/
    └── migration-agent.md
```

### Example 3: Testing Framework Plugin

```
test-framework/
├── plugin.json
├── commands/
│   ├── generate-tests.md
│   ├── run-tests.md
│   └── coverage-report.md
├── agents/
│   └── test-generator-agent.md
└── templates/
    └── test-driven-development.md
```

## Publishing Plugins

### 1. Prepare Plugin

```bash
# Validate plugin
claude-plugin validate

# Test plugin locally
claude-plugin test

# Build plugin
claude-plugin build
```

### 2. Publish to NPM

```bash
npm publish
```

### 3. Register with Claude Plugin Registry

```bash
claude-plugin register
```

## Plugin Best Practices

### 1. Clear Documentation

```markdown
# Plugin Name

Clear description of what the plugin does.

## Installation

```bash
claude-plugin install plugin-name
```

## Usage

Examples of all commands.

## Configuration

Configuration options and examples.
```

### 2. Versioning

Follow semantic versioning:
- **Major**: Breaking changes
- **Minor**: New features
- **Patch**: Bug fixes

### 3. Testing

```bash
# Test commands
claude-plugin test commands

# Test agents
claude-plugin test agents

# Test templates
claude-plugin test templates
```

### 4. Error Handling

Provide clear error messages:

```bash
Error: Docker not installed
Solution: Install Docker from https://docker.com

Error: Invalid configuration
Solution: Check .docker-workflow.json format
```

## Plugin API

### Command Hooks

```javascript
// Pre-execution hook
beforeCommand(context) {
  // Setup logic
}

// Post-execution hook
afterCommand(context, result) {
  // Cleanup logic
}
```

### Agent Hooks

```javascript
// Before agent invocation
beforeAgent(context) {
  // Prepare context
}

// After agent completion
afterAgent(context, output) {
  // Process output
}
```

### Configuration Access

```javascript
// Access plugin config
const config = getPluginConfig('my-plugin');

// Access user settings
const userSettings = getUserSettings();
```

## Community Plugins

### Official Plugins

- **docker-workflow** - Docker integration
- **k8s-workflow** - Kubernetes integration
- **aws-workflow** - AWS integration
- **terraform-workflow** - Terraform integration

### Community Plugins

- Browse: https://plugins.claude-workflow.pro
- Submit: https://github.com/claude-workflow-pro/plugins

## Plugin Development

### Dev Mode

```bash
# Enable dev mode
claude-plugin dev enable

# Link local plugin
claude-plugin link ./my-plugin

# Watch for changes
claude-plugin watch
```

### Debugging

```bash
# Enable debug logging
export CLAUDE_PLUGIN_DEBUG=1

# Run command with debug
claude --debug /my-plugin/my-command
```

### Testing

```bash
# Run plugin tests
npm test

# Test specific command
claude-plugin test:command my-command

# Integration tests
claude-plugin test:integration
```

## Security

### Plugin Review

All plugins undergo security review before listing in registry.

### Permissions

Plugins declare required permissions:

```json
{
  "permissions": {
    "filesystem": ["read", "write"],
    "network": ["http", "https"],
    "git": ["read", "write"],
    "github": ["repos", "issues"]
  }
}
```

Users approve permissions on installation.

### Sandboxing

Plugins run in restricted environment:
- No access to system files outside project
- Limited network access
- No execution of arbitrary code

## Plugin Marketplace

### Discovering Plugins

```bash
# Search plugins
claude-plugin search docker

# List all plugins
claude-plugin list --all

# Show plugin details
claude-plugin show docker-workflow
```

### Rating and Reviews

Users can rate and review plugins:

```bash
# Rate plugin
claude-plugin rate docker-workflow 5

# Review plugin
claude-plugin review docker-workflow "Great plugin!"
```

## Troubleshooting

### Plugin Not Loading

```bash
# Check plugin status
claude-plugin status my-plugin

# Reinstall plugin
claude-plugin uninstall my-plugin
claude-plugin install my-plugin

# Check logs
claude-plugin logs my-plugin
```

### Command Not Found

```bash
# List installed commands
claude-plugin commands

# Reload plugins
claude-plugin reload
```

### Version Conflicts

```bash
# Check compatibility
claude-plugin check

# Update plugin
claude-plugin update my-plugin

# Force install specific version
claude-plugin install my-plugin@1.0.0
```

## Advanced Topics

### Multi-Plugin Workflows

Plugins can depend on and integrate with other plugins:

```json
{
  "dependencies": {
    "docker-workflow": "^1.0.0",
    "k8s-workflow": "^2.0.0"
  }
}
```

### Plugin Events

Listen to workflow events:

```javascript
{
  "events": {
    "checkpoint:created": "handleCheckpoint",
    "plan:completed": "handlePlanCompletion",
    "pr:merged": "handlePRMerge"
  }
}
```

### Custom Agents

Create sophisticated agents:

```markdown
# My Custom Agent

## Capabilities

- Capability 1
- Capability 2
- Capability 3

## Usage

```bash
/my-plugin/my-agent "task description"
```

## Configuration

Agent-specific configuration options.
```

## Resources

- **Plugin Template**: https://github.com/claude-workflow-pro/plugin-template
- **Plugin Examples**: https://github.com/claude-workflow-pro/plugin-examples
- **Plugin Registry**: https://plugins.claude-workflow.pro
- **Developer Docs**: https://docs.claude-workflow.pro/plugins
- **Community Forum**: https://github.com/claude-workflow-pro/discussions

---

**Version:** 1.0.0
**Last Updated:** 2025-11-16

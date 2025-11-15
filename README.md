# Claude Workflow Pro

Comprehensive development workflow automation plugin for Claude Code.

## Features

- **TDD-First Development**: Automated reminders and workflow enforcement for Test-Driven Development
- **Research → Plan → Implement**: Structured workflow for tackling complex features
- **GitHub Integration**: Seamless issue tracking, PR creation, and project management
- **Context Management**: Checkpoint and resume sessions without losing progress
- **Systematic Debugging**: Framework-guided approach to finding root causes
- **Progressive Agents**: Specialized agents for codebase analysis and research

## Quick Start

### Installation

```bash
# Install via Claude Code plugin marketplace
/plugin install claude-workflow-pro@haighd
```

### Basic Usage

```bash
# Create implementation plan from issue
/start-from-issue 123

# Create standalone plan
/create-plan

# Implement plan
/implement-plan docs/implementation-plans/my-plan.md

# Save progress
/checkpoint

# Resume work
/resume-work
```

## Documentation

- [Setup Guide](docs/SETUP.md) - Installation and configuration
- [Command Reference](docs/COMMANDS.md) - All available commands
- [Configuration](docs/CONFIGURATION.md) - Customization options
- [Architecture](docs/ARCHITECTURE.md) - System design and extension points
- [Examples](docs/EXAMPLES.md) - Common workflows

## Requirements

- Claude Code (current stable version)
- Git (for version control features)
- GitHub CLI (`gh`) - optional, for GitHub integration
- Node.js 14+ or Python 3.7+ - optional, for advanced hooks

## License

MIT License - see [LICENSE](LICENSE) for details

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

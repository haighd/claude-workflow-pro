# Claude Workflow Pro - Examples

Welcome to the Claude Workflow Pro examples! This directory contains three progressively complex examples to help you get started.

## Overview

| Example | Complexity | Best For | Key Features |
|---------|-----------|----------|--------------|
| [basic-project](./basic-project/) | ⭐ Simple | First-time users | Core workflow commands |
| [web-app](./web-app/) | ⭐⭐ Standard | Most projects | GitHub integration, hooks |
| [api-service](./api-service/) | ⭐⭐⭐ Advanced | Power users | Full workflow, agents, automation |

## Quick Start

### 1. Basic Project (5 minutes)

**Perfect for**: Learning the basics

```bash
cd basic-project/
# Copy config to your project
cp .claude-plugin-config.json /path/to/your/project/
```

**What you'll learn**:
- ✅ How to initialize a workflow
- ✅ How to create and validate plans
- ✅ How to create checkpoints

**Commands you'll use**:
- `/workflow/init` - Initialize workflow
- `/workflow/create-plan` - Create task plans
- `/workflow/checkpoint` - Save progress

👉 [View Basic Project →](./basic-project/)

---

### 2. Web App (15 minutes)

**Perfect for**: Real-world development with GitHub

```bash
cd web-app/
# Copy config and settings
cp .claude-plugin-config.json /path/to/your/project/
cp -r .claude /path/to/your/project/
chmod +x /path/to/your/project/.claude/hooks/*.sh
```

**What you'll learn**:
- ✅ GitHub issue integration
- ✅ Development workflow commands
- ✅ Custom hooks (commit validation)
- ✅ Auto checkpoints
- ✅ Pull request automation

**Commands you'll use**:
- `/github/start-from-issue` - Start from GitHub issue
- `/github/describe-pr` - Create pull requests
- `/dev/local-review` - Review code changes
- `/dev/commit` - Commit with validation

**Features**:
- Automatic checkpoint creation every 30 minutes
- Commit message validation hook
- Session logging
- GitHub issue linking

👉 [View Web App Example →](./web-app/)

---

### 3. API Service (30 minutes)

**Perfect for**: Advanced workflows with full automation

```bash
cd api-service/
# Copy complete setup
cp .claude-plugin-config.json /path/to/your/project/
cp -r .claude /path/to/your/project/
chmod +x /path/to/your/project/.claude/hooks/*

# Set up environment
cp .env.example .env
# Edit .env with your values
```

**What you'll learn**:
- ✅ Complete GitHub integration
- ✅ Agent system (codebase, docs, web research)
- ✅ Multiple custom hooks
- ✅ Advanced automation
- ✅ Production workflow

**Commands you'll use**:
- All workflow commands
- All GitHub commands
- All development commands
- Research commands with agents

**Features**:
- **Agents**: Automatic codebase analysis, documentation discovery
- **Hooks**: Pre-commit tests, API validation, auto test runner
- **Automation**: Full CI/CD integration
- **Plans**: Detailed task breakdown with checkpoints
- **Research**: Save research results for team

**Example workflow**:
```bash
# 1. Start from issue
claude /github/start-from-issue 123

# 2. Agents automatically discover codebase
# 3. Create detailed plan

claude /workflow/create-plan "Add rate limiting"

# 4. Implement with agent assistance
claude /workflow/implement-plan .claude/plans/rate-limiting.md

# 5. Pre-commit hook automatically runs tests
claude /dev/commit "feat: add rate limiting"

# 6. Create PR with full description
claude /github/describe-pr
```

👉 [View API Service Example →](./api-service/)

---

## Comparison

### Configuration Complexity

**Basic Project**:
```json
{
  "version": "1.0.0",
  "paths": { ... },
  "workflow": { "autoCheckpoint": false }
}
```

**Web App**:
```json
{
  "version": "1.0.0",
  "paths": { ... },
  "workflow": { "autoCheckpoint": true, ... },
  "github": { "enabled": true, ... },
  "development": { "testCommand": "npm test", ... }
}
```

**API Service**:
```json
{
  "version": "1.0.0",
  "paths": { ... },
  "workflow": { ... },
  "github": { ... },
  "development": { ... },
  "agents": { ... },
  "research": { ... }
}
```

### Features Enabled

| Feature | Basic | Web App | API Service |
|---------|-------|---------|-------------|
| Core workflow commands | ✅ | ✅ | ✅ |
| GitHub integration | ❌ | ✅ | ✅ |
| Custom hooks | ❌ | ✅ (1) | ✅ (3+) |
| Auto checkpoints | ❌ | ✅ | ✅ |
| Agent system | ❌ | ❌ | ✅ |
| Research tools | ❌ | ❌ | ✅ |
| Session logging | ❌ | ✅ | ✅ |
| Pre-commit automation | ❌ | ✅ | ✅ |

## Choosing the Right Example

### Start with Basic Project if:
- You're new to Claude Workflow Pro
- You want to learn core concepts
- You have a simple project
- You don't need GitHub integration

### Use Web App if:
- You're working with GitHub
- You want automated checkpoints
- You need commit validation
- You want a standard workflow

### Use API Service if:
- You need the full power of the plugin
- You're working on complex projects
- You want agent assistance
- You need comprehensive automation
- You're on a team

## Common Use Cases

### Solo Developer, Small Project
👉 Start with **Basic Project**

### Team, GitHub-based Development
👉 Use **Web App**

### Large Codebase, Complex Features
👉 Use **API Service**

### Starting a New Project
👉 Start with **Basic**, grow to **Web App** as needed

## Customizing Examples

All examples are templates - customize them for your needs:

### Adding Features

```bash
# Start with basic-project
# Add GitHub integration from web-app
# Add specific hooks from api-service
```

### Removing Features

```bash
# Start with api-service
# Remove agents if not needed
# Simplify hooks
```

### Creating Your Own

1. Copy the example closest to your needs
2. Modify `.claude-plugin-config.json`
3. Add/remove hooks in `.claude/settings.json`
4. Customize for your project

## Example Files

Each example includes:

- ✅ **README.md** - Setup instructions and usage
- ✅ **.claude-plugin-config.json** - Plugin configuration
- ✅ **package.json** - Project dependencies
- ✅ **Source files** - Example application code
- ✅ **.gitignore** - Git ignore patterns

**Web App and API Service also include**:
- ✅ **.claude/settings.json** - Custom Claude settings
- ✅ **.claude/hooks/** - Custom hook scripts
- ✅ Example plans and checkpoints

## Learning Path

**Recommended progression**:

1. **Week 1**: Basic Project
   - Learn core commands
   - Create your first plan
   - Practice checkpoints

2. **Week 2**: Web App
   - Set up GitHub integration
   - Add custom hooks
   - Enable auto checkpoints

3. **Week 3+**: API Service
   - Enable agents
   - Full automation
   - Advanced workflows

## Getting Help

### Documentation

- [Main README](../README.md) - Overview and installation
- [Usage Guide](../USAGE.md) - Complete command reference
- [Configuration](../CONFIGURATION.md) - All config options
- [Hooks Guide](../docs/HOOKS.md) - Custom hooks
- [Agents](../agents/README.md) - Agent system

### Common Questions

**Q: Can I mix features from different examples?**
A: Yes! Copy what you need from each example.

**Q: Which example should I start with?**
A: Start with Basic Project, then add features as needed.

**Q: Can I use this without GitHub?**
A: Yes! Basic Project works without GitHub.

**Q: Do I need all the hooks from API Service?**
A: No, pick the ones you need.

**Q: How do I enable agents?**
A: See the API Service example configuration.

## Next Steps

1. **Choose an example** based on your needs
2. **Copy the configuration** to your project
3. **Try the commands** in the README
4. **Customize** for your workflow
5. **Share** your experience!

## Contributing

Found a better way? Want to add an example?

- Open an issue with suggestions
- Submit a PR with improvements
- Share your example project

## License

All examples are MIT licensed - use them however you like!

---

**Ready to start?** Choose your example:
- [Basic Project →](./basic-project/)
- [Web App →](./web-app/)
- [API Service →](./api-service/)

**Questions?** See the [main documentation](../README.md)

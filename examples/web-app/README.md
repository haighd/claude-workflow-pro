# Web App Example

This is the **standard example** showing typical Claude Workflow Pro usage with GitHub integration.

## What's Included

This example demonstrates:
- ✅ Complete plugin configuration
- ✅ GitHub integration commands
- ✅ Development workflow commands
- ✅ Custom settings and hooks
- ✅ Realistic project structure

## Project Structure

```
web-app/
├── .claude/
│   ├── settings.json           # Custom Claude settings
│   ├── plans/                  # Task plans
│   ├── sessions/               # Session checkpoints
│   └── hooks/                  # Custom hook scripts
│       └── commit-validator.sh
├── .claude-plugin-config.json  # Plugin configuration
├── src/
│   ├── components/
│   │   └── App.jsx
│   ├── utils/
│   │   └── api.js
│   └── index.js
├── tests/
│   └── App.test.js
├── package.json
├── .gitignore
└── README.md
```

## Setup Instructions

### 1. Prerequisites

- GitHub CLI (`gh`) installed
- Git repository initialized
- Node.js installed

### 2. Copy Configuration Files

```bash
# Copy plugin config
cp .claude-plugin-config.json /path/to/your/project/

# Copy settings (optional)
mkdir -p /path/to/your/project/.claude
cp .claude/settings.json /path/to/your/project/.claude/
```

### 3. Install Dependencies

```bash
cd /path/to/your/project
npm install
```

### 4. Configure GitHub

```bash
# Authenticate with GitHub
gh auth login

# Set up repository
gh repo create your-web-app --public --source=.
```

## Configuration

### Plugin Configuration (.claude-plugin-config.json)

```json
{
  "version": "1.0.0",
  "paths": {
    "tasks": ".claude/tasks",
    "plans": ".claude/plans",
    "sessions": ".claude/sessions",
    "documentation": ".claude/docs"
  },
  "workflow": {
    "autoCheckpoint": true,
    "planTemplate": "default",
    "checkpointInterval": 30
  },
  "github": {
    "enabled": true,
    "defaultBranch": "main",
    "autoLinkIssues": true,
    "prTemplate": "default"
  },
  "development": {
    "testCommand": "npm test",
    "buildCommand": "npm run build",
    "lintCommand": "npm run lint"
  }
}
```

### Custom Settings (.claude/settings.json)

See `.claude/settings.json` for an example with:
- Pre-commit validation hook
- Auto-formatting on file write
- Session logging

## Usage Examples

### 1. GitHub Workflow

#### Start from an Issue

```bash
# Fetch and start work on GitHub issue #42
claude /github/start-from-issue 42
```

This will:
- Fetch issue details from GitHub
- Create a new branch
- Generate a task plan
- Set up tracking

#### Create a Pull Request

```bash
# Describe and create PR
claude /github/describe-pr
```

This will:
- Analyze your changes
- Generate PR description
- Create pull request
- Link related issues

### 2. Development Workflow

#### Local Code Review

```bash
# Review uncommitted changes
claude /dev/local-review
```

This will:
- Analyze your changes
- Check for issues
- Suggest improvements
- Validate against best practices

#### Commit Changes

```bash
# Create a commit with validation
claude /dev/commit "Add user authentication"
```

This will:
- Run pre-commit hooks
- Validate commit message
- Create the commit
- Run any configured checks

### 3. Task Planning

#### Create Feature Plan

```bash
claude /workflow/create-plan "Add shopping cart feature"
```

This creates a detailed plan in `.claude/plans/`.

#### Implement Plan

```bash
claude /workflow/implement-plan .claude/plans/shopping-cart.md
```

This executes the plan step-by-step.

### 4. Progress Tracking

#### Auto Checkpoints

With `autoCheckpoint: true`, checkpoints are created automatically every 30 minutes.

#### Manual Checkpoint

```bash
claude /workflow/checkpoint
```

#### Resume Work

```bash
claude /workflow/resume-work .claude/sessions/latest.md
```

## Custom Hooks

This example includes a commit validation hook:

### .claude/hooks/commit-validator.sh

```bash
#!/bin/bash
# Validates commit messages follow conventional commits

message="$1"

if [[ ! "$message" =~ ^(feat|fix|docs|style|refactor|test|chore): ]]; then
  echo "❌ Commit message must follow conventional commits format"
  echo "   Examples: feat:, fix:, docs:, etc."
  exit 1
fi

echo "✅ Commit message format valid"
exit 0
```

To enable it, add to `.claude/settings.json`:

```json
{
  "hooks": {
    "preToolUse": [
      {
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/commit-validator.sh \"$TOOL_INPUT\"",
        "toolMatchers": ["Bash:git commit"]
      }
    ]
  }
}
```

## Workflow Examples

### Adding a New Feature

1. **Create GitHub Issue**
   ```bash
   claude /github/create-issue
   ```

2. **Start from Issue**
   ```bash
   claude /github/start-from-issue <issue-number>
   ```

3. **Implement**
   ```bash
   # Work on the feature
   # Claude will track progress and create checkpoints
   ```

4. **Review**
   ```bash
   claude /dev/local-review
   ```

5. **Commit**
   ```bash
   claude /dev/commit "feat: add user dashboard"
   ```

6. **Create PR**
   ```bash
   claude /github/describe-pr
   ```

### Debugging

```bash
# Get debugging help
claude /dev/debug "Users can't log in"
```

This will:
- Analyze the codebase
- Find related code
- Suggest debugging steps
- Provide troubleshooting guide

## Project Features

This example web app includes:

- React components
- API utilities
- Test setup
- Build configuration
- GitHub Actions (example)

## Tips

1. **Use GitHub Integration**
   - Link PRs to issues automatically
   - Track work in GitHub Issues
   - Use `/github/next-task` to get your next priority

2. **Enable Auto Checkpoints**
   - Set `autoCheckpoint: true`
   - Checkpoints every 30 minutes by default
   - Never lose context

3. **Customize Hooks**
   - Validate commits
   - Format code automatically
   - Run tests before commits
   - See [HOOKS.md](../../docs/HOOKS.md)

4. **Development Commands**
   - Use `/dev/local-review` before commits
   - Use `/dev/debug` for troubleshooting
   - Configure test/build commands in config

## Next Steps

- See [../api-service](../api-service) for the full workflow example
- Read [CONFIGURATION.md](../../CONFIGURATION.md) for all options
- Explore [agents](../../agents/) for advanced features

## Learn More

- [Full Documentation](../../README.md)
- [Usage Guide](../../USAGE.md)
- [Configuration Reference](../../CONFIGURATION.md)
- [Hooks Guide](../../docs/HOOKS.md)

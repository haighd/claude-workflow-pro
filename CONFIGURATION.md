# Configuration Guide

Complete guide to configuring Claude Workflow Pro for your projects.

## Table of Contents

- [Configuration Overview](#configuration-overview)
- [Configuration Files](#configuration-files)
- [Configuration Options](#configuration-options)
- [Directory Configuration](#directory-configuration)
- [GitHub Configuration](#github-configuration)
- [Workflow Configuration](#workflow-configuration)
- [Agent Configuration](#agent-configuration)
- [Examples](#examples)
- [Auto-Detection](#auto-detection)

## Configuration Overview

Claude Workflow Pro uses a flexible configuration system with four levels of precedence:

1. **Project config** (`.claude-plugin-config.json`) - Highest priority
2. **Legacy config** (`.claude/config.json`) - Legacy support
3. **Auto-detection** - Scans project structure
4. **Defaults** - Built-in sensible defaults

### Quick Start

Most projects work fine without configuration! The plugin auto-detects common structures.

For custom setups, create `.claude-plugin-config.json` in your project root.

## Configuration Files

### Project Configuration (Recommended)

Create `.claude-plugin-config.json` in your project root:

```json
{
  "directories": {
    "docs": "docs",
    "thoughts": "docs/thoughts",
    "sessions": "docs/sessions",
    "plans": "docs/implementation-plans",
    "tests": "tests",
    "src": "src"
  },
  "github": {
    "issueLabels": ["bug", "feature", "enhancement", "documentation"],
    "defaultBranch": "main",
    "prTemplate": "default"
  },
  "workflow": {
    "autoCheckpoint": true,
    "checkpointInterval": "30min"
  },
  "agents": {
    "maxResults": 10,
    "contextReduction": true
  }
}
```

### Legacy Configuration

If you have `.claude/config.json`, it will be used as fallback:

```json
{
  "docsDir": "docs",
  "thoughtsDir": "docs/thoughts",
  "sessionsDir": "docs/sessions"
}
```

### Global Configuration

Not currently supported. Use per-project configuration.

## Configuration Options

### Complete Configuration Schema

```json
{
  "directories": {
    "docs": "string",           // Documentation root
    "thoughts": "string",       // Research/thoughts directory
    "sessions": "string",       // Checkpoint/session directory
    "plans": "string",          // Implementation plans directory
    "tests": "string",          // Test directory
    "src": "string",            // Source code directory
    "config": "string"          // Configuration directory
  },
  "github": {
    "issueLabels": ["string"],  // Available issue labels
    "defaultBranch": "string",  // Main branch name
    "prTemplate": "string",     // PR template to use
    "autoLink": boolean,        // Auto-link issues in commits
    "branchPrefix": "string"    // Branch name prefix
  },
  "workflow": {
    "autoCheckpoint": boolean,  // Auto-checkpoint during implementation
    "checkpointInterval": "string", // How often to checkpoint
    "planTemplate": "string",   // Plan template to use
    "progressTracking": boolean // Track implementation progress
  },
  "agents": {
    "maxResults": number,       // Max results per agent
    "contextReduction": boolean, // Use progressive loading
    "categories": ["string"]    // Which agent categories to enable
  },
  "development": {
    "commitFormat": "string",   // Commit message format
    "autoTest": boolean,        // Run tests before commit
    "lintOnSave": boolean      // Run linter before operations
  }
}
```

## Directory Configuration

### `directories.docs`

**Default:** `"docs"` (auto-detected)

Root directory for all documentation.

**Auto-detection looks for:**
- `docs/`
- `documentation/`
- `doc/`
- `.docs/`

**Example:**
```json
{
  "directories": {
    "docs": "documentation"
  }
}
```

### `directories.thoughts`

**Default:** `"docs/thoughts"` (auto-detected)

Directory for research notes and thoughts.

**Auto-detection looks for:**
- `docs/thoughts/`
- `docs/research/`
- `documentation/notes/`
- `thoughts/`

**Example:**
```json
{
  "directories": {
    "thoughts": "docs/research-notes"
  }
}
```

### `directories.sessions`

**Default:** `"docs/sessions"` (auto-detected)

Directory for checkpoint/session files.

**Auto-detection looks for:**
- `docs/sessions/`
- `docs/checkpoints/`
- `.sessions/`

**Example:**
```json
{
  "directories": {
    "sessions": ".checkpoints"
  }
}
```

### `directories.plans`

**Default:** `"docs/implementation-plans"` (auto-detected)

Directory for implementation plans.

**Auto-detection looks for:**
- `docs/implementation-plans/`
- `docs/plans/`
- `plans/`
- `.plans/`

**Example:**
```json
{
  "directories": {
    "plans": "engineering/plans"
  }
}
```

### `directories.tests`

**Default:** `"tests"` (auto-detected)

Directory for test files.

**Auto-detection looks for:**
- `tests/`
- `test/`
- `__tests__/`
- `spec/`

**Example:**
```json
{
  "directories": {
    "tests": "__tests__"
  }
}
```

### `directories.src`

**Default:** `"src"` (auto-detected)

Directory for source code.

**Auto-detection looks for:**
- `src/`
- `lib/`
- `app/`
- Project root

**Example:**
```json
{
  "directories": {
    "src": "lib"
  }
}
```

## GitHub Configuration

### `github.issueLabels`

**Default:** `["bug", "feature", "enhancement", "documentation"]`

Labels available for issue creation and filtering.

**Example:**
```json
{
  "github": {
    "issueLabels": [
      "bug",
      "feature",
      "enhancement",
      "documentation",
      "tech-debt",
      "security",
      "priority:high",
      "priority:medium",
      "priority:low"
    ]
  }
}
```

**Used by:**
- `/github/create-issue` - Label selection
- `/github/next-task` - Issue prioritization
- `/github/setup-github-issues` - Label creation

### `github.defaultBranch`

**Default:** `"main"` (auto-detected from git)

Main branch name for PR creation.

**Example:**
```json
{
  "github": {
    "defaultBranch": "develop"
  }
}
```

**Auto-detection:**
Runs `git symbolic-ref refs/remotes/origin/HEAD` to determine default branch.

### `github.prTemplate`

**Default:** `"default"`

PR description template to use.

**Options:**
- `"default"` - Standard template
- `"detailed"` - More comprehensive template
- `"minimal"` - Brief template
- Custom path to template file

**Example:**
```json
{
  "github": {
    "prTemplate": ".github/pull_request_template.md"
  }
}
```

### `github.autoLink`

**Default:** `true`

Automatically link issue numbers in commit messages.

**Example:**
```json
{
  "github": {
    "autoLink": true
  }
}
```

When enabled, commits reference the issue: `feat: add login (#123)`

### `github.branchPrefix`

**Default:** Auto-determined by issue type

Prefix for branch names created from issues.

**Example:**
```json
{
  "github": {
    "branchPrefix": "feature"
  }
}
```

Creates branches like: `feature/add-login-123`

**Default behavior:**
- `bug` label → `fix/`
- `feature` label → `feature/`
- `enhancement` label → `enhance/`
- Other → `task/`

## Workflow Configuration

### `workflow.autoCheckpoint`

**Default:** `true`

Automatically create checkpoints during implementation.

**Example:**
```json
{
  "workflow": {
    "autoCheckpoint": true
  }
}
```

**When enabled:**
- Checkpoint created every `checkpointInterval`
- Checkpoint before major operations
- Checkpoint when switching contexts

### `workflow.checkpointInterval`

**Default:** `"30min"`

How often to auto-checkpoint.

**Options:**
- `"15min"` - Every 15 minutes
- `"30min"` - Every 30 minutes
- `"1hour"` - Every hour
- `"never"` - Disable auto-checkpoint (manual only)

**Example:**
```json
{
  "workflow": {
    "checkpointInterval": "1hour"
  }
}
```

### `workflow.planTemplate`

**Default:** `"default"`

Template to use for implementation plans.

**Options:**
- `"default"` - Standard template
- `"agile"` - Agile/sprint format
- `"detailed"` - Comprehensive template
- Custom path to template file

**Example:**
```json
{
  "workflow": {
    "planTemplate": "docs/templates/plan-template.md"
  }
}
```

### `workflow.progressTracking`

**Default:** `true`

Track and display implementation progress.

**Example:**
```json
{
  "workflow": {
    "progressTracking": true
  }
}
```

**When enabled:**
- Real-time todo updates
- Progress percentages
- Time estimates
- Completion tracking

## Agent Configuration

### `agents.maxResults`

**Default:** `10`

Maximum results to return per agent query.

**Example:**
```json
{
  "agents": {
    "maxResults": 5
  }
}
```

**Recommendations:**
- Small projects: 5-10
- Medium projects: 10-15
- Large projects: 5 (more focused)

### `agents.contextReduction`

**Default:** `true`

Use progressive loading to reduce context usage.

**Example:**
```json
{
  "agents": {
    "contextReduction": true
  }
}
```

**When enabled:**
- Load category READMEs first
- Load agents on demand
- Filter results aggressively
- 40-60% less context usage

**When disabled:**
- Load all agents upfront
- More comprehensive results
- Higher context usage

### `agents.categories`

**Default:** `["codebase", "documentation", "web", "workflow"]`

Which agent categories to enable.

**Example:**
```json
{
  "agents": {
    "categories": ["codebase", "documentation"]
  }
}
```

**Available categories:**
- `"codebase"` - Code analysis agents
- `"documentation"` - Doc analysis agents
- `"web"` - Web research agents
- `"workflow"` - Workflow agents

## Development Configuration

### `development.commitFormat`

**Default:** `"conventional"`

Commit message format style.

**Options:**
- `"conventional"` - Conventional Commits format
- `"semantic"` - Semantic versioning style
- `"simple"` - Simple descriptive messages

**Example:**
```json
{
  "development": {
    "commitFormat": "conventional"
  }
}
```

**Conventional format:**
```
<type>(<scope>): <description>

<body>

<footer>
```

### `development.autoTest`

**Default:** `false`

Automatically run tests before committing.

**Example:**
```json
{
  "development": {
    "autoTest": true
  }
}
```

**When enabled:**
- Runs test suite before `/development/commit`
- Blocks commit if tests fail
- Shows test output

### `development.lintOnSave`

**Default:** `false`

Run linter before operations.

**Example:**
```json
{
  "development": {
    "lintOnSave": true
  }
}
```

## Examples

### Minimal Configuration

For projects with standard structure:

```json
{
  "github": {
    "defaultBranch": "main"
  }
}
```

Everything else auto-detected!

### Full-Featured Configuration

For projects with custom structure:

```json
{
  "directories": {
    "docs": "documentation",
    "thoughts": "documentation/research",
    "sessions": "documentation/sessions",
    "plans": "documentation/plans",
    "tests": "__tests__",
    "src": "lib"
  },
  "github": {
    "issueLabels": [
      "bug", "feature", "enhancement", "documentation",
      "tech-debt", "security",
      "priority:critical", "priority:high", "priority:medium", "priority:low"
    ],
    "defaultBranch": "develop",
    "prTemplate": ".github/pull_request_template.md",
    "autoLink": true,
    "branchPrefix": "feature"
  },
  "workflow": {
    "autoCheckpoint": true,
    "checkpointInterval": "30min",
    "planTemplate": "default",
    "progressTracking": true
  },
  "agents": {
    "maxResults": 8,
    "contextReduction": true,
    "categories": ["codebase", "documentation", "web"]
  },
  "development": {
    "commitFormat": "conventional",
    "autoTest": true,
    "lintOnSave": false
  }
}
```

### Monorepo Configuration

For monorepo projects:

```json
{
  "directories": {
    "docs": "docs",
    "thoughts": "docs/thoughts",
    "sessions": "docs/sessions",
    "plans": "docs/plans",
    "tests": "packages/*/tests",
    "src": "packages"
  },
  "github": {
    "issueLabels": [
      "bug", "feature",
      "scope:frontend", "scope:backend", "scope:shared"
    ],
    "defaultBranch": "main"
  },
  "workflow": {
    "autoCheckpoint": true,
    "checkpointInterval": "45min"
  }
}
```

### Open Source Project Configuration

For open source projects:

```json
{
  "github": {
    "issueLabels": [
      "bug", "feature", "enhancement", "documentation",
      "good first issue", "help wanted",
      "priority:high", "priority:medium", "priority:low"
    ],
    "defaultBranch": "main",
    "prTemplate": ".github/PULL_REQUEST_TEMPLATE.md",
    "autoLink": true
  },
  "workflow": {
    "autoCheckpoint": false,
    "progressTracking": true
  },
  "development": {
    "commitFormat": "conventional",
    "autoTest": true
  }
}
```

### Agency/Client Work Configuration

For client projects:

```json
{
  "directories": {
    "docs": "project-docs",
    "thoughts": "project-docs/notes",
    "sessions": "project-docs/sessions",
    "plans": "project-docs/implementation-plans"
  },
  "github": {
    "issueLabels": [
      "bug", "feature", "client-request",
      "billable", "non-billable"
    ],
    "defaultBranch": "develop"
  },
  "workflow": {
    "autoCheckpoint": true,
    "checkpointInterval": "15min",
    "progressTracking": true
  }
}
```

## Auto-Detection

When no configuration is provided, the plugin auto-detects:

### Directory Auto-Detection

**Docs directory:**
```bash
# Checks in order:
1. docs/
2. documentation/
3. doc/
4. .docs/
5. Default: "docs"
```

**Thoughts directory:**
```bash
# Checks in order:
1. docs/thoughts/
2. docs/research/
3. documentation/notes/
4. thoughts/
5. Default: "docs/thoughts"
```

**Sessions directory:**
```bash
# Checks in order:
1. docs/sessions/
2. docs/checkpoints/
3. .sessions/
4. Default: "docs/sessions"
```

**Plans directory:**
```bash
# Checks in order:
1. docs/implementation-plans/
2. docs/plans/
3. plans/
4. .plans/
5. Default: "docs/implementation-plans"
```

**Tests directory:**
```bash
# Checks in order:
1. tests/
2. test/
3. __tests__/
4. spec/
5. Default: "tests"
```

**Source directory:**
```bash
# Checks in order:
1. src/
2. lib/
3. app/
4. Default: "src"
```

### Git Auto-Detection

**Default branch:**
```bash
git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
```

**Branch prefix:**
Based on issue labels or defaults to `feature/`

### Project Type Detection

The plugin detects project type to provide better defaults:

**Node.js:**
- Looks for `package.json`
- Sets test command: `npm test`
- Sets lint command: `npm run lint`

**Python:**
- Looks for `requirements.txt`, `setup.py`, `pyproject.toml`
- Sets test command: `pytest`
- Sets lint command: `pylint`

**Ruby:**
- Looks for `Gemfile`
- Sets test command: `rspec`
- Sets lint command: `rubocop`

**Go:**
- Looks for `go.mod`
- Sets test command: `go test`
- Sets lint command: `golint`

## Validation

To validate your configuration:

```bash
# Check if configuration is valid
cat .claude-plugin-config.json | jq .

# Should output formatted JSON with no errors
```

## Troubleshooting

### Configuration not loading

**Check file location:**
```bash
# Should be in project root
ls -la .claude-plugin-config.json
```

**Check JSON syntax:**
```bash
# Validate JSON
cat .claude-plugin-config.json | jq .
```

### Directories not found

**Verify paths:**
```bash
# Check configured paths exist
ls -la docs/
ls -la docs/sessions/
```

**Create missing directories:**
```bash
mkdir -p docs/sessions
mkdir -p docs/implementation-plans
```

### GitHub integration not working

**Check GitHub CLI:**
```bash
gh --version
gh auth status
```

**Verify default branch:**
```bash
git symbolic-ref refs/remotes/origin/HEAD
```

## Best Practices

### Start Simple

Begin with minimal or no configuration. Let auto-detection work.

Add configuration only when needed.

### Use Project Config

Always use `.claude-plugin-config.json` in project root, not global config.

Different projects have different needs.

### Commit Configuration

Add `.claude-plugin-config.json` to version control.

Share configuration with team.

### Document Custom Settings

If using non-standard configuration, document why in README or comments.

### Regular Updates

Review configuration periodically as project evolves.

Update directory paths if restructuring.

## Schema Reference

JSON Schema for `.claude-plugin-config.json`:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "directories": {
      "type": "object",
      "properties": {
        "docs": {"type": "string"},
        "thoughts": {"type": "string"},
        "sessions": {"type": "string"},
        "plans": {"type": "string"},
        "tests": {"type": "string"},
        "src": {"type": "string"},
        "config": {"type": "string"}
      }
    },
    "github": {
      "type": "object",
      "properties": {
        "issueLabels": {"type": "array", "items": {"type": "string"}},
        "defaultBranch": {"type": "string"},
        "prTemplate": {"type": "string"},
        "autoLink": {"type": "boolean"},
        "branchPrefix": {"type": "string"}
      }
    },
    "workflow": {
      "type": "object",
      "properties": {
        "autoCheckpoint": {"type": "boolean"},
        "checkpointInterval": {"type": "string"},
        "planTemplate": {"type": "string"},
        "progressTracking": {"type": "boolean"}
      }
    },
    "agents": {
      "type": "object",
      "properties": {
        "maxResults": {"type": "number"},
        "contextReduction": {"type": "boolean"},
        "categories": {"type": "array", "items": {"type": "string"}}
      }
    },
    "development": {
      "type": "object",
      "properties": {
        "commitFormat": {"type": "string"},
        "autoTest": {"type": "boolean"},
        "lintOnSave": {"type": "boolean"}
      }
    }
  }
}
```

---

For more information, see:
- [README.md](README.md) - Overview and features
- [USAGE.md](USAGE.md) - Usage examples and workflows
- [CHANGELOG.md](CHANGELOG.md) - Version history

# API Service Example

This is the **complete example** showing the full Claude Workflow Pro experience with all features enabled.

## What's Included

This example demonstrates:
- ✅ Complete plugin configuration
- ✅ All workflow commands
- ✅ GitHub integration (issues, PRs, tasks)
- ✅ Agent system (codebase, documentation, web research)
- ✅ Custom hooks and automation
- ✅ Advanced development workflow
- ✅ Production-ready structure

## Project Structure

```
api-service/
├── .claude/
│   ├── settings.json              # Full Claude configuration
│   ├── plans/                     # Task plans
│   │   └── add-auth.md           # Example plan
│   ├── sessions/                  # Session checkpoints
│   │   └── 2025-11-15-checkpoint.md
│   ├── docs/                      # Project documentation
│   │   ├── architecture.md
│   │   └── api-spec.md
│   ├── hooks/                     # Custom automation
│   │   ├── pre-commit.sh
│   │   ├── test-runner.sh
│   │   └── api-validator.js
│   └── session.log               # Auto-generated logs
├── .claude-plugin-config.json     # Full plugin config
├── src/
│   ├── routes/
│   │   ├── auth.js
│   │   └── users.js
│   ├── middleware/
│   │   ├── auth.js
│   │   └── validation.js
│   ├── models/
│   │   └── User.js
│   ├── utils/
│   │   ├── db.js
│   │   └── logger.js
│   └── server.js
├── tests/
│   ├── integration/
│   │   └── auth.test.js
│   └── unit/
│       └── users.test.js
├── docs/
│   └── api.md
├── .github/
│   └── workflows/
│       └── ci.yml
├── package.json
├── .env.example
├── .gitignore
└── README.md
```

## Setup Instructions

### 1. Prerequisites

- Node.js 18+
- PostgreSQL or SQLite
- GitHub CLI (`gh`)
- Git repository with GitHub remote

### 2. Clone and Configure

```bash
# Copy all configuration
cp -r .claude /path/to/your/project/
cp .claude-plugin-config.json /path/to/your/project/

# Make hooks executable
chmod +x /path/to/your/project/.claude/hooks/*.sh

# Install dependencies
cd /path/to/your/project
npm install
```

### 3. Environment Setup

```bash
# Copy environment template
cp .env.example .env

# Edit with your values
# DATABASE_URL=postgresql://...
# JWT_SECRET=your-secret
# etc.
```

### 4. Database Setup

```bash
npm run db:migrate
npm run db:seed
```

## Complete Configuration

### Plugin Config (.claude-plugin-config.json)

This example uses **all** available configuration options:

```json
{
  "version": "1.0.0",
  "paths": {
    "tasks": ".claude/tasks",
    "plans": ".claude/plans",
    "sessions": ".claude/sessions",
    "documentation": ".claude/docs",
    "agents": ".claude/agents"
  },
  "workflow": {
    "autoCheckpoint": true,
    "planTemplate": "detailed",
    "checkpointInterval": 30,
    "validateBeforeImplement": true,
    "requirePlanForFeatures": true
  },
  "github": {
    "enabled": true,
    "defaultBranch": "main",
    "autoLinkIssues": true,
    "prTemplate": "detailed",
    "autoAssignReviewer": true,
    "issueLabels": ["enhancement", "bug", "documentation"]
  },
  "development": {
    "testCommand": "npm test",
    "buildCommand": "npm run build",
    "lintCommand": "npm run lint",
    "typeCheckCommand": "npm run type-check",
    "preCommitHook": true
  },
  "agents": {
    "codebase": {
      "enabled": true,
      "autoDiscover": true
    },
    "documentation": {
      "enabled": true,
      "autoDiscover": true
    },
    "web": {
      "enabled": true
    }
  },
  "research": {
    "defaultDepth": "thorough",
    "saveResults": true,
    "resultsPath": ".claude/research"
  }
}
```

### Custom Settings (.claude/settings.json)

Includes hooks for:
- Session logging (all prompts and tool uses)
- Pre-commit validation (tests, lint, type-check)
- API endpoint validation
- Auto-formatting on save
- Test runner on code changes

## Complete Workflow Examples

### 1. Feature Development (Full Cycle)

#### Step 1: Create GitHub Issue

```bash
claude /github/create-issue
# Title: Add rate limiting to API endpoints
# Labels: enhancement, security
```

#### Step 2: Start from Issue

```bash
claude /github/start-from-issue 123
```

This will:
- Create feature branch `feature/rate-limiting-123`
- Generate comprehensive plan in `.claude/plans/`
- Set up issue tracking

#### Step 3: Review the Plan

```bash
claude /workflow/validate-plan .claude/plans/rate-limiting.md
```

This analyzes the plan for:
- Completeness
- Dependencies
- Potential issues
- Time estimates

#### Step 4: Implement with Agents

```bash
claude /workflow/implement-plan .claude/plans/rate-limiting.md
```

During implementation, agents automatically:
- **Codebase agents**: Find related code, patterns, dependencies
- **Documentation agents**: Reference existing docs, update specs
- **Web agents**: Research best practices, libraries, security

#### Step 5: Test and Review

```bash
# Automatic via pre-commit hook, or manually:
claude /dev/local-review
```

This runs:
- All tests (`npm test`)
- Linting (`npm run lint`)
- Type checking
- Security checks
- Code analysis

#### Step 6: Commit

```bash
claude /dev/commit "feat: add rate limiting middleware"
```

Pre-commit hook automatically:
- Validates commit message format
- Runs test suite
- Checks for lint errors
- Validates API contracts

#### Step 7: Create Pull Request

```bash
claude /github/describe-pr
```

This generates:
- Comprehensive PR description
- Test plan
- Breaking changes (if any)
- Links to issue #123
- Screenshots (if UI changes)

### 2. Bug Fix Workflow

```bash
# Start from bug report
claude /github/start-from-issue 456

# Debug the issue
claude /dev/debug "API returns 500 on user creation"

# Implement fix
claude /workflow/implement-plan .claude/plans/fix-user-creation.md

# Verify fix
npm test

# Commit and PR
claude /dev/commit "fix: handle duplicate email in user creation"
claude /github/describe-pr
```

### 3. Research and Documentation

#### Research Best Practices

```bash
claude /research/codebase "authentication patterns"
```

This uses codebase agents to:
- Find all auth-related code
- Analyze patterns
- Document approaches
- Suggest improvements

#### Research External Solutions

```bash
# Activate web research agent
# Then ask: "Research rate limiting libraries for Node.js"
```

Web agent will:
- Search for solutions
- Compare options
- Provide recommendations
- Save research to `.claude/research/`

#### Update Documentation

```bash
# Documentation agent automatically discovers .claude/docs/
# Helps maintain architecture docs, API specs, etc.
```

### 4. Multi-Task Planning

```bash
# Get next priority from GitHub
claude /github/next-task

# Create epic plan
claude /workflow/create-plan "v2.0 API redesign"
```

This creates a detailed plan with:
- All sub-tasks
- Dependencies
- Estimates
- Checkpoints

### 5. Long-Running Sessions

With auto-checkpoints enabled:

```bash
# Start big feature
claude /workflow/implement-plan .claude/plans/v2-api.md

# Work for hours...
# Checkpoints auto-created every 30 minutes

# Context gets full, resume from checkpoint
claude /workflow/resume-work .claude/sessions/2025-11-15-1430-checkpoint.md
```

## Custom Hooks

### Pre-Commit Hook (.claude/hooks/pre-commit.sh)

```bash
#!/bin/bash
# Runs tests, lint, and type-check before commits

echo "🔍 Running pre-commit checks..."

# Run tests
npm test || {
  echo "❌ Tests failed"
  exit 1
}

# Run lint
npm run lint || {
  echo "❌ Lint failed"
  exit 1
}

# Type check
npm run type-check || {
  echo "❌ Type check failed"
  exit 1
}

echo "✅ All checks passed"
exit 0
```

### API Validator (.claude/hooks/api-validator.js)

Validates API changes don't break contracts:

```javascript
// Checks OpenAPI spec, validates routes, etc.
// See file for full implementation
```

### Test Runner (.claude/hooks/test-runner.sh)

Automatically runs tests when code changes:

```bash
# Watches for file changes and runs relevant tests
# Smart test selection based on what changed
```

## Agent Integration

### Codebase Agents

Automatically activated for:
- Finding related code
- Analyzing patterns
- Discovering dependencies
- Refactoring assistance

Example prompts that trigger codebase agents:
- "Find all authentication code"
- "Where is user validation implemented?"
- "Show me the database schema"

### Documentation Agents

Automatically activated for:
- Finding relevant docs
- Updating documentation
- Maintaining consistency
- API spec validation

Example prompts:
- "Update the API documentation"
- "What does the architecture doc say about auth?"
- "Document this new endpoint"

### Web Research Agents

Manually activated for:
- Best practices research
- Library comparisons
- Security advisories
- Latest standards

Example usage:
- "Research OAuth 2.0 best practices"
- "Compare rate limiting libraries"
- "Find PostgreSQL performance tips"

## Development Commands

### Testing

```bash
# Run all tests
npm test

# Run specific test suite
npm test -- auth.test.js

# Watch mode
npm test -- --watch
```

### Building

```bash
# Development build
npm run build:dev

# Production build
npm run build

# Type checking
npm run type-check
```

### Database

```bash
# Migrations
npm run db:migrate

# Seed data
npm run db:seed

# Reset
npm run db:reset
```

## Tips for Maximum Productivity

1. **Let GitHub Drive Your Work**
   - Use issues for all work items
   - `/github/next-task` shows priorities
   - Automatic branch naming and linking

2. **Trust the Agents**
   - Agents auto-discover and activate
   - They understand your codebase
   - Let them find patterns and docs

3. **Plan Complex Work**
   - Use `/workflow/create-plan` for features
   - Validate plans before implementing
   - Break down into checkpoints

4. **Use Auto-Checkpoints**
   - Never lose context
   - Resume anytime with `/workflow/resume-work`
   - Share checkpoints with team

5. **Customize Hooks**
   - Automate repetitive tasks
   - Enforce standards automatically
   - See [HOOKS.md](../../docs/HOOKS.md)

6. **Research Effectively**
   - Use codebase research for internal knowledge
   - Use web research for external solutions
   - Save all research for team reference

## File Examples

### Example Plan (.claude/plans/add-auth.md)

See the included example plan showing:
- Task breakdown
- Dependencies
- Implementation steps
- Testing requirements
- Checkpoints

### Example Checkpoint (.claude/sessions/2025-11-15-checkpoint.md)

See the included example checkpoint showing:
- Progress summary
- What's completed
- What's next
- Context for resuming

## Learn More

- [Basic Example](../basic-project/) - Start here
- [Web App Example](../web-app/) - GitHub integration
- [Full Documentation](../../README.md)
- [Usage Guide](../../USAGE.md)
- [Configuration Reference](../../CONFIGURATION.md)
- [Hooks Guide](../../docs/HOOKS.md)
- [Agent System](../../agents/README.md)

## Next Steps

1. Copy this structure to your project
2. Customize configuration for your needs
3. Add your own hooks and automation
4. Share with your team

**Happy coding with Claude Workflow Pro!** 🚀

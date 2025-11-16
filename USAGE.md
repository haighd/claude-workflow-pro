# Usage Guide

Comprehensive guide to using Claude Workflow Pro for various development workflows.

## Table of Contents

- [Getting Started](#getting-started)
- [Workflow Commands](#workflow-commands)
- [GitHub Integration](#github-integration)
- [Development Tools](#development-tools)
- [Research & Analysis](#research--analysis)
- [Common Workflows](#common-workflows)
- [Best Practices](#best-practices)

## Getting Started

### Your First Workflow

The simplest way to start is with the basic workflow cycle:

```bash
# 1. Initialize a workflow
/workflow/init

# 2. Create a plan
/workflow/create-plan

# 3. Implement the plan
/workflow/implement-plan

# 4. Save progress
/workflow/checkpoint
```

### Example: Adding a New Feature

Let's walk through adding a user authentication feature:

**Step 1: Initialize**
```bash
/workflow/init
```
Claude will:
- Create workflow directories if needed
- Set up session tracking
- Prepare for checkpoints

**Step 2: Create Plan**
```bash
/workflow/create-plan
```
You'll be prompted for:
- Feature description: "Add user authentication with JWT"
- Requirements and constraints
- Success criteria

Claude generates a detailed plan saved to `docs/implementation-plans/YYYY-MM-DD-user-authentication.md`

**Step 3: Implement**
```bash
/workflow/implement-plan docs/implementation-plans/2025-11-15-user-authentication.md
```

Claude will:
- Break down the plan into tasks
- Implement each task systematically
- Run tests after each step
- Track progress

**Step 4: Save Progress**
```bash
/workflow/checkpoint
```

Checkpoint saved to `docs/sessions/2025-11-15-1430-checkpoint.md`

## Workflow Commands

### `/workflow/init`

Initializes a structured workflow with proper directory structure.

**Usage:**
```bash
/workflow/init
```

**What it does:**
- Creates `docs/`, `docs/sessions/`, `docs/implementation-plans/` if needed
- Sets up session tracking
- Prepares checkpoint system
- Verifies git repository status

**When to use:**
- Starting a new feature or major change
- Beginning a complex bug fix
- Starting a refactoring project

---

### `/workflow/create-plan`

Generate a detailed implementation plan.

**Usage:**
```bash
/workflow/create-plan
```

**Interactive prompts:**
1. What do you want to build/fix?
2. Any specific requirements or constraints?
3. What does success look like?

**Output:**
Creates `docs/implementation-plans/YYYY-MM-DD-feature-name.md` with:
- Overview and goals
- Technical approach
- Step-by-step tasks
- Testing strategy
- Success criteria
- Potential challenges

**Example output structure:**
```markdown
# Implementation Plan: User Authentication

## Overview
Add JWT-based authentication system...

## Technical Approach
1. Backend API endpoints
2. Token generation/validation
3. Frontend integration
4. Security considerations

## Tasks
- [ ] Create User model
- [ ] Implement JWT token service
- [ ] Add login/logout endpoints
- [ ] Create authentication middleware
...

## Testing Strategy
- Unit tests for token service
- Integration tests for auth flow
- Security testing
```

---

### `/workflow/implement-plan`

Execute an implementation plan with progress tracking.

**Usage:**
```bash
/workflow/implement-plan docs/implementation-plans/my-plan.md
```

**What it does:**
- Reads the plan file
- Creates todos for each task
- Implements tasks systematically
- Runs tests after changes
- Updates plan with progress
- Creates checkpoints automatically

**Progress tracking:**
- Real-time todo list updates
- Automatic testing after each step
- Error handling and recovery
- Context-aware implementation

---

### `/workflow/validate-plan`

Verify a plan's completeness and feasibility before implementing.

**Usage:**
```bash
/workflow/validate-plan docs/implementation-plans/my-plan.md
```

**Checks for:**
- Clear, actionable tasks
- Proper test coverage
- Security considerations
- Edge cases handled
- Dependencies identified
- Realistic scope

**Example output:**
```
✅ Plan structure is clear and organized
✅ All tasks are actionable
⚠️  Consider adding error handling for API failures
❌ Missing unit tests for TokenService
✅ Security considerations documented
⚠️  Task 5 depends on Task 3 - ensure order

Recommendations:
1. Add unit tests for TokenService class
2. Add error handling task for network failures
3. Consider rate limiting for login attempts
```

---

### `/workflow/checkpoint`

Save current progress and context.

**Usage:**
```bash
/workflow/checkpoint
```

**What gets saved:**
- Current git status
- Active branch
- Todo list state
- Recent changes
- Context and notes
- Next steps

**Output:**
Creates `docs/sessions/YYYY-MM-DD-HHMM-checkpoint.md`

**Example checkpoint:**
```markdown
# Session Checkpoint - 2025-11-15 14:30

## Status
Branch: feature/user-auth
Phase: Implementation (60% complete)

## What's Done
- ✅ User model created
- ✅ JWT service implemented
- ✅ Login endpoint working

## What's Next
- [ ] Logout endpoint
- [ ] Token refresh
- [ ] Frontend integration

## Key Decisions
- Using bcrypt for password hashing
- 24-hour token expiration
- Refresh token in httpOnly cookie
```

---

### `/workflow/resume-work`

Resume from a saved checkpoint.

**Usage:**
```bash
/workflow/resume-work docs/sessions/2025-11-15-1430-checkpoint.md
```

**What it does:**
- Reads checkpoint file
- Restores context
- Shows what's completed
- Continues with next tasks
- Maintains continuity

**Perfect for:**
- Resuming after a break
- Context switching between projects
- Team handoffs
- Recovering from interruptions

## GitHub Integration

### `/github/setup-github-issues`

One-time setup for GitHub Issues integration.

**Usage:**
```bash
/github/setup-github-issues
```

**Setup steps:**
1. Verifies GitHub CLI (`gh`) is installed
2. Checks repository connection
3. Creates default labels if needed
4. Sets up issue templates
5. Configures workflow integration

**Labels created:**
- `bug` - Bug reports
- `feature` - New features
- `enhancement` - Improvements
- `documentation` - Documentation updates
- `priority:high` - High priority
- `priority:medium` - Medium priority
- `priority:low` - Low priority

**Only needs to be run once per repository.**

---

### `/github/start-from-issue`

Complete workflow from a GitHub issue.

**Usage:**
```bash
/github/start-from-issue 123
```

**Full workflow:**
1. Fetches issue #123 from GitHub
2. Analyzes requirements
3. Researches codebase (if needed)
4. Creates implementation plan
5. Creates feature branch
6. Implements the plan
7. Runs tests
8. Creates PR

**Example:**
```bash
# Issue #45: Add dark mode toggle

/github/start-from-issue 45
```

**Output:**
```
Fetching issue #45...
Title: Add dark mode toggle
Labels: feature, enhancement

Researching relevant code...
Found: ThemeContext.tsx, App.tsx, styles/

Creating implementation plan...
Plan saved: docs/implementation-plans/2025-11-15-dark-mode-toggle.md

Creating branch: feature/dark-mode-toggle-45

Implementing plan...
[Progress shown with todos]

Tests passing ✅
Ready to create PR!
```

---

### `/github/create-issue`

Interactive issue creation with templates.

**Usage:**
```bash
/github/create-issue
```

**Interactive prompts:**
1. Issue type: bug, feature, enhancement, documentation
2. Title
3. Description
4. Steps to reproduce (for bugs)
5. Expected behavior
6. Labels
7. Priority

**Example:**
```bash
/github/create-issue
```

```
Issue Type: feature
Title: Add user profile avatars
Description: Users should be able to upload and display profile avatars
Labels: feature, enhancement, priority:medium

Creating issue...
Issue created: #47
View at: https://github.com/user/repo/issues/47
```

---

### `/github/next-task`

Let Claude prioritize and suggest your next task.

**Usage:**
```bash
/github/next-task
```

**Prioritization factors:**
- Issue labels (priority:high, etc.)
- Dependencies between issues
- Current project context
- Issue age and activity
- Your recent work patterns

**Example output:**
```
Analyzing open issues...

Recommended: Issue #52 - Fix login redirect bug
Priority: High
Reason: Critical user flow, blocking 2 other issues
Estimated effort: 2-3 hours
Dependencies: None

Alternative tasks:
2. Issue #48 - Add loading states (Medium priority)
3. Issue #50 - Update docs (Low priority, good for end of day)

Start with: /github/start-from-issue 52
```

---

### `/github/describe-pr`

Auto-generate PR descriptions from commits.

**Usage:**
```bash
/github/describe-pr
```

**What it analyzes:**
- All commits since branch diverged from main
- Changed files
- Test coverage
- Breaking changes

**Generates:**
```markdown
## Summary
Implements user authentication with JWT tokens

## Changes
- Added User model with password hashing
- Created JWT token service
- Implemented login/logout endpoints
- Added authentication middleware
- Updated frontend with login form

## Testing
- Unit tests for TokenService
- Integration tests for auth flow
- Manual testing completed

## Breaking Changes
None

## Screenshots
[If applicable]
```

## Development Tools

### `/development/commit`

Create well-formatted, contextual commits.

**Usage:**
```bash
/development/commit
```

**What it does:**
1. Analyzes staged changes
2. Reads recent commits for style
3. Suggests commit message
4. You approve or modify
5. Creates commit

**Example:**
```bash
/development/commit
```

```
Analyzing changes...
Files changed:
- src/auth/TokenService.ts
- src/auth/middleware.ts
- tests/auth.test.ts

Suggested commit message:
feat: add JWT token service and auth middleware

Implements token generation, validation, and refresh logic.
Adds authentication middleware for protected routes.
Includes comprehensive unit tests.

[A]pprove, [E]dit, [C]ancel?
```

**Commit message format:**
```
<type>: <short description>

<detailed description>

<optional metadata>
```

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

---

### `/development/debug`

Systematic debugging assistance.

**Usage:**
```bash
/development/debug
```

**Debugging process:**
1. Describe the issue
2. Claude asks clarifying questions
3. Systematic investigation:
   - Review error messages
   - Check recent changes
   - Examine relevant code
   - Test hypotheses
4. Identify root cause
5. Propose fix
6. Implement and verify

**Example:**
```bash
/development/debug
```

```
What issue are you experiencing?
> Login endpoint returns 500 error

Let me investigate...

Checking error logs...
Found: TypeError: Cannot read property 'id' of undefined

Examining login endpoint...
Issue found in src/auth/controller.ts:42

Root cause: User lookup returns null when email not found,
but code assumes user exists.

Proposed fix:
Add null check before accessing user properties

Fix: [Shown as code diff]

Shall I implement this fix? [Y/n]
```

---

### `/development/local-review`

Pre-commit code review.

**Usage:**
```bash
/development/local-review
```

**Reviews for:**
- Code quality and style
- Potential bugs
- Security vulnerabilities
- Performance issues
- Test coverage
- Documentation
- Best practices

**Example output:**
```
Reviewing staged changes...

✅ src/auth/TokenService.ts
  - Clean implementation
  - Good error handling
  - Well tested

⚠️  src/auth/controller.ts:42
  - Consider adding rate limiting to login endpoint
  - Recommendation: Use express-rate-limit

❌ src/auth/middleware.ts:15
  - Security issue: JWT secret hardcoded
  - Fix: Move to environment variable

📝 tests/auth.test.ts
  - Missing test for token expiration
  - Add: Test case for expired tokens

Overall: 3 issues to address before committing
```

## Research & Analysis

### `/research/research-codebase`

Deep codebase exploration and analysis.

**Usage:**
```bash
/research/research-codebase
```

**Interactive prompts:**
1. What do you want to research?
2. Specific areas of interest?
3. Depth of analysis?

**What it does:**
1. Uses agent discovery system
2. Progressively loads relevant agents
3. Analyzes code patterns
4. Documents findings
5. Creates research report

**Example:**
```bash
/research/research-codebase
```

```
What would you like to research?
> Authentication and authorization patterns

Loading codebase agents...
Using: codebase-pattern-finder, codebase-analyzer

Analyzing authentication patterns...

Found:
1. JWT-based authentication in src/auth/
2. Role-based access control in src/middleware/
3. OAuth integration in src/oauth/

Authentication Flow:
[Detailed explanation with code references]

Security Considerations:
- Token storage: httpOnly cookies ✅
- CSRF protection: Implemented ✅
- Rate limiting: Missing ⚠️

Recommendations:
1. Add rate limiting to auth endpoints
2. Consider refresh token rotation
3. Add audit logging for auth events

Research report saved to: docs/research/2025-11-15-auth-patterns.md
```

## Common Workflows

### Workflow 1: Bug Fix from Issue

```bash
# 1. Start from the bug report
/github/start-from-issue 89

# Claude fetches issue, researches code, creates plan

# 2. Review and approve plan

# 3. Implementation happens automatically

# 4. Debug if needed
/development/debug

# 5. Local review before commit
/development/local-review

# 6. Create commit
/development/commit

# 7. Create PR
/github/describe-pr
```

### Workflow 2: New Feature Development

```bash
# 1. Initialize workflow
/workflow/init

# 2. Create detailed plan
/workflow/create-plan

# 3. Validate plan
/workflow/validate-plan docs/implementation-plans/my-plan.md

# 4. Implement
/workflow/implement-plan docs/implementation-plans/my-plan.md

# 5. Save checkpoints during work
/workflow/checkpoint  # Every 30-60 minutes

# 6. Review before commit
/development/local-review

# 7. Commit changes
/development/commit
```

### Workflow 3: Research Then Build

```bash
# 1. Research existing patterns
/research/research-codebase

# 2. Create plan based on research
/workflow/create-plan

# 3. Validate against findings
/workflow/validate-plan docs/implementation-plans/my-plan.md

# 4. Implement
/workflow/implement-plan docs/implementation-plans/my-plan.md
```

### Workflow 4: Team Collaboration

**Developer A (morning):**
```bash
/workflow/init
/workflow/create-plan
/workflow/implement-plan docs/implementation-plans/my-plan.md
# Work for 2 hours...
/workflow/checkpoint
```

**Developer B (afternoon):**
```bash
/workflow/resume-work docs/sessions/2025-11-15-1000-checkpoint.md
# Continue work...
/workflow/checkpoint
```

### Workflow 5: Interrupt and Resume

```bash
# Working on feature...
/workflow/implement-plan docs/implementation-plans/feature-x.md

# Urgent bug needs fixing!
/workflow/checkpoint  # Save current work

/github/start-from-issue 99  # Fix urgent bug
# ... fix deployed ...

# Back to feature
/workflow/resume-work docs/sessions/2025-11-15-1430-checkpoint.md
```

## Best Practices

### Workflow Management

**Checkpoint frequently:**
```bash
# Good: Checkpoint every 30-60 minutes
/workflow/checkpoint

# Good: Before context switching
/workflow/checkpoint

# Good: Before taking a break
/workflow/checkpoint
```

**Validate plans before implementing:**
```bash
# Create plan
/workflow/create-plan

# ALWAYS validate
/workflow/validate-plan docs/implementation-plans/my-plan.md

# Fix any issues found

# Then implement
/workflow/implement-plan docs/implementation-plans/my-plan.md
```

### GitHub Integration

**Set up once per repo:**
```bash
# First time in a repository
/github/setup-github-issues

# Never need to run again for this repo
```

**Let GitHub drive your work:**
```bash
# Don't decide what to work on manually
# Let Claude prioritize
/github/next-task

# Then start the suggested issue
/github/start-from-issue <issue-number>
```

### Code Quality

**Review before committing:**
```bash
# Stage your changes
git add .

# ALWAYS review first
/development/local-review

# Fix any issues found

# Then commit
/development/commit
```

**Use smart commits:**
```bash
# Don't manually write commit messages
# Let Claude analyze and suggest
/development/commit

# Claude understands:
# - What changed
# - Why it changed
# - How to format it
```

### Research

**Research before major changes:**
```bash
# Before refactoring
/research/research-codebase

# Before adding major features
/research/research-codebase

# Before changing architecture
/research/research-codebase
```

**Trust the agent system:**
```bash
# Don't manually grep/find
# The agent system is more efficient
/research/research-codebase

# Benefits:
# - 40-60% less context usage
# - More focused results
# - Better insights
```

## Advanced Tips

### Custom Configurations

Create `.claude-plugin-config.json` in your project:

```json
{
  "directories": {
    "docs": "documentation",
    "thoughts": "documentation/notes",
    "sessions": "documentation/sessions",
    "plans": "documentation/plans"
  },
  "github": {
    "issueLabels": ["bug", "feature", "tech-debt"],
    "defaultBranch": "develop"
  }
}
```

### Combining Commands

```bash
# Create and validate in one flow
/workflow/create-plan && /workflow/validate-plan docs/implementation-plans/latest.md

# Research, plan, implement
/research/research-codebase
/workflow/create-plan
/workflow/implement-plan docs/implementation-plans/my-plan.md
```

### Keyboard Shortcuts

Use shell aliases for common workflows:

```bash
# Add to ~/.bashrc or ~/.zshrc
alias cw-start="/workflow/init && /workflow/create-plan"
alias cw-save="/workflow/checkpoint"
alias cw-review="/development/local-review && /development/commit"
```

## Troubleshooting

### Command not found

```bash
# Check plugin is installed
ls ~/.claude-plugins/claude-workflow-pro

# Restart Claude Code
```

### GitHub commands failing

```bash
# Install GitHub CLI
brew install gh  # macOS
# or download from https://cli.github.com

# Authenticate
gh auth login

# Verify
gh repo view
```

### Plan file not found

```bash
# Check default plans directory
ls docs/implementation-plans/

# Or specify full path
/workflow/implement-plan /full/path/to/plan.md
```

### Checkpoint not saving

```bash
# Ensure sessions directory exists
mkdir -p docs/sessions

# Check permissions
ls -la docs/

# Try manual checkpoint
/workflow/checkpoint
```

## Getting Help

- Command reference: See README.md
- Configuration: See CONFIGURATION.md
- Issues: https://github.com/yourusername/claude-workflow-pro/issues

---

**Happy coding with Claude Workflow Pro!**

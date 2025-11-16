# Frequently Asked Questions (FAQ)

## Table of Contents

- [Getting Started](#getting-started)
- [Installation & Setup](#installation--setup)
- [Using Workflows](#using-workflows)
- [Using Agents](#using-agents)
- [GitHub Integration](#github-integration)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)
- [Advanced Usage](#advanced-usage)
- [Contributing](#contributing)
- [Performance & Limits](#performance--limits)
- [Security & Privacy](#security--privacy)

---

## Getting Started

### What is Claude Workflow Pro?

Claude Workflow Pro is a comprehensive plugin for Claude Code (Anthropic's official CLI) that provides AI-powered workflow management, GitHub integration, specialized agents, and development tools. It helps developers work more efficiently by automating common tasks, managing complex workflows, and providing intelligent code analysis.

### Who is this plugin for?

- **Individual developers** who want to streamline their development workflow
- **Teams** looking to standardize development processes
- **Open source maintainers** managing multiple projects
- **Agencies** handling multiple client projects
- **Anyone** who wants to leverage AI for development tasks

### What are the main features?

1. **Workflow Management** - Plan, validate, implement, and track development work
2. **GitHub Integration** - Seamless PR reviews, issue management, and automation
3. **Specialized Agents** - 11 AI agents for specific tasks (architecture, security, debugging, etc.)
4. **Development Tools** - Code review, refactoring, documentation generation
5. **Research & Analysis** - Codebase exploration and technology research

### How much does it cost?

The plugin itself is **completely free and open source**. However, you need:
- **Claude Code** (Anthropic's CLI) - Check Anthropic's pricing
- **GitHub account** (for GitHub features) - Free tier available
- **Git** (free and open source)

### How is this different from using Claude Code directly?

Claude Workflow Pro adds:
- **Structured workflows** vs. ad-hoc conversations
- **Specialized agents** vs. general-purpose assistance
- **GitHub automation** vs. manual GitHub operations
- **Best practices built-in** vs. starting from scratch
- **Consistency** across projects and team members

---

## Installation & Setup

### How do I install the plugin?

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/claude-workflow-pro.git
   cd claude-workflow-pro
   ```

2. **Copy to Claude Code plugins directory:**
   ```bash
   cp -r . ~/.config/claude-code/plugins/claude-workflow-pro
   ```

3. **Configure (optional):**
   ```bash
   cp .claude-plugin-config.example.json .claude-plugin-config.json
   # Edit configuration as needed
   ```

4. **Verify installation:**
   ```bash
   claude-code
   /workflow/init
   ```

### Where should I install the plugin?

Install it in Claude Code's plugins directory:
- **Linux/macOS:** `~/.config/claude-code/plugins/claude-workflow-pro`
- **Windows:** `%APPDATA%\claude-code\plugins\claude-workflow-pro`

### Do I need any prerequisites?

**Required:**
- Claude Code installed and configured
- Git (version 2.0 or higher)
- Node.js (for running tests, optional)

**Recommended:**
- GitHub account (for GitHub features)
- Git configured with your name and email
- SSH keys set up for GitHub (for push operations)

### How do I configure the plugin?

1. **Copy the example config:**
   ```bash
   cp .claude-plugin-config.example.json .claude-plugin-config.json
   ```

2. **Edit settings:**
   ```json
   {
     "defaultBranch": "main",
     "autoValidate": true,
     "githubIntegration": true,
     "agentSettings": {
       "maxRetries": 3,
       "timeout": 300
     }
   }
   ```

3. **Project-specific settings:**
   Copy to your project root or use `.claude-settings.json`

### Can I use this without GitHub?

**Yes!** GitHub features are optional. You can use:
- ✅ Workflow management (planning, validation, implementation)
- ✅ Agents (all 11 specialized agents)
- ✅ Development tools (refactoring, documentation)
- ✅ Research capabilities
- ❌ GitHub PR reviews (requires GitHub)
- ❌ GitHub issue management (requires GitHub)

---

## Using Workflows

### What is a workflow?

A workflow is a structured approach to development tasks:
1. **Plan** - Create a detailed implementation plan
2. **Validate** - Review and approve the plan
3. **Implement** - Execute the plan step-by-step
4. **Checkpoint** - Save progress for later
5. **Resume** - Continue from where you left off

### How do I start a new workflow?

```bash
# Initialize workflow system
/workflow/init

# Create a plan for your task
/workflow/create-plan "Add user authentication system"

# Validate the plan
/workflow/validate-plan

# Implement the plan
/workflow/implement-plan

# Save progress
/workflow/checkpoint "auth-phase-1-complete"

# Resume later
/workflow/resume-work @checkpoint-file.md
```

### When should I use workflows vs. regular commands?

**Use workflows for:**
- Complex features (multi-file changes)
- Large refactorings
- New feature development
- Bug fixes requiring investigation
- Tasks requiring multiple steps

**Use regular commands for:**
- Quick one-off tasks
- Simple file edits
- Documentation updates
- Code reviews
- Research questions

### Can I customize the workflow process?

**Yes!** Workflows are flexible:
- **Skip steps** - Jump directly to implementation if you have a clear plan
- **Iterate** - Refine plans multiple times before implementing
- **Pause/Resume** - Work in chunks with checkpoints
- **Adapt** - Modify plans as you discover new requirements

### How do checkpoints work?

Checkpoints save your current state:
- **What's saved:** Current plan, progress, context, decisions made
- **File format:** Markdown files in `docs/sessions/`
- **Resuming:** Use `/workflow/resume-work @checkpoint-file.md`
- **Use cases:** End of day, before meetings, after major milestones

### What if I need to change the plan mid-implementation?

No problem! You can:
1. **Update the plan** - Edit the plan file directly
2. **Re-validate** - Run `/workflow/validate-plan` again
3. **Continue** - Implementation will use the updated plan
4. **Document changes** - Add notes about why the plan changed

---

## Using Agents

### What are agents?

Agents are specialized AI assistants focused on specific tasks:
- **Architecture Agent** - System design and patterns
- **Security Agent** - Security analysis and hardening
- **Performance Agent** - Optimization and profiling
- **Testing Agent** - Test generation and coverage
- **Documentation Agent** - Doc generation and improvement
- **Refactoring Agent** - Code quality improvements
- **Debugging Agent** - Issue investigation and fixes
- **API Design Agent** - API architecture and design
- **Database Agent** - Schema design and migrations
- **DevOps Agent** - CI/CD and deployment
- **Code Review Agent** - Detailed code reviews

### How do I use an agent?

```bash
# Explore available agents
/research/explore-agents

# Use a specific agent
/research/architecture "Design a microservices architecture"
/research/security "Review authentication system for vulnerabilities"
/research/performance "Optimize database queries in UserService"
```

### When should I use an agent vs. a regular command?

**Use agents when:**
- You need specialized expertise (security, performance, etc.)
- The task is complex and domain-specific
- You want thorough analysis
- You need best practices guidance

**Use regular commands when:**
- Task is straightforward
- You know exactly what to do
- Speed is more important than depth
- Task doesn't fit a specific domain

### Can agents work together?

**Yes!** Common patterns:
1. **Architecture → Implementation** - Design first, then build
2. **Security → Testing** - Find issues, write tests to prevent
3. **Performance → Refactoring** - Identify bottlenecks, optimize
4. **Documentation → Review** - Generate docs, review quality

Example:
```bash
# Design the system
/research/architecture "Design caching layer"

# Review for security
/research/security "Review caching design for security issues"

# Implement
/workflow/create-plan "Implement secure caching layer"
```

### How do I know which agent to use?

**Quick reference:**
- **System design?** → Architecture Agent
- **Security concerns?** → Security Agent
- **Slow performance?** → Performance Agent
- **Need tests?** → Testing Agent
- **Missing docs?** → Documentation Agent
- **Code smells?** → Refactoring Agent
- **Bug hunting?** → Debugging Agent
- **API design?** → API Design Agent
- **Database work?** → Database Agent
- **Deployment issues?** → DevOps Agent
- **Code review?** → Code Review Agent

### Can I create custom agents?

**Yes!** Create a new file in `agents/`:
```bash
# agents/my-custom-agent.md
You are a specialized agent for [YOUR DOMAIN].

Your responsibilities:
1. [Task 1]
2. [Task 2]

When analyzing code, you should:
- [Guideline 1]
- [Guideline 2]

Output format:
[Specify the format]
```

Then use it:
```bash
/research/my-custom-agent "Your task description"
```

---

## GitHub Integration

### How do I set up GitHub integration?

1. **Authenticate with GitHub:**
   ```bash
   gh auth login
   ```

2. **Configure the plugin:**
   ```json
   {
     "githubIntegration": true,
     "defaultBranch": "main"
   }
   ```

3. **Test it:**
   ```bash
   /github/review-pr 123
   ```

### Do I need the GitHub CLI (gh)?

**Yes**, for GitHub features. Install it:
- **macOS:** `brew install gh`
- **Linux:** `sudo apt install gh` or download from [GitHub CLI](https://cli.github.com)
- **Windows:** `winget install gh` or download installer

### Can I review PRs from the command line?

**Absolutely!** That's one of the best features:
```bash
# Review a specific PR
/github/review-pr 123

# Review with focus area
/github/review-pr 123 --focus security

# Review multiple files
/github/review-pr 123 --files "src/**/*.ts"
```

The agent will:
- Fetch the PR details
- Analyze all changes
- Check for issues (bugs, security, performance)
- Suggest improvements
- Generate review comments

### How do I manage issues?

```bash
# List open issues
/github/list-issues

# Create a new issue
/github/create-issue "Bug: Login fails with invalid credentials"

# Update an issue
/github/update-issue 456 --status "in-progress"

# Close an issue
/github/close-issue 456
```

### Can I automate PR creation?

**Yes!** Use the workflow system:
```bash
# Make your changes
git add .

# Create PR with AI-generated description
/github/create-pr "Add user authentication"

# The agent will:
# 1. Analyze your changes
# 2. Generate a comprehensive PR description
# 3. Create the PR on GitHub
# 4. Return the PR URL
```

### How do I handle GitHub Actions failures?

```bash
# Check workflow status
/github/check-workflows

# If failures are detected, the agent will:
# 1. Show which workflows failed
# 2. Display error messages
# 3. Suggest fixes
# 4. Offer to create a fix
```

---

## Configuration

### What can I configure?

**Plugin Settings** (`.claude-plugin-config.json`):
- Default branch name
- Auto-validation settings
- GitHub integration toggles
- Agent behavior
- Output preferences

**Project Settings** (`.claude-settings.json`):
- Project-specific overrides
- Custom workflows
- Team conventions
- Path mappings

**Git Settings** (`.git/config`):
- Remote repositories
- Branch tracking
- User information

### Where do configuration files go?

**Global plugin config:**
- Location: `~/.config/claude-code/plugins/claude-workflow-pro/`
- File: `.claude-plugin-config.json`
- Applies to: All projects

**Project-specific config:**
- Location: Your project root
- File: `.claude-settings.json`
- Applies to: Current project only

### What are the most important settings?

```json
{
  // Which branch to use as the base
  "defaultBranch": "main",

  // Automatically validate plans before implementing
  "autoValidate": true,

  // Enable/disable GitHub features
  "githubIntegration": true,

  // Agent timeout in seconds
  "agentSettings": {
    "timeout": 300,
    "maxRetries": 3
  },

  // Output verbosity
  "verboseLogging": false
}
```

### Can I use environment variables?

**Yes!** The plugin respects:
- `GITHUB_TOKEN` - GitHub API authentication
- `CLAUDE_CODE_CONFIG` - Override config file location
- `GIT_EDITOR` - Editor for interactive operations
- `NODE_ENV` - Affects testing and validation

### How do I share configuration with my team?

1. **Create a template:**
   ```bash
   cp .claude-plugin-config.json .claude-plugin-config.example.json
   ```

2. **Remove sensitive data:**
   Remove any tokens, personal paths, etc.

3. **Commit the example:**
   ```bash
   git add .claude-plugin-config.example.json
   git commit -m "docs: add plugin config template"
   ```

4. **Document in README:**
   Add setup instructions for team members

---

## Troubleshooting

### The plugin commands aren't showing up

**Possible causes:**
1. Plugin not installed in the correct directory
2. Claude Code needs to be restarted
3. Plugin files have incorrect permissions

**Solutions:**
```bash
# Check installation location
ls -la ~/.config/claude-code/plugins/claude-workflow-pro

# Fix permissions
chmod -R 755 ~/.config/claude-code/plugins/claude-workflow-pro

# Restart Claude Code
# Exit and start a new session
```

### Commands fail with "command not found"

**Check:**
1. Is Claude Code running?
2. Is the plugin properly installed?
3. Are you in a valid project directory?

**Debug:**
```bash
# List available commands
/help

# Check plugin status
# Should see claude-workflow-pro in the list
```

### GitHub commands fail

**Common issues:**

1. **Not authenticated:**
   ```bash
   gh auth login
   gh auth status  # Verify
   ```

2. **No remote configured:**
   ```bash
   git remote -v  # Check remotes
   git remote add origin <url>  # Add if missing
   ```

3. **Insufficient permissions:**
   - Check your GitHub token scopes
   - Need: `repo`, `workflow`, `write:discussion`

### Agents are slow or timing out

**Causes:**
- Large codebase
- Complex analysis
- Network issues
- Token limits

**Solutions:**
1. **Increase timeout:**
   ```json
   {
     "agentSettings": {
       "timeout": 600  // 10 minutes
     }
   }
   ```

2. **Scope the request:**
   ```bash
   # Instead of analyzing everything:
   /research/security "Review auth system"

   # Scope to specific files:
   /research/security "Review src/auth/*.ts for vulnerabilities"
   ```

3. **Use focused agents:**
   More specific = faster results

### Plans fail validation

**Common issues:**

1. **Too vague:**
   - Add more detail
   - Specify files to modify
   - List specific changes

2. **Missing context:**
   - Reference existing code
   - Explain why changes are needed
   - Include technical details

3. **Unrealistic scope:**
   - Break into smaller plans
   - Focus on one feature at a time
   - Use checkpoints for large tasks

**Fix:**
Edit the plan file directly, then re-validate:
```bash
# Edit the plan
vim docs/plans/your-plan.md

# Validate again
/workflow/validate-plan
```

### Changes aren't being committed

**Check:**
1. **Git configured?**
   ```bash
   git config user.name
   git config user.email
   ```

2. **Files staged?**
   ```bash
   git status  # Check what's staged
   git add .   # Stage if needed
   ```

3. **Pre-commit hooks failing?**
   ```bash
   # Check hooks
   ls -la .git/hooks/

   # Temporarily bypass (not recommended)
   git commit --no-verify
   ```

### Out of context/token errors

**When it happens:**
- Very large files
- Complex analysis
- Long sessions

**Solutions:**
1. **Start fresh session:**
   - Save checkpoint first
   - Exit Claude Code
   - Start new session
   - Resume from checkpoint

2. **Reduce scope:**
   - Work on smaller pieces
   - Use focused commands
   - Analyze specific files only

3. **Use agents efficiently:**
   - One task per agent call
   - Clear, specific requests
   - Avoid "analyze everything"

---

## Best Practices

### How should I structure my workflow?

**Recommended approach:**

1. **Start with research:**
   ```bash
   /research/explore-agents  # Understand what's available
   ```

2. **Plan your work:**
   ```bash
   /workflow/create-plan "Your feature or fix"
   ```

3. **Validate before building:**
   ```bash
   /workflow/validate-plan
   ```

4. **Implement in chunks:**
   ```bash
   /workflow/implement-plan
   /workflow/checkpoint "phase-1-complete"
   ```

5. **Review and test:**
   ```bash
   /development/code-review
   /development/run-tests
   ```

6. **Create PR:**
   ```bash
   /github/create-pr "Descriptive title"
   ```

### When should I create checkpoints?

**Create checkpoints:**
- ✅ End of work session
- ✅ After completing a major phase
- ✅ Before trying something risky
- ✅ When switching contexts
- ✅ After significant progress

**Checkpoint naming:**
```bash
# Good names (descriptive, dated)
/workflow/checkpoint "2025-01-15-auth-phase1-complete"
/workflow/checkpoint "user-model-implemented"
/workflow/checkpoint "before-database-migration"

# Avoid (vague)
/workflow/checkpoint "checkpoint1"
/workflow/checkpoint "backup"
```

### How do I use agents effectively?

**Do:**
- ✅ Be specific in your requests
- ✅ Provide context (files, functions, issues)
- ✅ Use the right agent for the task
- ✅ Chain agents for complex tasks
- ✅ Review agent output critically

**Don't:**
- ❌ Ask agents to do everything
- ❌ Use vague requests ("make it better")
- ❌ Ignore agent recommendations
- ❌ Skip validation steps
- ❌ Over-rely on automation

**Examples:**

**Good:**
```bash
/research/security "Review UserController.ts authentication logic for injection vulnerabilities"
```

**Too vague:**
```bash
/research/security "Check security"
```

### What's the best way to handle large refactorings?

**Strategy:**

1. **Plan in phases:**
   ```bash
   /workflow/create-plan "Phase 1: Extract utilities"
   ```

2. **Use checkpoints:**
   ```bash
   /workflow/checkpoint "phase1-utilities-extracted"
   ```

3. **Test between phases:**
   ```bash
   /development/run-tests
   ```

4. **Keep commits small:**
   - One phase = one commit
   - Easy to review
   - Easy to revert if needed

5. **Document changes:**
   - Update docs as you go
   - Add migration guides if needed
   - Note breaking changes

### How should teams use this plugin?

**Team workflow:**

1. **Standardize configuration:**
   - Share `.claude-plugin-config.example.json`
   - Document team conventions
   - Use consistent commands

2. **Use workflows for features:**
   - Every feature gets a plan
   - Plans reviewed by team
   - Checkpoints shared in PR descriptions

3. **Leverage agents for reviews:**
   ```bash
   # Before requesting human review:
   /development/code-review
   /research/security "Review my changes"
   ```

4. **Automate common tasks:**
   - PR descriptions (auto-generated)
   - Issue creation (templated)
   - Code reviews (AI first, human second)

5. **Share knowledge:**
   - Document custom agents
   - Share useful workflows
   - Build team command library

---

## Advanced Usage

### Can I chain multiple commands?

**Yes!** Use command sequences:
```bash
# Review → Test → Create PR
/development/code-review && \
/development/run-tests && \
/github/create-pr "Fix authentication bug"
```

Or in a workflow:
```bash
/workflow/create-plan "Add feature with full cycle"
# Plan includes: implement → test → review → deploy
```

### How do I customize agent behavior?

**Edit agent files:**
```bash
# Example: Make security agent more strict
vim ~/.config/claude-code/plugins/claude-workflow-pro/agents/security-agent.md
```

**Add to agent prompt:**
```markdown
## Custom Rules for Our Project

- Always check for SQL injection in raw queries
- Verify authentication on all API endpoints
- Require input validation for user-provided data
- Flag any use of `eval()` or `Function()`
```

### Can I integrate with CI/CD?

**Yes!** Example workflows:

**GitHub Actions:**
```yaml
name: AI Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: AI Review
        run: |
          claude-code /development/code-review
```

**Pre-commit hooks:**
```bash
# .git/hooks/pre-commit
#!/bin/bash
claude-code /research/security "Quick security check"
```

### How do I handle multiple projects?

**Options:**

1. **Project-specific configs:**
   ```bash
   # project1/.claude-settings.json
   {
     "defaultBranch": "main",
     "customAgents": ["project1-specific-agent"]
   }

   # project2/.claude-settings.json
   {
     "defaultBranch": "develop",
     "customAgents": ["project2-specific-agent"]
   }
   ```

2. **Use checkpoints:**
   ```bash
   # Save context when switching
   /workflow/checkpoint "project1-paused"

   # Switch to project2
   cd ../project2
   /workflow/resume-work @project2-checkpoint.md
   ```

3. **Separate Claude Code sessions:**
   - One terminal per project
   - Each with own context
   - Switch between as needed

### Can I export workflow data?

**Yes!** Workflows create markdown files:
```bash
# Plans
docs/plans/*.md

# Checkpoints
docs/sessions/*.md

# These can be:
- Committed to git
- Shared with team
- Used in documentation
- Imported to other tools
```

### How do I debug plugin issues?

**Enable verbose logging:**
```json
{
  "verboseLogging": true,
  "debugMode": true
}
```

**Check logs:**
```bash
# Claude Code logs
tail -f ~/.config/claude-code/logs/

# Plugin-specific logs
tail -f ~/.config/claude-code/plugins/claude-workflow-pro/logs/
```

**Test individual components:**
```bash
# Test agent directly
cat agents/security-agent.md | claude-code

# Test command files
cat commands/workflow/create-plan.md
```

---

## Contributing

### How can I contribute?

**Ways to contribute:**
1. **Report bugs** - Open issues on GitHub
2. **Suggest features** - Use GitHub Discussions
3. **Submit PRs** - Fix bugs or add features
4. **Improve docs** - Help others learn
5. **Share examples** - Show how you use it
6. **Create agents** - Build specialized agents

### How do I report a bug?

**Use the issue template:**
```bash
/github/create-issue "Bug: Description of the problem"
```

**Include:**
- What you expected
- What actually happened
- Steps to reproduce
- Claude Code version
- Plugin version
- Operating system

### How do I suggest a feature?

**Use GitHub Discussions:**
1. Go to the repository Discussions tab
2. Select "Ideas" category
3. Describe your feature
4. Explain the use case
5. Provide examples if possible

Or use the command:
```bash
/github/create-issue "Feature: Your feature request"
```

### What's the PR process?

1. **Fork the repository**
2. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
4. **Test thoroughly:**
   ```bash
   npm test  # Run all tests
   ```

5. **Use the plugin to create PR:**
   ```bash
   /github/create-pr "Add your feature"
   ```

6. **Respond to review feedback**

### Are there coding standards?

**Yes:**
- Follow existing code style
- Add tests for new features
- Update documentation
- Keep commits atomic
- Write clear commit messages

**Before submitting:**
```bash
# Run code review
/development/code-review

# Run all tests
/development/run-tests

# Check documentation
/research/documentation "Review my changes"
```

---

## Performance & Limits

### How fast are the commands?

**Typical response times:**
- Simple commands: < 5 seconds
- Agent analysis: 10-30 seconds
- Complex workflows: 1-5 minutes
- GitHub operations: 5-15 seconds

**Factors affecting speed:**
- Codebase size
- Request complexity
- Network latency
- Claude API response time

### Are there rate limits?

**Claude API limits:**
- Depends on your Claude Code plan
- Check Anthropic's current limits

**GitHub API limits:**
- 5,000 requests/hour (authenticated)
- 60 requests/hour (unauthenticated)

**Plugin limits:**
- No artificial limits imposed
- Respects API provider limits

### How much does this cost to run?

**Costs:**
- Plugin itself: **Free**
- Claude Code: Check Anthropic pricing
- GitHub: Free for public repos, paid for private
- Network: Negligible

**Cost optimization:**
- Use specific requests (less tokens)
- Scope agent analysis
- Leverage checkpoints (resume vs. restart)
- Cache when possible

### Can I use this on large codebases?

**Yes, but:**
- Focus agent analysis on specific areas
- Use file/directory scoping
- Break work into smaller chunks
- Use checkpoints frequently

**Example:**
```bash
# Instead of:
/research/security "Review entire codebase"

# Do:
/research/security "Review src/auth/*.ts"
/research/security "Review src/api/*.ts"
# etc.
```

---

## Security & Privacy

### Is my code sent to Anthropic?

**Yes**, when using Claude Code:
- Code is sent for analysis
- Follows Anthropic's privacy policy
- Subject to their data handling practices

**See:** [Anthropic's Privacy Policy](https://www.anthropic.com/privacy)

### Does the plugin collect data?

**No**, this plugin:
- ❌ Does not collect analytics
- ❌ Does not send data anywhere except Claude API
- ❌ Does not track usage
- ❌ Does not store credentials

**What it does:**
- ✅ Creates local files (plans, checkpoints)
- ✅ Reads your code (sent to Claude API)
- ✅ Calls GitHub API (with your token)

### How are GitHub tokens handled?

**Tokens:**
- Stored by GitHub CLI (`gh`)
- Not accessed by this plugin directly
- Used via `gh` commands
- Follow GitHub's security practices

**Best practices:**
- Use tokens with minimal necessary scopes
- Rotate tokens regularly
- Never commit tokens to git
- Use environment variables

### Can I use this in a secure/private environment?

**Considerations:**
1. **Air-gapped:** No - requires API access
2. **Private repos:** Yes - but code sent to Claude API
3. **Sensitive data:** Review Anthropic's policies
4. **Compliance:** Check your organization's policies

**For sensitive environments:**
- Review what's sent to API
- Consider self-hosted alternatives
- Use git ignore for sensitive files
- Audit usage patterns

### What should I not commit?

**Never commit:**
- ❌ `.claude-plugin-config.json` (if it has tokens)
- ❌ API keys or secrets
- ❌ Personal credentials
- ❌ Private tokens

**Safe to commit:**
- ✅ `.claude-plugin-config.example.json`
- ✅ Plan files (docs/plans/)
- ✅ Checkpoint files (docs/sessions/)
- ✅ Custom agents
- ✅ Documentation

**Add to .gitignore:**
```
.claude-plugin-config.json
.claude-settings.json
**/checkpoints/*.private.md
```

---

## Still Have Questions?

### Where can I get help?

1. **GitHub Discussions** - Community Q&A
2. **GitHub Issues** - Bug reports
3. **Documentation** - Check docs/ directory
4. **Examples** - See examples/ directory
5. **Claude Code Docs** - Anthropic's official docs

### How do I stay updated?

- ⭐ Star the repository
- 👀 Watch for releases
- 📢 Follow announcements
- 📖 Read the CHANGELOG
- 💬 Join GitHub Discussions

### What if my question isn't answered here?

**Ask in GitHub Discussions:**
1. Go to repository Discussions
2. Select "Q&A" category
3. Search for similar questions
4. Ask if not found

**Or open an issue:**
```bash
/github/create-issue "Question: Your question here"
```

---

**Last updated:** 2025-01-15
**Plugin version:** 1.0.0
**Maintained by:** Claude Workflow Pro Team

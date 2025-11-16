# Contributor Guide

Welcome to the Claude Workflow Pro contributor community! This guide will help you get started contributing to the project, whether you're fixing a bug, adding a feature, improving documentation, or creating a new agent.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Understanding the Codebase](#understanding-the-codebase)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Documentation](#documentation)
- [Submitting Changes](#submitting-changes)
- [Code Review Process](#code-review-process)
- [Community Guidelines](#community-guidelines)
- [Recognition](#recognition)

---

## Getting Started

### First Time Contributing?

Welcome! Here's what you need to know:

1. **Read the Code of Conduct** - Be respectful and inclusive
2. **Check existing issues** - Someone might already be working on it
3. **Start small** - Fix typos, improve docs, add tests
4. **Ask questions** - Use GitHub Discussions

### What Can I Contribute?

**Code Contributions:**
- 🐛 Bug fixes
- ✨ New features
- 🚀 Performance improvements
- ♻️ Refactoring
- 🧪 Tests

**Non-Code Contributions:**
- 📝 Documentation improvements
- 🎨 Example projects
- 🤖 New agents
- 🌍 Translations (future)
- 💬 Answering questions
- 📢 Sharing the project

### Finding Something to Work On

**Good first issues:**
- Look for `good-first-issue` label
- Documentation improvements
- Test coverage increases
- Example projects

**Help wanted:**
- Look for `help-wanted` label
- More complex issues
- Feature requests
- Performance improvements

**Create your own:**
- Found a bug? Report and fix it!
- Have an idea? Discuss it first
- Missing docs? Add them!

---

## Development Setup

### Prerequisites

**Required:**
- Git (2.0+)
- Node.js (16+) for running tests
- Claude Code installed
- Text editor or IDE

**Recommended:**
- GitHub CLI (`gh`)
- Unix-like environment (Linux, macOS, WSL)

### Installation

**1. Fork the repository:**
```bash
# On GitHub, click "Fork" button
```

**2. Clone your fork:**
```bash
git clone https://github.com/YOUR-USERNAME/claude-workflow-pro.git
cd claude-workflow-pro
```

**3. Add upstream remote:**
```bash
git remote add upstream https://github.com/ORIGINAL-OWNER/claude-workflow-pro.git
```

**4. Install in Claude Code:**
```bash
# Create symlink for development
ln -s $(pwd) ~/.config/claude-code/plugins/claude-workflow-pro-dev
```

**5. Install dependencies (for testing):**
```bash
npm install
```

**6. Verify setup:**
```bash
# Run tests
npm test

# Try a command
claude-code
/workflow/init
```

### Development Environment

**Recommended setup:**

**Editor:** VS Code, Vim, Emacs, or your preference

**VS Code extensions:**
- Markdown All in One
- markdownlint
- GitLens
- Code Spell Checker

**Terminal setup:**
```bash
# Keep two terminals open:
# Terminal 1: Your editor
# Terminal 2: Claude Code for testing
```

### Keeping Your Fork Updated

**Sync regularly:**
```bash
# Fetch upstream changes
git fetch upstream

# Merge into your main branch
git checkout main
git merge upstream/main

# Push to your fork
git push origin main
```

---

## Understanding the Codebase

### Project Structure

```
claude-workflow-pro/
├── commands/              # Slash commands
│   ├── workflow/         # Workflow management commands
│   ├── github/           # GitHub integration commands
│   ├── development/      # Development tools
│   └── research/         # Research and analysis
├── agents/               # Specialized AI agents
│   ├── architecture-agent.md
│   ├── security-agent.md
│   └── ...
├── docs/                 # Documentation
│   ├── plans/           # Implementation plans
│   └── sessions/        # Checkpoint files
├── examples/            # Example projects
│   ├── basic-project/
│   ├── web-app/
│   └── api-service/
├── tests/               # Test suite
│   ├── unit/
│   └── integration/
├── .github/             # GitHub templates and workflows
├── README.md            # Main documentation
├── CHANGELOG.md         # Version history
└── CONTRIBUTING.md      # This file

### Key Concepts

**Commands:**
- Located in `commands/` directory
- Markdown files with prompts
- Invoked via `/command-name`
- Structure:
  ```markdown
  # Command Title

  Command description and instructions...

  ## Usage
  Examples...
  ```

**Agents:**
- Located in `agents/` directory
- Specialized AI assistants
- Focused on specific domains
- Structure:
  ```markdown
  # Agent Name

  You are a specialized agent for [DOMAIN].

  Your responsibilities:
  - ...

  When analyzing:
  - ...
  ```

**Workflows:**
- Plan → Validate → Implement → Checkpoint
- Plans stored in `docs/plans/`
- Checkpoints in `docs/sessions/`
- Stateful and resumable

**Tests:**
- Unit tests for individual components
- Integration tests for workflows
- Validation tests for commands/agents
- All must pass before merging

### Code Organization

**Commands by category:**
- `workflow/*` - Plan, validate, implement, checkpoint, resume
- `github/*` - PR review, issue management, automation
- `development/*` - Code review, refactoring, documentation
- `research/*` - Agent exploration, technology research

**Agents by domain:**
- Architecture, Security, Performance
- Testing, Documentation, Refactoring
- Debugging, API Design, Database
- DevOps, Code Review

**Documentation:**
- User-facing: README, USAGE, FAQ
- Developer-facing: CONTRIBUTING, DEVELOPMENT
- Process: CHANGELOG, RELEASE_NOTES

### Design Principles

**1. User-Centric:**
- Commands should be intuitive
- Clear, helpful output
- Errors should guide users

**2. Composable:**
- Commands work together
- Agents can be chained
- Workflows are flexible

**3. Consistent:**
- Similar commands follow patterns
- Predictable behavior
- Standard formatting

**4. Well-Tested:**
- All features have tests
- Edge cases covered
- Regression prevention

**5. Well-Documented:**
- Every command documented
- Examples provided
- Clear usage instructions

---

## Making Changes

### Creating a Branch

**Branch naming:**
```bash
# Features
git checkout -b feature/add-user-authentication

# Bug fixes
git checkout -b fix/resolve-checkpoint-error

# Documentation
git checkout -b docs/improve-setup-guide

# Refactoring
git checkout -b refactor/simplify-agent-loading
```

**Patterns:**
- `feature/` - New functionality
- `fix/` - Bug fixes
- `docs/` - Documentation only
- `refactor/` - Code improvements
- `test/` - Test additions/fixes
- `chore/` - Maintenance tasks

### Making Your Changes

**Best practices:**

**1. Start small:**
```bash
# Good: One focused change
git commit -m "fix: handle null values in checkpoint loading"

# Avoid: Multiple unrelated changes
git commit -m "fix bugs, add features, update docs"
```

**2. Follow existing patterns:**
```bash
# Look at similar files
cat commands/workflow/create-plan.md
# Use the same structure for your new command
```

**3. Test as you go:**
```bash
# After each change
npm test

# Try it in Claude Code
claude-code
/your-new-command
```

**4. Keep it working:**
- Don't break existing functionality
- Add tests for new features
- Update docs immediately

### Adding a New Command

**1. Create the file:**
```bash
# Example: adding a new workflow command
touch commands/workflow/analyze-dependencies.md
```

**2. Follow the template:**
```markdown
# Analyze Dependencies

Analyze project dependencies and identify potential issues.

## Usage

/workflow/analyze-dependencies [options]

## What This Command Does

1. Scans package.json and lock files
2. Identifies outdated packages
3. Checks for security vulnerabilities
4. Suggests updates

## Options

- `--security-only` - Only check for security issues
- `--outdated` - Show outdated packages
- `--unused` - Find unused dependencies

## Output

The command will provide:
- List of dependencies
- Version information
- Security alerts
- Recommendations

## Examples

# Check all dependencies
/workflow/analyze-dependencies

# Security check only
/workflow/analyze-dependencies --security-only
```

**3. Add tests:**
```bash
# Create test file
touch tests/unit/commands/workflow/test-analyze-dependencies.sh

# Write tests (see Testing section)
```

**4. Update documentation:**
- Add to README if it's a major feature
- Update USAGE.md
- Add examples if helpful

### Adding a New Agent

**1. Create the agent file:**
```bash
touch agents/frontend-agent.md
```

**2. Define the agent:**
```markdown
# Frontend Development Agent

You are a specialized agent for frontend development, focusing on modern web technologies, UI/UX best practices, and performance optimization.

## Your Expertise

- React, Vue, Angular, Svelte
- TypeScript and modern JavaScript
- CSS/SCSS/Tailwind
- State management (Redux, Zustand, etc.)
- Build tools (Vite, Webpack, etc.)
- Testing (Jest, Vitest, Testing Library)
- Accessibility (WCAG, ARIA)
- Performance optimization

## Your Responsibilities

When analyzing frontend code, you should:

1. **Component Design:**
   - Evaluate component structure and reusability
   - Check for proper prop typing
   - Verify state management patterns
   - Assess component composition

2. **Performance:**
   - Identify unnecessary re-renders
   - Check for memo/callback usage
   - Evaluate bundle size impact
   - Suggest code splitting opportunities

3. **Accessibility:**
   - Verify semantic HTML
   - Check ARIA attributes
   - Validate keyboard navigation
   - Ensure screen reader compatibility

4. **Best Practices:**
   - Enforce TypeScript usage
   - Check for proper error handling
   - Verify loading states
   - Validate form handling

5. **Styling:**
   - Review CSS organization
   - Check for responsive design
   - Validate design system usage
   - Identify style inconsistencies

## Analysis Format

When analyzing code, provide:

1. **Overview:** High-level assessment
2. **Issues Found:** Categorized by severity
3. **Recommendations:** Specific improvements
4. **Examples:** Code snippets showing fixes
5. **Resources:** Links to relevant documentation

## Output Structure

# Frontend Analysis Report

## Summary
[Overall assessment]

## Components Reviewed
- [List of components]

## Issues

### Critical
- [Issue 1]
- [Issue 2]

### Moderate
- [Issue 1]

### Minor
- [Issue 1]

## Recommendations

### Performance
1. [Recommendation with example]

### Accessibility
1. [Recommendation with example]

### Code Quality
1. [Recommendation with example]

## Resources
- [Relevant links]
```

**3. Create command to use it:**
```bash
# In commands/research/frontend.md
Invoke the frontend development agent to analyze [USER_REQUEST].

Use the frontend-agent.md specialist.
```

**4. Add tests:**
```bash
touch tests/unit/agents/test-frontend-agent.sh
```

**5. Document it:**
- Add to agents README
- Include usage examples
- List in main documentation

### Coding Standards

**Markdown files:**
- Use ATX-style headers (`#` not `===`)
- One blank line between sections
- Code blocks with language specified
- Max line length: 100 characters (documentation)

**Shell scripts (tests):**
```bash
#!/bin/bash

# Use strict mode
set -euo pipefail

# Functions in lowercase with underscores
function test_something() {
    # Descriptive variable names
    local expected_result="value"
    local actual_result=$(command)

    # Clear assertions
    if [[ "$actual_result" == "$expected_result" ]]; then
        echo "✓ Test passed"
        return 0
    else
        echo "✗ Test failed"
        return 1
    fi
}
```

**Commit messages:**
```bash
# Format: <type>: <subject>

# Types:
# feat: New feature
# fix: Bug fix
# docs: Documentation only
# test: Adding tests
# refactor: Code change that neither fixes a bug nor adds a feature
# chore: Maintenance

# Examples:
git commit -m "feat: add dependency analysis command"
git commit -m "fix: handle null values in checkpoint parsing"
git commit -m "docs: improve setup instructions"
git commit -m "test: add integration tests for GitHub commands"
```

---

## Testing

### Running Tests

**All tests:**
```bash
npm test
```

**Specific test suite:**
```bash
# Command tests
./tests/unit/commands/test-all-commands.sh

# Agent tests
./tests/unit/agents/test-all-agents.sh

# Integration tests
./tests/integration/workflows/test-basic-workflow.sh
```

**Single test:**
```bash
./tests/unit/commands/workflow/test-create-plan.sh
```

### Writing Tests

**Test structure:**
```bash
#!/bin/bash

# Test: Description of what this tests
# Expected: What should happen

set -euo pipefail

# Setup
test_dir=$(mktemp -d)
cd "$test_dir"

# Initialize git repo for testing
git init
git config user.email "test@example.com"
git config user.name "Test User"

# Test execution
function test_create_plan() {
    echo "Testing plan creation..."

    # Your test logic here
    local result=$(your-command)

    if [[ "$result" == *"expected output"* ]]; then
        echo "✓ Plan creation test passed"
        return 0
    else
        echo "✗ Plan creation test failed"
        echo "Expected: expected output"
        echo "Got: $result"
        return 1
    fi
}

# Run tests
test_create_plan

# Cleanup
cd /
rm -rf "$test_dir"

echo "All tests passed!"
```

**Test checklist:**
- ✅ Tests the happy path
- ✅ Tests error conditions
- ✅ Cleans up after itself
- ✅ Has clear output
- ✅ Runs quickly (<5 seconds)
- ✅ Doesn't depend on external state
- ✅ Can run in isolation

### Test Categories

**Unit tests:**
- Test individual commands
- Test individual agents
- Test utility functions
- Fast, isolated

**Integration tests:**
- Test complete workflows
- Test command chains
- Test GitHub integration
- Slower, more comprehensive

**Validation tests:**
- Verify file formats
- Check for required fields
- Ensure consistency
- Quick sanity checks

### Adding Tests for Your Changes

**New feature:**
```bash
# 1. Create unit test
touch tests/unit/commands/your-category/test-your-feature.sh

# 2. Write the test
# (See template above)

# 3. Run it
./tests/unit/commands/your-category/test-your-feature.sh

# 4. Add to test suite
# Edit tests/unit/commands/test-all-commands.sh
# Add line to run your test
```

**Bug fix:**
```bash
# 1. Write a test that reproduces the bug
# (It should fail before your fix)

# 2. Apply your fix

# 3. Verify test now passes

# 4. Commit both test and fix together
```

---

## Documentation

### What Needs Documentation?

**Always document:**
- ✅ New commands (in the command file itself)
- ✅ New agents (in the agent file)
- ✅ New features (in README, USAGE)
- ✅ Breaking changes (in CHANGELOG)
- ✅ Configuration options
- ✅ Behavioral changes

**Update when changed:**
- ✅ README if core functionality changes
- ✅ USAGE if command behavior changes
- ✅ FAQ if common questions arise
- ✅ Examples if workflows change

### Documentation Standards

**Command documentation:**
```markdown
# Command Name

Brief description (one sentence).

## Usage

/command-name [arguments] [options]

## Description

Detailed explanation of what the command does.

## Arguments

- `argument1` - Description
- `argument2` - (Optional) Description

## Options

- `--option1` - Description
- `--option2` - Description

## Examples

# Basic usage
/command-name

# With options
/command-name --option1 value

# Complex example
/command-name arg1 --option2

## Output

Describe what the user will see.

## See Also

- Related command 1
- Related command 2
```

**Agent documentation:**
```markdown
# Agent Name

You are a specialized agent for [DOMAIN].

## Expertise
[List areas of expertise]

## Responsibilities
[What the agent does]

## Analysis Process
[How the agent works]

## Output Format
[Structure of the response]
```

### Writing Good Documentation

**Be clear:**
```markdown
# Good
This command analyzes your project's dependencies and identifies security vulnerabilities.

# Avoid
This command does dependency stuff.
```

**Provide examples:**
```markdown
# Good
## Examples

# Analyze all dependencies
/workflow/analyze-dependencies

# Check only for security issues
/workflow/analyze-dependencies --security-only

# Avoid
Use the command with appropriate flags.
```

**Explain the why:**
```markdown
# Good
Use checkpoints to save your progress before risky changes. This allows you to easily revert if something goes wrong.

# Avoid
Use checkpoints.
```

---

## Submitting Changes

### Before You Submit

**Checklist:**
- ✅ Tests pass (`npm test`)
- ✅ Code follows standards
- ✅ Documentation updated
- ✅ Commits are clean
- ✅ No breaking changes (or documented)
- ✅ Tested in Claude Code

### Creating a Pull Request

**1. Push your branch:**
```bash
git push origin feature/your-feature-name
```

**2. Create PR on GitHub:**
```bash
# Using GitHub CLI
gh pr create --title "feat: add dependency analysis" \
             --body "Adds command to analyze project dependencies..."

# Or use the GitHub web interface
```

**3. PR description template:**
```markdown
## Description

Brief description of what this PR does.

## Motivation

Why is this change needed? What problem does it solve?

## Changes

- Added X
- Modified Y
- Fixed Z

## Testing

- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manually tested in Claude Code
- [ ] Documentation updated

## Screenshots (if applicable)

[Add screenshots or command output]

## Checklist

- [ ] Tests pass
- [ ] Documentation updated
- [ ] CHANGELOG updated (if needed)
- [ ] No breaking changes (or documented)
- [ ] Follows coding standards

## Related Issues

Fixes #123
Related to #456
```

**4. Link related issues:**
```markdown
Fixes #123
Closes #456
Related to #789
```

### PR Size Guidelines

**Keep PRs focused:**
- ✅ One feature or fix per PR
- ✅ Under 500 lines changed (when possible)
- ✅ Easy to review
- ✅ Clear purpose

**Too large? Split it:**
```bash
# Instead of one huge PR:
# PR 1: Refactor existing code
# PR 2: Add new feature
# PR 3: Update documentation
```

---

## Code Review Process

### What to Expect

**Review timeline:**
- Initial response: 1-3 days
- Full review: 3-7 days
- Complex PRs: May take longer

**Review focus:**
- Correctness
- Test coverage
- Documentation
- Code quality
- Performance
- Security

### Responding to Feedback

**Be receptive:**
```markdown
# Good responses
"Good catch! I'll fix that."
"Great idea, I'll update it."
"I hadn't considered that, let me revise."

# Avoid
"It works for me."
"That's not important."
```

**Ask for clarification:**
```markdown
"Could you explain what you mean by X?"
"I'm not sure I understand - could you provide an example?"
```

**Discuss alternatives:**
```markdown
"I see your point. What if we tried X instead?"
"Both approaches have merits. Which do you prefer and why?"
```

### Making Requested Changes

**1. Make the changes:**
```bash
# Make updates
vim commands/workflow/your-command.md

# Commit
git add .
git commit -m "refactor: address review feedback"
```

**2. Push updates:**
```bash
git push origin feature/your-feature-name
```

**3. Respond to comments:**
```markdown
Fixed in [commit-sha]. Let me know if this addresses your concern.
```

**4. Re-request review:**
```bash
gh pr ready  # Mark PR as ready for review
```

---

## Community Guidelines

### Code of Conduct

**Be respectful:**
- Treat everyone with respect
- Be patient with beginners
- Provide constructive feedback
- Assume good intentions

**Be inclusive:**
- Welcome all contributors
- Use inclusive language
- Avoid assumptions
- Help others succeed

**Be collaborative:**
- Share knowledge
- Credit others' work
- Ask for help when needed
- Offer help to others

### Communication Channels

**GitHub Issues:**
- Bug reports
- Feature requests
- Technical discussions

**GitHub Discussions:**
- Questions and answers
- Ideas and brainstorming
- Showcase projects
- General chat

**Pull Requests:**
- Code reviews
- Implementation discussions
- Technical feedback

### Getting Help

**Stuck? Ask!**
- GitHub Discussions for questions
- Tag maintainers if urgent
- Provide context and details
- Share what you've tried

**Example question:**
```markdown
# Bad
"It doesn't work. Help?"

# Good
"I'm trying to add a new command for X. I followed the pattern
from Y command, but I'm getting error Z when I run it.

Here's what I've tried:
- [Thing 1]
- [Thing 2]

Here's my code: [link]
Any suggestions?"
```

---

## Recognition

### Contributor Recognition

**We recognize contributors:**
- 🌟 Added to CONTRIBUTORS.md
- 📢 Mentioned in release notes
- 🏆 Special roles for consistent contributors
- 💬 Featured in community showcases

### Levels of Contribution

**First-time contributor:**
- Welcome!
- You'll get extra help
- Smaller PRs encouraged
- Learning is the goal

**Regular contributor:**
- Multiple successful PRs
- Familiar with codebase
- Can review others' PRs
- Helps in discussions

**Core contributor:**
- Significant contributions
- Deep codebase knowledge
- Helps maintain the project
- Mentors new contributors

**Maintainer:**
- Merge permissions
- Release management
- Project direction
- Community leadership

### Path to Maintainer

**Want to become a maintainer?**

1. **Contribute regularly** (quality over quantity)
2. **Help others** (answer questions, review PRs)
3. **Show expertise** (demonstrate deep understanding)
4. **Be reliable** (follow through on commitments)
5. **Lead initiatives** (propose and drive improvements)

**We're always looking for maintainers!**

---

## Quick Reference

### Useful Commands

```bash
# Development
npm test                    # Run all tests
npm run test:unit          # Unit tests only
npm run test:integration   # Integration tests
npm run lint               # Check code style

# Git workflow
git fetch upstream         # Get latest changes
git rebase upstream/main   # Update your branch
git push -f origin branch  # Force push (after rebase)

# GitHub CLI
gh pr create              # Create PR
gh pr view                # View PR details
gh pr checks              # Check CI status
gh pr review              # Submit review
```

### File Locations

```
Commands:        commands/{category}/{name}.md
Agents:          agents/{name}-agent.md
Tests:           tests/{unit|integration}/{category}/
Docs:            docs/{name}.md
Examples:        examples/{project-name}/
GitHub:          .github/{workflows|ISSUE_TEMPLATE}/
```

### Getting Help

- 📖 Read the FAQ: `docs/FAQ.md`
- 💬 Ask in Discussions: GitHub Discussions
- 🐛 Report bugs: GitHub Issues
- 📧 Email maintainers: (for security issues)

---

## Thank You!

Thank you for contributing to Claude Workflow Pro! Every contribution, no matter how small, makes the project better for everyone.

**Happy coding!** 🚀

---

**Last updated:** 2025-01-15
**Version:** 1.0.0
**Maintained by:** Claude Workflow Pro Team

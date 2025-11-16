# Contributing to Claude Workflow Pro

Thank you for your interest in contributing to Claude Workflow Pro! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Contribution Types](#contribution-types)
- [Development Guidelines](#development-guidelines)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Community](#community)

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Getting Started

### Prerequisites

Before contributing, make sure you have:

- [Claude Code](https://claude.com/claude-code) installed
- Git installed and configured
- GitHub account
- GitHub CLI (`gh`) for testing GitHub integration features
- Basic knowledge of Markdown and YAML
- Familiarity with Claude Code's command/plugin system

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/claude-workflow-pro.git
   cd claude-workflow-pro
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/yourusername/claude-workflow-pro.git
   ```

## Development Setup

### Install the Plugin Locally

1. Create a symlink to your development directory:
   ```bash
   ln -s /path/to/your/claude-workflow-pro ~/.claude-plugins/claude-workflow-pro
   ```

2. Restart Claude Code or reload plugins

3. Verify installation:
   ```bash
   # In Claude Code
   /help
   ```

### Project Structure

```
claude-workflow-pro/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── .github/
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   ├── workflows/               # GitHub Actions
│   └── PULL_REQUEST_TEMPLATE.md
├── commands/
│   ├── workflow/                # Workflow commands (6)
│   ├── github/                  # GitHub integration (5)
│   ├── development/             # Dev tools (3)
│   └── research/                # Research tools (1)
├── agents/
│   ├── README.md                # Agent discovery system
│   ├── codebase/                # Codebase analysis
│   ├── documentation/           # Doc analysis
│   ├── web/                     # Web research
│   └── workflow/                # Workflow agents
├── tests/
│   ├── integration/             # Integration tests
│   └── validation/              # Command/agent validation
├── examples/                    # Example projects
├── docs/                        # Documentation
├── README.md
├── USAGE.md
├── CONFIGURATION.md
├── CONTRIBUTING.md
└── LICENSE
```

## How to Contribute

### Finding Issues to Work On

- Check the [Issues](https://github.com/yourusername/claude-workflow-pro/issues) page
- Look for issues labeled `good first issue` or `help wanted`
- Comment on the issue to indicate you're working on it
- Wait for maintainer acknowledgment before starting work

### Reporting Bugs

1. Check if the bug has already been reported
2. Use the bug report template
3. Provide detailed reproduction steps
4. Include your environment details
5. Add relevant logs or screenshots

### Suggesting Features

1. Check if the feature has already been requested
2. Use the feature request template
3. Explain the use case clearly
4. Provide examples of how it would work
5. Consider offering to help implement it

## Contribution Types

### 1. Adding a New Command

Commands are Markdown files that define slash commands for Claude Code.

**File Location**: `commands/{category}/{command-name}.md`

**Template**:
```markdown
---
description: Brief description of what this command does
model: sonnet  # or opus/haiku
---

# Command Name

Detailed description of the command and its purpose.

## When to Use

- Use case 1
- Use case 2

## Prerequisites

- Prerequisite 1
- Prerequisite 2

## Process

### Step 1: First Step

Instructions for the first step.

### Step 2: Second Step

Instructions for the second step.

## Configuration

```json
{
  "configOption": "value"
}
```

## Examples

### Example 1: Common Use Case

\`\`\`bash
# Example command
/category/command-name
\`\`\`

## Error Handling

### Error 1: Description

**Cause**: Why this happens
**Solution**: How to fix it

## Integration with Other Commands

- Works well with `/other/command`
- Can be chained with `/another/command`

## Best Practices

1. Best practice 1
2. Best practice 2

## Troubleshooting

### Issue 1

**Problem**: Description
**Solution**: How to fix

## Related Commands

- `/related/command` - Description
```

**Checklist**:
- [ ] Add YAML frontmatter with description and model
- [ ] Include clear use cases
- [ ] Document prerequisites
- [ ] Number steps consistently (start at 1)
- [ ] Add configuration examples
- [ ] Include error handling
- [ ] Add integration notes
- [ ] Provide real-world examples
- [ ] Add to appropriate test suite
- [ ] Update README.md command table
- [ ] Update USAGE.md with examples

### 2. Adding a New Agent

Agents are Markdown files that provide specialized analysis capabilities.

**File Location**: `agents/{category}/{agent-name}.md`

**Template**:
```markdown
# Agent Name

Brief description of what this agent does.

## When to Use

- Situation 1
- Situation 2

## How It Works

1. Step 1
2. Step 2

## Input Requirements

- Required input 1
- Required input 2

## Output Format

Description of what the agent returns.

**CRITICAL**: Always filter results to maximum 5-10 most relevant items.

## Example Usage

\`\`\`bash
# Example of when this agent would be used
\`\`\`

## Tips

- Tip 1
- Tip 2
```

**Checklist**:
- [ ] Add to appropriate category directory
- [ ] Implement result filtering (max 5-10 items)
- [ ] Update category README.md
- [ ] Add to agent validation tests
- [ ] Test with example projects
- [ ] Document in main README.md

### 3. Improving Documentation

**Types of Documentation**:
- Command documentation (in `commands/`)
- Agent documentation (in `agents/`)
- User guides (README.md, USAGE.md, CONFIGURATION.md)
- Example projects (in `examples/`)
- Technical docs (in `docs/`)

**Checklist**:
- [ ] Check for accuracy
- [ ] Add missing examples
- [ ] Fix typos and grammar
- [ ] Update outdated information
- [ ] Add screenshots if helpful
- [ ] Test all code examples
- [ ] Update table of contents if needed

### 4. Adding Tests

**Test Types**:

1. **Command Validation Tests** (`tests/validation/test-commands.sh`)
   - Validates command structure
   - Checks frontmatter
   - Verifies required sections

2. **Agent Validation Tests** (`tests/validation/test-agents.sh`)
   - Validates agent structure
   - Checks result filtering

3. **Integration Tests** (`tests/integration/`)
   - Tests command workflows
   - Tests agent integration
   - Tests example projects

**Adding a Test**:
```bash
# Create test file
touch tests/integration/category/test-new-feature.sh
chmod +x tests/integration/category/test-new-feature.sh
```

**Test Template**:
```bash
#!/bin/bash

# Test: Description
# Purpose: What this test validates

set -e

echo "Testing: Feature name..."

# Test setup
setup_test_environment() {
    # Setup code
}

# Test execution
run_test() {
    # Test code
}

# Test validation
validate_results() {
    # Validation code
}

# Run test
setup_test_environment
run_test
validate_results

echo "✓ Test passed"
```

### 5. Creating Example Projects

Example projects help users understand how to use the plugin.

**Location**: `examples/{project-name}/`

**Required Files**:
- `README.md` - Project overview and setup
- `.claude-plugin-config.json` - Plugin configuration
- Sample project files
- `.gitignore` - Ignore patterns
- Test script

**Checklist**:
- [ ] Create clear README with setup instructions
- [ ] Include working configuration
- [ ] Add sample files that demonstrate features
- [ ] Create test script in `tests/integration/examples/`
- [ ] Add to examples comparison in `examples/README.md`
- [ ] Test with fresh clone

## Development Guidelines

### Command Development

1. **Frontmatter Format**:
   ```yaml
   ---
   description: One-line description (max 80 chars)
   model: sonnet  # or opus/haiku
   ---
   ```

2. **Section Naming**:
   - Use "## Process" for main workflow section
   - Number steps starting at 1 (not 0)
   - Use consistent heading levels

3. **Step Numbering**:
   ```markdown
   ## Process

   ### Step 1: First Step
   ### Step 2: Second Step
   ### Step 3: Third Step
   ```

4. **Error Handling**:
   - Include "## Error Handling" section
   - Document common errors with solutions
   - Add troubleshooting section

5. **Examples**:
   - Provide real-world examples
   - Show both common and advanced usage
   - Include expected output

### Agent Development

1. **Result Filtering**:
   - ALWAYS filter to 5-10 most relevant items
   - Sort by relevance
   - Provide context for each result

2. **Progressive Discovery**:
   - Start with category README
   - Load specific agents only when needed
   - Minimize initial context usage

3. **Output Format**:
   - Clear, actionable results
   - Include file paths and line numbers
   - Provide next steps

### Code Style

1. **Markdown**:
   - Use ATX-style headers (`#`)
   - Use fenced code blocks with language tags
   - Use consistent list formatting

2. **YAML**:
   - Use 2-space indentation
   - Quote strings when necessary
   - Validate syntax

3. **Bash Scripts**:
   - Use `#!/bin/bash`
   - Set `-e` for error handling
   - Add comments for complex logic
   - Make scripts executable (`chmod +x`)

4. **JSON**:
   - Use 2-space indentation
   - Validate syntax
   - Add comments in markdown docs

## Testing

### Running Tests

```bash
# Run all tests
chmod +x tests/integration/run-all-tests.sh
./tests/integration/run-all-tests.sh

# Run specific test category
./tests/validation/test-commands.sh
./tests/validation/test-agents.sh

# Run integration tests
./tests/integration/workflows/test-basic-workflow.sh
./tests/integration/agents/test-agent-discovery.sh
```

### Test Requirements

1. **All tests must pass** before submitting PR
2. **Add tests** for new features
3. **Update tests** when changing behavior
4. **Document** test purpose and requirements

### Manual Testing

1. Test with example projects
2. Test with real-world projects
3. Test configuration edge cases
4. Test error scenarios
5. Test integration with other commands

## Documentation

### Documentation Standards

1. **README.md**:
   - Keep updated with new features
   - Update command tables
   - Update installation instructions

2. **USAGE.md**:
   - Add examples for new commands
   - Show common workflows
   - Include troubleshooting

3. **CONFIGURATION.md**:
   - Document new config options
   - Show examples
   - Explain defaults

4. **CHANGELOG.md**:
   - Follow [Keep a Changelog](https://keepachangelog.com/) format
   - Update with every PR
   - Group changes by type

### Changelog Format

```markdown
## [Unreleased]

### Added
- New feature description

### Changed
- Changed feature description

### Fixed
- Bug fix description

### Deprecated
- Deprecated feature description

### Removed
- Removed feature description

### Security
- Security fix description
```

## Pull Request Process

### Before Submitting

1. **Update your fork**:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**:
   - Follow development guidelines
   - Write clear commit messages
   - Keep commits focused and atomic

4. **Test thoroughly**:
   ```bash
   # Run all tests
   ./tests/integration/run-all-tests.sh

   # Test manually with examples
   ```

5. **Update documentation**:
   - Update README.md if needed
   - Update USAGE.md with examples
   - Update CONFIGURATION.md if adding config
   - Update CHANGELOG.md

6. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types**:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `test:` Test changes
- `refactor:` Code refactoring
- `perf:` Performance improvements
- `chore:` Maintenance tasks

**Examples**:
```
feat(workflow): add checkpoint validation
fix(github): correct issue template parsing
docs(usage): add workflow examples
test(agents): add discovery tests
```

### Submitting the PR

1. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create PR on GitHub**:
   - Use the PR template
   - Fill out all sections
   - Link related issues
   - Request review

3. **Address review feedback**:
   - Make requested changes
   - Push additional commits
   - Respond to comments
   - Mark conversations resolved

4. **Keep PR updated**:
   ```bash
   # If main has changed
   git fetch upstream
   git rebase upstream/main
   git push --force-with-lease
   ```

### PR Review Process

1. **Automated checks** run (when CI is set up)
2. **Maintainer review** (may take 1-3 days)
3. **Address feedback** and make changes
4. **Re-review** if needed
5. **Merge** when approved

### After Merge

1. **Update your fork**:
   ```bash
   git checkout main
   git pull upstream main
   git push origin main
   ```

2. **Delete feature branch**:
   ```bash
   git branch -d feature/your-feature-name
   git push origin --delete feature/your-feature-name
   ```

## Community

### Communication Channels

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions and community discussion
- **Pull Requests**: Code contributions and reviews

### Getting Help

- Check existing documentation
- Search closed issues
- Ask in GitHub Discussions
- Tag maintainers if urgent

### Recognition

Contributors are recognized in:
- CHANGELOG.md for each release
- GitHub contributors page
- Special mentions for significant contributions

## Development Tips

### Efficient Development Workflow

1. **Use the plugin itself**:
   - Use `/workflow/init` for new features
   - Use `/workflow/checkpoint` to save progress
   - Use `/development/commit` for commits

2. **Test incrementally**:
   - Test as you develop
   - Don't wait until the end
   - Use example projects for testing

3. **Ask for feedback early**:
   - Open draft PRs for big changes
   - Ask questions in issues
   - Discuss design decisions

### Common Pitfalls

1. **Large PRs**: Break into smaller, focused PRs
2. **Missing tests**: Add tests for new features
3. **Outdated docs**: Update docs with code changes
4. **Breaking changes**: Discuss with maintainers first
5. **Incomplete PRs**: Use the PR template checklist

## Questions?

If you have questions about contributing:

1. Check this guide first
2. Search existing issues and discussions
3. Open a new discussion
4. Tag maintainers if needed

Thank you for contributing to Claude Workflow Pro! 🚀

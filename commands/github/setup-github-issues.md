---
description: Set up GitHub Issues infrastructure for a new repository
model: haiku
---

# Setup GitHub Issues

You are tasked with setting up GitHub Issues infrastructure for a new repository, including issue templates, labels, and documentation.

## When to Use

Use this command when:
- Starting a new project that will use GitHub Issues for task tracking
- Adding GitHub Issues workflow to an existing project
- Setting up a repository to use the standardized issue workflow

## Prerequisites

1. **GitHub CLI installed and authenticated**: `gh auth status`
2. **Git repository initialized**: Must be in a git repository
3. **GitHub remote configured**: Repository should have a GitHub remote

## Process Steps

### Step 1: Verify Prerequisites

```bash
# Check if in git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "⚠️  Not in a git repository"
  exit 1
fi

# Check if GitHub CLI is authenticated
if ! gh auth status > /dev/null 2>&1; then
  echo "⚠️  GitHub CLI not authenticated"
  echo "Run: gh auth login"
  exit 1
fi

# Get repository info
REPO_INFO=$(gh repo view --json name,owner,defaultBranchRef -q '.owner.login + "/" + .name')
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef -q '.defaultBranchRef.name')

if [ -z "$REPO_INFO" ]; then
  echo "⚠️  Not a GitHub repository or remote not configured"
  exit 1
fi

echo "✅ Repository: $REPO_INFO"
echo "✅ Default branch: $DEFAULT_BRANCH"
```

### Step 2: Detect Project Structure

```bash
# Check for existing docs structure
if [ ! -d "docs" ]; then
  echo "⚠️  No docs/ directory found"
  echo "Would you like to initialize project structure first? Run /init"
fi

# Check for existing .github directory
mkdir -p .github/ISSUE_TEMPLATE
```

### Step 3: Create Issue Templates

Create four issue templates in `.github/ISSUE_TEMPLATE/`:

**1. Bug Report Template** (`.github/ISSUE_TEMPLATE/bug.md`):

```markdown
---
name: Bug Report
about: Report a bug or issue
title: '[Bug] '
labels: bug
assignees: ''
---

## Description

<!-- Clear and concise description of the bug -->

## Location

<!-- File path and line number if applicable -->

- File: `path/to/file.ext:123`
- Related files: `other/file.ts`

## Steps to Reproduce

1.
2.
3.

## Expected Behavior

<!-- What should happen -->

## Actual Behavior

<!-- What actually happens -->

## Environment

- Browser/OS:
- Date discovered:

## Additional Context

- Discovered while working on: <!-- Link to related issue -->
- Related research: <!-- Link to docs/research/*.md -->
- Related plan: <!-- Link to docs/implementation-plans/*.md -->
```

**2. Feature Request Template** (`.github/ISSUE_TEMPLATE/feature.md`):

```markdown
---
name: Feature Request
about: Request a new feature
title: '[Feature] '
labels: feature
assignees: ''
---

## Problem Statement

<!-- What problem does this feature solve? -->

## Proposed Solution

<!-- Description of the proposed feature -->

## Implementation Details

<!-- Technical details if known -->

- Related files: `path/to/file.ext`
- Related research: <!-- Link to docs/research/*.md -->
- Related plan: <!-- Link to docs/implementation-plans/*.md -->

## Acceptance Criteria

- [ ]
- [ ]
- [ ]

## Additional Context

<!-- Any other relevant information -->
```

**3. Research Task Template** (`.github/ISSUE_TEMPLATE/research.md`):

```markdown
---
name: Research Task
about: Task requiring investigation or research
title: '[Research] '
labels: research
assignees: ''
---

## Research Question

<!-- What needs to be investigated? -->

## Context

<!-- Why is this research needed? -->

## Scope

<!-- What areas should be researched? -->

## Deliverables

- [ ] Research document in `docs/research/YYYY-MM-DD-topic.md`
- [ ] Summary of findings
- [ ] Recommendations or next steps

## Related

- Parent issue: <!-- Link to related feature/bug -->
- Related files: `path/to/file.ext`
```

**4. Discovery Template** (`.github/ISSUE_TEMPLATE/discovery.md`):

```markdown
---
name: Discovery
about: Something discovered during work that needs follow-up
title: '[Discovery] '
labels: discovery
assignees: ''
---

## What Was Discovered

<!-- Brief description -->

## Where

- File: `path/to/file.ext:123`
- Discovered while working on: <!-- Link to current issue -->

## Why It Matters

<!-- Why should this be tracked? -->

## Priority

<!-- High/Medium/Low - will fix immediately/later/eventually -->

## Additional Context

<!-- Any notes or details -->
```

### Step 4: Create GitHub Labels

Create all necessary labels using `gh label create`:

```bash
# Priority labels
gh label create "priority:high" --description "Urgent - critical blockers, security issues" --color "d73a4a" --force
gh label create "priority:medium" --description "Important features, major bugs" --color "fbca04" --force
gh label create "priority:low" --description "Nice-to-haves, minor improvements" --color "0e8a16" --force

# Status labels
gh label create "status:in-progress" --description "Currently being worked on" --color "0052cc" --force
gh label create "status:blocked" --description "Waiting on something" --color "b60205" --force
gh label create "status:needs-research" --description "Requires investigation" --color "c2e0c6" --force
gh label create "status:ready-for-plan" --description "Research complete, ready for plan" --color "c2e0c6" --force
gh label create "status:ready-for-dev" --description "Plan complete, ready for implementation" --color "0e8a16" --force

# Category labels
gh label create "bug" --description "Something isn't working" --color "d73a4a" --force
gh label create "feature" --description "New feature or request" --color "0e8a16" --force
gh label create "research" --description "Investigation or research task" --color "7057ff" --force
gh label create "discovery" --description "Discovered during work, needs follow-up" --color "f9d0c4" --force
gh label create "technical-debt" --description "Code quality improvements" --color "ededed" --force
gh label create "ui" --description "User interface related" --color "e99695" --force
gh label create "security" --description "Security related" --color "b60205" --force
gh label create "performance" --description "Performance related" --color "1d76db" --force

# Completed label (for tracking)
gh label create "completed" --description "Completed task" --color "0e8a16" --force
```

### Step 5: Create TASKS.md Documentation

Create `docs/TASKS.md` with workflow documentation:

```markdown
# Task Management

This project uses GitHub Issues for task tracking. This file provides quick reference to active tasks and workflow.

## Quick Links

- [All Open Issues](https://github.com/$REPO_INFO/issues?q=is%3Aissue+is%3Aopen)
- [Open Bugs](https://github.com/$REPO_INFO/issues?q=is%3Aissue+is%3Aopen+label%3Abug)
- [Open Features](https://github.com/$REPO_INFO/issues?q=is%3Aissue+is%3Aopen+label%3Afeature)
- [High Priority](https://github.com/$REPO_INFO/issues?q=is%3Aissue+is%3Aopen+label%3Apriority%3Ahigh)
- [Security Issues](https://github.com/$REPO_INFO/issues?q=is%3Aissue+is%3Aopen+label%3Asecurity)
- [Performance Issues](https://github.com/$REPO_INFO/issues?q=is%3Aissue+is%3Aopen+label%3Aperformance)

## Current Active Tasks

To see current open issues:

\`\`\`bash
gh issue list --state open
\`\`\`

To see issues by priority:

\`\`\`bash
gh issue list --state open --label priority:high
gh issue list --state open --label priority:medium
\`\`\`

## Workflow

### Starting Work

**Option 1: Use convenience command**

\`\`\`bash
/next-task
\`\`\`

This lists open issues by priority and lets you select one to start.

**Option 2: Start from specific issue**

\`\`\`bash
/start-from-issue 123
\`\`\`

This automatically handles research → plan workflow for issue #123.

**Option 3: Manual workflow**

\`\`\`bash
# 1. Find issue
gh issue list --state open

# 2. View issue details
gh issue view 123

# 3. Start research
/research-codebase "How to implement [feature from issue]"

# 4. Create plan
/create-plan --issue 123

# 5. Implement
/implement-plan docs/implementation-plans/YYYY-MM-DD-plan.md
\`\`\`

### During Work

**Creating discovery issues:**

\`\`\`bash
gh issue create \\
  --title "[Discovery] Brief description" \\
  --label "discovery" \\
  --body "Discovered while working on #123:
- [Description]
- File: \`path/to/file.ext:123\`
- Will investigate after completing current task"
\`\`\`

Or use the discovery template:

\`\`\`bash
gh issue create --template discovery
\`\`\`

### Completing Work

**Closing issues via commit:**

\`\`\`bash
git commit -m "feat: implement feature

Closes #123

See: docs/implementation-plans/YYYY-MM-DD-plan.md"
\`\`\`

**After validation:**
The `/validate-plan` command will:
- Find the linked issue
- Add validation comment
- Close the issue if validation passes
- Suggest next issue to work on

## CLI Commands

### Basic Issue Management

\`\`\`bash
# List open issues
gh issue list --state open

# List by priority
gh issue list --state open --label priority:high

# View issue
gh issue view 123

# Create new issue
gh issue create --template bug
gh issue create --template feature
gh issue create --template research
gh issue create --template discovery

# Close issue (usually done via commit message)
gh issue close 123 --comment "Fixed in commit abc123"

# Search issues
gh issue list --search "keyword"
\`\`\`

### Issue Status Management

\`\`\`bash
# Mark as in-progress
gh issue edit 123 --add-label "status:in-progress" --remove-label "status:ready-for-dev"

# Mark as blocked
gh issue edit 123 --add-label "status:blocked"

# Mark as ready for plan
gh issue edit 123 --add-label "status:ready-for-plan" --remove-label "status:needs-research"
\`\`\`

## Issue Templates

We have four issue templates:

- **Bug Report** (\`.github/ISSUE_TEMPLATE/bug.md\`) - For reporting bugs
- **Feature Request** (\`.github/ISSUE_TEMPLATE/feature.md\`) - For new features
- **Research Task** (\`.github/ISSUE_TEMPLATE/research.md\`) - For investigation tasks
- **Discovery** (\`.github/ISSUE_TEMPLATE/discovery.md\`) - For issues discovered during work

Use templates when creating issues:

\`\`\`bash
gh issue create --template bug
\`\`\`

## Labels

### Priority Labels

- \`priority:high\` - Urgent (critical blockers, security issues)
- \`priority:medium\` - Important (features, major bugs)
- \`priority:low\` - Nice-to-haves, minor improvements

### Status Labels

- \`status:in-progress\` - Currently being worked on
- \`status:blocked\` - Waiting on something
- \`status:needs-research\` - Requires investigation
- \`status:ready-for-plan\` - Research complete, ready for plan
- \`status:ready-for-dev\` - Plan complete, ready for implementation

### Category Labels

- \`bug\` - Something isn't working
- \`feature\` - New feature or request
- \`research\` - Investigation or research task
- \`discovery\` - Discovered during work, needs follow-up
- \`technical-debt\` - Code quality improvements
- \`ui\` - User interface related
- \`security\` - Security related
- \`performance\` - Performance related

## Best Practices

1. **Link everything**: Research docs, plans, and implementations should reference issue numbers
2. **Update status**: Keep issue status labels current as work progresses
3. **Create discoveries**: Don't forget issues you find - create discovery issues immediately
4. **Use templates**: Use issue templates for consistent formatting
5. **Close via commits**: Include "Closes #123" in commit messages to auto-close issues
6. **Search first**: Before creating duplicate issues, search existing issues
```

Use dynamic repository information when generating URLs.

### Step 6: Report Completion

Present summary:

```markdown
## ✅ GitHub Issues Setup Complete!

### Created:

**Issue Templates:**
- `.github/ISSUE_TEMPLATE/bug.md`
- `.github/ISSUE_TEMPLATE/feature.md`
- `.github/ISSUE_TEMPLATE/research.md`
- `.github/ISSUE_TEMPLATE/discovery.md`

**Labels Created:**
- Priority: high, medium, low
- Status: in-progress, blocked, needs-research, ready-for-plan, ready-for-dev
- Categories: bug, feature, research, discovery, technical-debt, ui, security, performance
- Tracking: completed

**Documentation:**
- `docs/TASKS.md` - Complete workflow reference

### Next Steps:

1. **Create your first issue:**
   \`\`\`bash
   gh issue create --template feature
   \`\`\`

2. **Start using workflow commands:**
   - `/next-task` - Find next issue to work on
   - `/start-from-issue <number>` - Begin workflow for an issue
   - `/research-codebase` - Research codebase topics
   - `/create-plan` - Create implementation plans

3. **Review workflow:**
   - Read `docs/TASKS.md` for complete workflow documentation
   - Customize labels or templates as needed for your project
```

## Error Handling

- **Not in git repo**: Exit with clear message
- **GitHub CLI not authenticated**: Exit with instructions
- **Not GitHub repo**: Exit with warning
- **Labels already exist**: Use `--force` flag (handled automatically)
- **Templates exist**: Overwrite (user can customize after)

## Important Notes

- **Repository detection**: Dynamically gets repo owner/name from `gh repo view`
- **URL generation**: Creates correct URLs for repository
- **Idempotent**: Safe to run multiple times (labels use --force)
- **Non-destructive**: Only creates new files, doesn't delete existing

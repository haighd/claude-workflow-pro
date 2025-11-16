---
description: Create a new GitHub issue with proper formatting and labels
model: haiku
---

# Create Issue

Create a new GitHub issue with proper formatting, labels, and metadata. This command helps you quickly create well-structured issues without leaving your workflow.

## Usage

```bash
/create-issue [title]
```

## When to Use

- You've identified a bug that needs tracking
- You want to capture a feature request
- You need to document technical debt
- You've discovered something that needs follow-up

## Process

### Step 1: Gather Information

If title provided as argument, use it. Otherwise, ask the user:

```bash
What would you like to create an issue for?

Provide a brief title or description, and I'll help structure it properly.
```

### Step 2: Determine Issue Type

Based on the title/description, determine the most appropriate issue type:

- **bug**: Something is broken or not working as expected
- **enhancement**: Improvement to existing functionality
- **feature**: New functionality or capability
- **documentation**: Documentation improvements
- **question**: Question or discussion needed
- **chore**: Maintenance, refactoring, or technical debt

Ask user to confirm or override the detected type.

### Step 3: Interactive Issue Creation

Ask the user for additional details (make it conversational, don't require all fields):

```bash
I'll help you create a [TYPE] issue: "[TITLE]"

Optional details (press Enter to skip any):
1. Description: What's the context or details?
2. Labels: Any additional labels? (I've already added "[TYPE]")
3. Priority: high, medium, low, or none?
4. Effort: low, medium, high, or none?
5. Assignee: Assign to someone? (leave blank for unassigned)
```

### Step 4: Build Issue Body

Structure the issue body based on type:

**For bugs:**
```markdown
## Description
[User's description]

## Current Behavior
[What's happening now]

## Expected Behavior
[What should happen]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]

## Environment
- Branch: [current branch from git]
- Date: [current date]

## Priority
[priority level if specified]
```

**For features/enhancements:**
```markdown
## Description
[User's description]

## Motivation
[Why is this needed?]

## Proposed Solution
[High-level approach]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Priority
[priority level if specified]
```

**For documentation:**
```markdown
## Description
[User's description]

## What needs documentation?
[Specific areas or topics]

## Target Audience
[Who is this documentation for?]

## Priority
[priority level if specified]
```

**For chores:**
```markdown
## Description
[User's description]

## Context
[Why does this need to be done?]

## Tasks
- [ ] [Task 1]
- [ ] [Task 2]

## Priority
[priority level if specified]
```

### Step 5: Build Labels Array

Combine labels:
- Issue type (bug, feature, enhancement, etc.)
- Priority label if specified: `priority:high`, `priority:medium`, `priority:low`
- Effort label if specified: `effort:low`, `effort:medium`, `effort:high`
- Any additional user-provided labels

### Step 6: Create the Issue

Use `gh issue create` with appropriate flags:

```bash
gh issue create \
  --title "[TITLE]" \
  --body "[FORMATTED_BODY]" \
  --label "[LABEL1]" \
  --label "[LABEL2]" \
  [--assignee "@me" if user wants to assign to themselves]
```

### Step 7: Confirm Success

```bash
✓ Created issue #[NUMBER]: [TITLE]
  URL: [GITHUB_URL]
  Type: [TYPE]
  Labels: [LABELS]

Would you like to:
1. Start working on it now? (run /start-from-issue [NUMBER])
2. View it? (run gh issue view [NUMBER])
3. Done (just show me the URL)
```

## Examples

**Example 1: Quick Bug**
```
User: /create-issue Modal not showing on mobile

Claude: I'll help you create a bug issue: "Modal not showing on mobile"

This looks like a bug. Is that correct? (yes/no)
User: yes

Optional details (press Enter to skip):
Description:
User: The modal doesn't display correctly on mobile devices under 768px

Priority (high/medium/low):
User: high

Effort (low/medium/high):
User: medium

Creating issue...

✓ Created issue #195: Modal not showing on mobile
  URL: https://github.com/user/repo/issues/195
  Type: bug
  Labels: bug, priority:high, effort:medium
```

**Example 2: Feature Request**
```bash
User: /create-issue Add export to CSV

Claude: I'll help you create a feature issue: "Add export to CSV"

This looks like a feature request. Is that correct? (yes/no)
User: yes

Optional details:
Description:
User: Need to export data to CSV for reporting

Priority: medium
Effort: medium

✓ Created issue #196: Add export to CSV
  URL: https://github.com/user/repo/issues/196
  Type: feature
  Labels: feature, priority:medium, effort:medium
```

## Important Notes

- **Quick mode**: If user provides complete info in initial prompt, create immediately
- **Conversational**: Don't make it feel like a form - keep it natural
- **Smart defaults**: Infer type, priority, effort when possible
- **URL visibility**: Always show the GitHub URL so user can click through
- **Integration ready**: Output format allows easy handoff to /start-from-issue

## Error Handling

If `gh issue create` fails:
1. Check if user is authenticated: `gh auth status`
2. Check if in a git repository with GitHub remote
3. Provide clear error message with resolution steps

## Repository Detection

Automatically detect repository from `gh repo view`:
- Uses current directory's git remote
- No need for user to specify repo

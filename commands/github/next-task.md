---
description: List all open issues in a table, sorted by effort and priority, with comments
model: sonnet
---

# Next Task

Display all open GitHub issues in a sortable table format, organized by effort level and priority. Includes issue metadata and comment count for quick assessment.

## Initial Response

When invoked:

```
/next-task
```

Or with filters:

```
/next-task --label bug
/next-task --priority high
/next-task --category feature
```

## Process Steps

### Step 1: Fetch All Open Issues with Comments

Query GitHub for all open issues including comment count:

```bash
gh issue list --state open \
  --json number,title,labels,createdAt,comments \
  --limit 100 \
  --jq '.[] |
    .priority = (.labels | map(select(.name | startswith("priority:"))) | .[0].name // "priority:none") |
    .effort = (.labels | map(select(.name | startswith("effort:"))) | .[0].name // "effort:none") |
    .type = (.labels | map(select(.name | test("^(bug|feature|enhancement|documentation)$"))) | .[0].name // "other") |
    .createdDaysAgo = (now - (.createdAt | fromdate) | floor / 86400 | floor) |
    .'
```

### Step 2: Sort and Transform Data

Sort by:
1. **Primary**: Effort level (low → medium → high)
2. **Secondary**: Priority (high → medium → low)
3. **Tertiary**: Recency (newest first)

Extract for each issue:
- Issue number and title
- Type label (bug, feature, enhancement, etc.)
- Effort and priority labels
- Days since created
- Comment count

### Step 3: Display Table Format

Show results in a markdown table:

```
## All Open Issues

| # | Title | Type | Priority | Effort | Created | Comments |
|---|-------|------|----------|--------|---------|----------|
| 190 | Fix remaining TypeScript errors | bug | high | medium | 0 days | 0 |
| 188 | Feature: Pet selection | feature | high | high | 1 day | 2 |
| 184 | Replace booking wizard auth | enhancement | high | high | 2 days | 1 |
| 135 | Auto-format telephone number | enhancement | medium | medium | 3 days | 0 |
| 122 | Replace email social icon | enhancement | medium | medium | 3 days | 1 |
| 124 | Migrate docs to GitHub Wiki | enhancement | medium | high | 3 days | 0 |

**Summary**: 14 issues total
- Effort: Low (0) | Medium (8) | High (6) | Blocked (0)
- Priority: High (3) | Medium (11) | Low (0) | None (0)
```

### Step 4: Allow Selection and Actions

```
Which issue would you like to work on?

Enter issue number (e.g., 190) or:
- Type "research <number>" to research that issue
- Type "plan <number>" to create implementation plan
- Type "view <number>" to see full issue details
- Type "comments <number>" to see all comments
- Type "filter <priority|effort> <value>" to filter table
- Type "sort <effort|priority|created>" to re-sort
- Type "cancel" to exit
```

### Step 5: Handle Selection

**If issue number provided:**
- Show full issue details: `gh issue view <number>`
- Display all comments if any exist
- Ask: "Start workflow for this issue? (y/n)"
- If yes: Call `/start-from-issue <number>`

**If "research <number>":**
- Call `/research-codebase` with issue context

**If "plan <number>":**
- Check if research exists, call `/create-plan --issue <number>`

**If "view <number>":**
- Show full issue with body and comments

**If "comments <number>":**
- Display all comments with author and date

**If "filter <type> <value>":**
- Re-display table filtered by priority, effort, or type
- Example: `filter priority high`

**If "sort <field>":**
- Re-sort and display table by specified field
- Options: effort, priority, created, comments

**If "cancel":**
- Exit gracefully

## Command Flags

Support optional filters during invocation:

**`--priority <level>`**: Show only specific priority
```bash
/next-task --priority high
```

**`--effort <level>`**: Show only specific effort
```bash
/next-task --effort medium
```

**`--label <label>`**: Filter by any label
```bash
/next-task --label bug
```

**`--sort <field>`**: Sort by field (effort, priority, created, comments)
```bash
/next-task --sort comments
```

## Table Column Definitions

- **#**: Issue number (clickable/selectable)
- **Title**: Issue title (truncated if >50 chars)
- **Type**: Issue category (bug, feature, enhancement, documentation)
- **Priority**: Priority level (high, medium, low, or none)
- **Effort**: Estimated effort (low, medium, high)
- **Created**: Days since creation
- **Comments**: Number of comments on issue

## Display Optimization

- Show full table for up to 20 issues
- If >20 issues: Show pagination summary
- Truncate long titles to 50 characters with "..." suffix
- Use emoji/symbols for quick scanning:
  - 🔴 priority:high
  - 🟡 priority:medium
  - 🟢 priority:low
  - ⚡ effort:low
  - 🔧 effort:medium
  - 🏗️ effort:high

## Example Interaction

```
User: /next-task

Agent: ## All Open Issues

| # | Title | Type | Priority | Effort | Created | Comments |
|---|-------|------|----------|--------|---------|----------|
| 190 | Fix TypeScript errors in tests | bug | 🔴 | 🔧 | 0 | 0 |
| 188 | Pet selection feature | feature | 🔴 | 🏗️ | 1 | 2 |
| 184 | Custom auth modal | enhancement | 🔴 | 🏗️ | 2 | 1 |

User: 190

Agent: [Shows full issue details]

Would you like to start workflow for issue #190? (y/n)

User: y

Agent: Starting workflow...
[Calls /start-from-issue 190]
```

## Integration with Other Commands

After selection:
- Call `/start-from-issue <number>` for complete workflow
- Call `/research-codebase` for issue research
- Call `/create-plan --issue <number>` for planning
- Call `/implement-plan <path>` for implementation

## Benefits

- **Quick Assessment**: Table format shows all metrics at a glance
- **Easy Filtering**: Re-filter or re-sort without reloading
- **Comment Visibility**: See which issues have discussion
- **Flexible Sorting**: Prioritize by effort, priority, or recency
- **Comprehensive View**: See all open issues, not just top 10

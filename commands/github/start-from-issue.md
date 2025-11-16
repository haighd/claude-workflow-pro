---
description: Start the complete development workflow from a GitHub Issue number
model: sonnet
---

# Start From Issue

You are tasked with orchestrating the research → plan workflow automatically starting from a GitHub Issue number.

## Initial Response

When invoked with an issue number:

```
/start-from-issue 123
```

1. **Read the GitHub Issue** using `gh issue view --json`
2. **Assess current state** - check if research/plan already exists
3. **Determine workflow path** - what steps are needed?
4. **Automatically execute** the required steps

If no issue number provided, ask for one.

## Process

### Step 1: Detect Documentation Paths

Before checking for existing documents, detect the project's documentation structure:

```bash
# Check for plugin config first, then fall back to .claude/config.json
if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
  RESEARCH_PATH=$(jq -r '.paths.research // empty' .claude-plugin-config.json)
  PLANS_PATH=$(jq -r '.paths.plans // empty' .claude-plugin-config.json)
elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
  RESEARCH_PATH=$(jq -r '.paths.research // empty' .claude/config.json)
  PLANS_PATH=$(jq -r '.paths.plans // empty' .claude/config.json)
fi

# Auto-detect paths if not configured
if [ -z "$RESEARCH_PATH" ]; then
  if [ -d "docs/research" ]; then
    RESEARCH_PATH="docs/research"
  elif [ -d "docs" ]; then
    RESEARCH_PATH="docs"
  else
    RESEARCH_PATH="docs/research"
  fi
fi

if [ -z "$PLANS_PATH" ]; then
  if [ -d "docs/implementation-plans" ]; then
    PLANS_PATH="docs/implementation-plans"
  elif [ -d "docs/plans" ]; then
    PLANS_PATH="docs/plans"
  elif [ -d "docs" ]; then
    PLANS_PATH="docs/implementation-plans"
  else
    PLANS_PATH="docs/implementation-plans"
  fi
fi

# Ensure directories exist
mkdir -p "$RESEARCH_PATH"
mkdir -p "$PLANS_PATH"
```

### Step 2: Read Issue Details

```bash
gh issue view <issue-number> --json number,title,body,labels,state,url
```

Parse the issue to extract:

- Issue number, title, description
- Current labels (especially status labels)
- Current state (open/closed)
- Any links to research/plan documents in body/comments

### Step 3: Progressive Capability Discovery

Based on issue content, determine required capabilities:

1. **Analyze issue type** from title and body:
   - Bug fix → Need codebase agents for locating issue
   - New feature → Need codebase + documentation agents
   - Refactoring → Need pattern-finder agent
   - Research task → Need web + documentation agents

2. **Load agent categories on-demand**:

   ```
   # Instead of loading all agents, discover progressively:
   Read .claude/agents/README.md for categories
   Based on issue type, explore relevant categories only
   ```

3. **Determine agent requirements**:
   - Simple bug: Load only `codebase/locator`
   - Complex feature: Load `codebase/analyzer` + `documentation/thoughts-analyzer`
   - Research task: Load `web/web-search-researcher` + relevant codebase agents

### Step 4: Assess Current State

Check what already exists:

1. **Research document linked?**
   - Search issue body/comments for links to research files
   - Look for patterns like:
     - `docs/research/`
     - `$RESEARCH_PATH/`
     - `docs/` (if research path is in docs)
     - Any markdown links to research documents
   - If found, note the path for later use

2. **Plan document linked?**
   - Search issue body/comments for links to plan files
   - Look for patterns like:
     - `docs/implementation-plans/`
     - `docs/plans/`
     - `$PLANS_PATH/`
     - `docs/` (if plans path is in docs)
     - Any markdown links to plan documents
   - If found, note the path

3. **Status labels:**
   - `status:needs-research` → Research needed
   - `status:ready-for-plan` → Plan needed
   - `status:ready-for-dev` → Plan exists, ready to implement
   - No status label → Assume research needed

### Step 5: Determine Workflow Path

**Path A: Issue needs research**

- Issue has `status:needs-research` or no research doc linked
- Action: Run `/research-codebase` for this issue

**Path B: Research exists, plan needed**

- Research doc found/linked, no plan doc
- Action: Run `/create-plan` with research doc

**Path C: Plan exists**

- Plan doc found/linked
- Action: Inform user and offer options (review, update, or proceed to implement)

**Path D: Issue is vague**

- Issue description lacks detail
- Action: Ask clarifying questions or offer to research codebase to identify issues

### Step 6: Execute Workflow

#### If Research Needed (Path A):

1. **Update issue status**: Add `status:needs-research` label if not present
2. **Run research with progressive discovery**:

   ```
   Extract key information from issue:
   - What needs to be researched?
   - What's the problem/feature?
   - What areas of codebase are relevant?

   Use progressive discovery to load only needed agents:
   - For bug fixes: Load codebase/locator first
   - For features: Load codebase/analyzer + documentation agents
   - For architecture: Load documentation/thoughts-analyzer

   Then automatically invoke /research-codebase with:
   "Research [issue topic] for issue #123.
   Problem: [issue description]
   Focus on: [relevant areas]
   Agents: [only loaded agents based on discovery]"
   ```

3. **Wait for research to complete**
4. **Link research doc to issue**:

   ```bash
   gh issue comment <issue-number> --body "Research completed: $RESEARCH_PATH/[filename]

   [Brief summary of findings]"
   ```

5. **Update issue labels**: Remove `status:needs-research`, add `status:ready-for-plan`
6. **Proceed to plan creation**

#### If Plan Needed (Path B):

1. **Read research document** (from previous step or linked in issue)
2. **Run plan creation**:
   ```
   Automatically invoke /create-plan with:
   - Research doc path
   - Issue number context
   - Issue requirements
   - --with-templates flag (if provided to start-from-issue)
   ```
3. **Wait for plan to complete**
4. **Link plan doc to issue**:

   ```bash
   gh issue comment <issue-number> --body "Implementation plan created: $PLANS_PATH/[filename]

   Plan includes [X] phases covering [summary]."
   ```

5. **Update issue labels**: Remove `status:ready-for-plan`, add `status:ready-for-dev`
6. **Update plan frontmatter** to include issue reference:
   ```yaml
   ---
   related_issue: 123
   related_research: $RESEARCH_PATH/YYYY-MM-DD-topic.md
   ---
   ```

#### If Plan Exists (Path C):

Present options to user:

```
Issue #123 already has an implementation plan.

Plan: $PLANS_PATH/[filename]

What would you like to do?
[1] Review the existing plan and start implementation
[2] Update/modify the existing plan
[3] Create a new plan (will archive the old one)
```

#### If Issue is Vague (Path D):

Ask clarifying questions:

```
Issue #123 needs more detail before I can create a plan.

Current description: "[issue description]"

Questions I need answered:
- [Specific questions based on what's missing]

Would you like to:
[1] Update the issue with more details, then retry
[2] Have me research the codebase to identify the issues
[3] Cancel and work on a different issue
```

### Step 7: Completion

After research + plan are complete:

```
✅ Research and planning complete!

Issue #123 is ready for implementation.

- Research: $RESEARCH_PATH/[filename]
- Plan: $PLANS_PATH/[filename]

Next steps:
1. Review the plan: $PLANS_PATH/[filename]
2. When ready: /implement-plan $PLANS_PATH/[filename]

Or clear context and continue later.
```

## Command Flags

Support optional flags:

**`--skip-research`**: Skip research step, go directly to planning

- Use if user already knows the issue well
- Still checks for existing research, but doesn't create new

**`--force-research`**: Force new research even if old research exists

- Creates fresh research document
- Useful if codebase has changed significantly

**`--implement`**: If plan exists, immediately start implementation

- Skips plan review
- Goes directly to `/implement-plan`

**`--with-templates`**: Create context and tasks tracking files alongside plan

- Passes flag through to `/create-plan`
- Creates: plan, context file, tasks file
- Files are pre-populated with basic information

## Error Handling

### Issue Not Found

```
Error: Issue #999 not found.
Did you mean: #123, #124, #125?
```

### Issue Already Closed

```
Issue #124 is already closed (completed 2025-11-01).

Would you like to:
[1] View the completed issue
[2] Work on a different issue
[3] Reopen this issue if work is needed
```

### Issue is Blocked

```
Issue #130 is marked as blocked (depends on #125).

Blocked by:
- Issue #125: [title] (in progress)

Would you like to:
[1] Work on unblocking issue #125 first
[2] Proceed anyway (may encounter blockers)
[3] Choose a different issue
```

### Path Detection Issues

```
⚠️  Could not detect documentation paths. Using defaults:
- Research: docs/research
- Plans: docs/implementation-plans

Run /init to set up recommended directory structure.
```

## Important Guidelines

1. **Path Detection**: Always detect paths at the start (Step 0)
2. **Directory Creation**: Ensure directories exist before saving files
3. **Automation**: This command orchestrates other commands automatically
4. **Linking**: Always link research/plan docs to issues via comments
5. **Status Updates**: Update issue labels as workflow progresses
6. **Context**: Keep user informed of progress at each step
7. **Flexibility**: Allow user to interrupt/override at any point

## Workflow Summary

```
User: /start-from-issue 123
→ Detect documentation paths
→ Read issue #123
→ Progressive capability discovery (load only needed agents)
→ Check: Research exists? Plan exists?
→ If research needed: /research-codebase (with discovered agents)
→ Link research to issue, update status
→ If plan needed: /create-plan (with research)
→ Link plan to issue, update status
→ Report: "Ready for implementation"
```

## Efficiency Improvements

With progressive discovery:

- **Before**: Load all 6-8 agents (~50KB) upfront
- **After**: Load only 2-3 relevant agents (~10-15KB)
- **Savings**: 60-70% context reduction for typical issues

Example for bug fix:

- Old approach: Load all agents (50KB)
- New approach: Load only codebase/locator (5KB)
- Context saved: 45KB (90% reduction)

This command saves the user from manually coordinating multiple commands and context clears.

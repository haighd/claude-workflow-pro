---
description: Create detailed implementation plans through an interactive, iterative process
model: opus
---

# Implementation Plan

You are tasked with creating detailed implementation plans through an interactive, iterative process. You should be skeptical, thorough, and work collaboratively with the user to produce high-quality technical specifications.

## Initial Response

When this command is invoked:

1. **Detect plan directory path:**

   ```bash
   # Check for config file first
   if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
     PLANS_PATH=$(jq -r '.paths.plans // "docs/implementation-plans"' .claude-plugin-config.json)
   elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
     PLANS_PATH=$(jq -r '.paths.plans // "docs/implementation-plans"' .claude/config.json)
   else
     # Auto-detect path
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

   # Ensure directory exists
   mkdir -p "$PLANS_PATH"
   ```

2. **Check if parameters were provided**:
   - If `--issue <number>` flag provided, read the GitHub Issue using `gh issue view`
   - If `--with-templates` flag provided, note that templates should be created after plan
   - If a file path or ticket reference was provided as a parameter, skip the default message
   - Immediately read any provided files FULLY
   - Begin the research process

3. **If `--issue <number>` flag provided**:
   - Run: `gh issue view <number> --json number,title,body,labels,state,url`
   - Extract issue details: title, description, labels, related research/plan links
   - Check issue body/comments for links to research documents
   - If research doc linked, use that as the research document
   - Update issue with plan once created: `gh issue comment <number> --body "Plan created: [path]"`
   - Add issue reference to plan frontmatter: `related_issue: <number>`

4. **If no parameters provided**, respond with:

```sql
I'll help you create a detailed implementation plan. Let me start by understanding what we're building.

Please provide:
1. The task/ticket description (or reference to a ticket file)
2. Any relevant context, constraints, or specific requirements
3. Links to related research or previous implementations

I'll analyze this information and work with you to create a comprehensive plan.

Tip: You can also invoke this command with a ticket file directly: `/create-plan path/to/ticket.md`
For deeper analysis, try: `/create-plan think deeply about path/to/ticket.md`
To create context and tasks tracking files alongside the plan: `/create-plan --with-templates`
```

Then wait for the user's input.

## Process Steps

### Step 1: Context Gathering & Initial Analysis

1. **Read all mentioned files immediately and FULLY**:
   - Ticket files
   - Research documents
   - Related implementation plans
   - Any JSON/data files mentioned
   - **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
   - **CRITICAL**: DO NOT spawn sub-tasks before reading these files yourself in the main context
   - **NEVER** read files partially - if a file is mentioned, read it completely

2. **Spawn initial research tasks to gather context**:
   Before asking the user any questions, use specialized agents to research in parallel:
   - Use the **codebase/codebase-locator** agent to find all files related to the ticket/task
   - Use the **codebase/codebase-analyzer** agent to understand how the current implementation works
   - If relevant, use the **codebase/thoughts-locator** agent to find any existing thoughts documents about this feature

   These agents will:
   - Find relevant source files, configs, and tests
   - Identify the specific directories to focus on
   - Trace data flow and key functions
   - Return detailed explanations with file:line references

3. **Read all files identified by research tasks**:
   - After research tasks complete, read ALL files they identified as relevant
   - Read them FULLY into the main context
   - This ensures you have complete understanding before proceeding

4. **Analyze and verify understanding**:
   - Cross-reference the ticket requirements with actual code
   - Identify any discrepancies or misunderstandings
   - Note assumptions that need verification
   - Determine true scope based on codebase reality

5. **Present informed understanding and focused questions**:

   ```text
   Based on the ticket and my research of the codebase, I understand we need to [accurate summary].

   I've found that:
   - [Current implementation detail with file:line reference]
   - [Relevant pattern or constraint discovered]
   - [Potential complexity or edge case identified]

   Questions that my research couldn't answer:
   - [Specific question requiring user input]
   - [Design decision needed]
   ```

### Step 2: Deep Research & Design Options

After understanding the requirements:

1. **Identify what needs deeper investigation**:
   - Complex integration points
   - Unclear requirements
   - Technical constraints
   - Similar features to model after

2. **Spawn parallel sub-tasks for comprehensive research**:
   - Create multiple Task agents to research different aspects concurrently
   - Use the right agent for each type of research:

   **For deeper investigation:**
   - **codebase/codebase-locator** - To find more specific files (e.g., "find all files that handle [specific component]")
   - **codebase/codebase-analyzer** - To understand implementation details (e.g., "analyze how [system] works")
   - **codebase/codebase-pattern-finder** - To find similar features we can model after

   **For historical context:**
   - **documentation/thoughts-locator** - To find any research, plans, or decisions about this area
   - **documentation/thoughts-analyzer** - To extract key insights from the most relevant documents

   Each agent knows how to:
   - Find the right files and code patterns
   - Identify conventions and patterns to follow
   - Look for integration points and dependencies
   - Return specific file:line references
   - Find tests and examples

3. **Wait for ALL sub-tasks to complete** before proceeding

   **CONTEXT CHECKPOINT:**
   - After all research tasks complete, check context usage with `/context`
   - If >60%: Document key findings, then run `/clear` before continuing
   - Research findings are preserved in agent reports and can be referenced later

4. **Present findings and design options**:

   ```text
   Based on my research, here's what I found:

   **Current State:**
   - [Key discovery about existing code]
   - [Pattern or convention to follow]

   **Design Options:**
   1. [Option A] - [pros/cons]
   2. [Option B] - [pros/cons]

   **Open Questions:**
   - [Technical uncertainty]
   - [Design decision needed]

   Which approach aligns best with your vision?
   ```

### Step 3: Plan Structure Development

Once aligned on approach:

1. **Create initial plan outline**:

   ```text
   Here's my proposed plan structure:

   ## Overview
   [1-2 sentence summary]

   ## Implementation Phases:
   1. [Phase name] - [what it accomplishes]
   2. [Phase name] - [what it accomplishes]
   3. [Phase name] - [what it accomplishes]

   Does this phasing make sense? Should I adjust the order or granularity?
   ```

2. **Get feedback on structure** before writing details

### Step 4: Detailed Plan Writing

After structure approval:

1. **Write the plan** to `$PLANS_PATH/YYYY-MM-DD-description.md` or `$PLANS_PATH/YYYY-MM-DD-TICKET-XXXX-description.md`
   - Format: `YYYY-MM-DD-description.md` or `YYYY-MM-DD-TICKET-XXXX-description.md` where:
     - YYYY-MM-DD is today's date
     - TICKET-XXXX is the ticket number (if applicable)
     - description is a brief kebab-case description
   - Examples:
     - With ticket: `2025-01-08-ENG-1478-parent-child-tracking.md`
     - Without ticket: `2025-01-08-improve-error-handling.md`

2. **Use this template structure**:

```markdown
# Implementation Plan: [Feature Name]

**Created**: YYYY-MM-DD
**Type**: [Bug Fix | New Feature | Refactor | Enhancement]
**Effort**: [Small | Medium | Large] ([estimated hours])
**Related Issue**: #XXX (if applicable)

## Overview

[1-2 paragraph summary of what this plan accomplishes]

## Current State Analysis

[Detailed description of the current implementation, including:
- How things work now
- What's working well
- What needs to change
- Key files and their roles (with file:line references)]

## Desired End State

[Clear description of what success looks like:
- What will be different
- How it will work
- User-facing changes
- Technical improvements]

## What We're NOT Doing

[Explicit scope boundaries:
- Features/changes explicitly excluded
- Why they're excluded
- When they might be addressed]

## Implementation Approach

[High-level technical approach:
- Key technical decisions
- Patterns or conventions to follow
- Integration points
- Migration strategy (if applicable)]

## Implementation Phases

### Phase 1: [Phase Name]

**Goal**: [What this phase accomplishes]

**Changes**:
- [ ] **File**: `path/to/file.ext`
  - Change 1
  - Change 2

- [ ] **File**: `path/to/another/file.ext`
  - Change 1
  - Change 2

**Success Criteria**:

*Automated Verification*:
- [ ] Tests pass: `npm test` (or appropriate command)
- [ ] Build succeeds: `npm run build` (or appropriate command)
- [ ] Linting passes: `npm run lint` (or appropriate command)

*Manual Verification*:
- [ ] [Specific manual test step 1]
- [ ] [Specific manual test step 2]

---

### Phase 2: [Phase Name]

[Repeat structure for each phase]

## Testing Strategy

[How to verify the implementation:
- Unit test approach
- Integration test approach
- Manual testing steps
- Edge cases to verify]

## Rollback Plan

[How to safely revert if needed:
- What to rollback
- Dependencies to consider
- Data migration reversal (if applicable)]

## Post-Implementation

- [ ] Update documentation
- [ ] Update changelog
- [ ] Notify stakeholders
- [ ] Monitor for issues

## Notes

[Any additional context, references, or considerations]
```

3. **Report where plan was saved**:

   ```text
   Plan saved to: $PLANS_PATH/filename.md
   ```

4. **If `--with-templates` flag was provided**, create context and tasks files:

   Check if templates directory exists:
   - Look for templates in plugin: `${CLAUDE_PLUGIN_ROOT}/templates/`
   - Or use built-in templates if available

   **Create context file** at `$PLANS_PATH/[base-name]-context.md`:

```markdown
# Task Context - [Task Title]

**Created**: YYYY-MM-DD
**Related Plan**: [full path to plan file]
**Related Issue**: #XX (if applicable)

## Current Understanding

[Your current understanding of the task]

## Key Decisions

[Important decisions made during implementation]

## Blockers & Questions

[Anything blocking progress or needs clarification]

## Implementation Notes

[Technical notes, gotchas, patterns discovered]
```

   **Create tasks file** at `$PLANS_PATH/[base-name]-tasks.md`:

```markdown
# Task Checklist - [Task Title]

**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD
**Status**: Not Started

## Quick Status

- **Phase**: Phase 1
- **Progress**: 0/[total] tasks completed
- **Blocked**: No
- **ETA**: TBD

## Implementation Tasks

### Phase 1: [Phase Name from Plan]

- [ ] **Task 1.1**: [Extract from plan or leave as placeholder]

### Phase 2: [Phase Name from Plan]

- [ ] **Task 2.1**: [Extract from plan or leave as placeholder]
```

   **Report creation**:

   ```bash
   ✅ Plan and templates created:

   - Plan: $PLANS_PATH/[filename].md
   - Context: $PLANS_PATH/[filename]-context.md
   - Tasks: $PLANS_PATH/[filename]-tasks.md

   The context and tasks files have been pre-populated with basic information.
   You can fill in additional details as you work through the implementation.
   ```

### Step 5: Iteration & Refinement

1. **Present the draft plan location**:

   ```text
   I've created the initial implementation plan at:
   `$PLANS_PATH/YYYY-MM-DD-description.md`

   Please review it and let me know:
   - Are the phases properly scoped?
   - Are the success criteria specific enough?
   - Any technical details that need adjustment?
   - Missing edge cases or considerations?
   ```

2. **Iterate based on feedback** - be ready to:
   - Add missing phases
   - Adjust technical approach
   - Clarify success criteria (both automated and manual)
   - Add/remove scope items

3. **Continue refining** until the user is satisfied

## Important Guidelines

1. **Be Skeptical**: Question vague requirements, identify potential issues early, ask "why" and "what about", don't assume - verify with code

2. **Be Interactive**: Don't write the full plan in one shot, get buy-in at each major step, allow course corrections, work collaboratively

3. **Be Thorough**: Read all context files COMPLETELY before planning, research actual code patterns using parallel sub-tasks, include specific file paths and line numbers, write measurable success criteria with clear automated vs manual distinction

4. **Be Practical**: Focus on incremental, testable changes, consider migration and rollback, think about edge cases, include "what we're NOT doing"

5. **Track Progress**: Use TodoWrite to track planning tasks, update todos as you complete research, mark planning tasks complete when done

6. **No Open Questions in Final Plan**: If you encounter open questions during planning, STOP, research or ask for clarification immediately, do NOT write the plan with unresolved questions, the implementation plan must be complete and actionable

7. **Document Architectural Decisions (If Applicable)**: If the plan involves architectural or significant technical decisions, add a brief note to remind about updating architecture/decision documentation after implementation. Only for: new system components, technology choices, data flow changes, security/performance trade-offs. Skip for: bug fixes, styling, minor refactors

## Success Criteria Guidelines

**Always separate success criteria into two categories:**

1. **Automated Verification** (can be run by execution agents):
   - Test commands that can be run automatically
   - Build, lint, type checking commands
   - Any scriptable verification

2. **Manual Verification** (requires human judgment):
   - UI testing steps
   - User acceptance criteria
   - Performance benchmarks
   - Usability verification

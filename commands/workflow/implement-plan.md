---
description: "Instructions for implementing approved technical plans."
model: sonnet
---

# Implement Plan

You are tasked with implementing an approved technical plan. These plans contain phases with specific changes and success criteria.

## Process

### Step 1: Read and Understand the Plan

When given a plan path:

- Read the plan completely and check for any existing checkmarks (- [x])
- Check if plan has a related GitHub Issue number (in frontmatter or comments)
- Read the original ticket and all files mentioned in the plan
- **Read files fully** - never use limit/offset parameters, you need complete context
- Think deeply about how the pieces fit together
- Create a todo list to track your progress
- Create a new feature branch for this work (or use existing branch if specified)
- Start implementing if you understand what needs to be done

If no plan path provided, ask for one.

### Step 2: Branch Management

When starting implementation:

1. **Detect base branch** from config or use default:

   ```bash
   # Check for config file
   if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
     BASE_BRANCH=$(jq -r '.workflow.baseBranch // "main"' .claude-plugin-config.json)
   elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
     BASE_BRANCH=$(jq -r '.workflow.baseBranch // "main"' .claude/config.json)
   else
     BASE_BRANCH="main"
   fi
   ```

2. **Create feature branch** (if not already on one):

   ```bash
   # If plan has issue number, use it in branch name
   git checkout -b feature/123-short-description
   # Or without issue number
   git checkout -b feature/short-description
   ```

## Issue Tracking Integration

When implementing a plan:

1. **Link to Issue**: If plan references a GitHub Issue number (#123), include in commit messages:

   ```bash
   git commit -m "feat: implement [feature]

   Closes #123

   See: docs/implementation-plans/[plan-file].md"
   ```

2. **Branch Naming**: If issue number is known, create branch with issue number for automatic GitHub linking

3. **Creating Discovery Issues**: If you discover issues during implementation:

   ```bash
   gh issue create \
     --title "[Discovery] Brief description" \
     --label "discovery" \
     --body "Discovered while working on #123:
   - [Description]
   - File: \`path/to/file.ext:123\`
   - Will investigate after completing current task"
   ```

4. **Update Issue Status**: If issue exists, update status to in-progress:
   ```bash
   gh issue edit <issue-number> --add-label "status:in-progress"
   ```

## Implementation Philosophy

Plans are carefully designed, but reality can be messy. Your job is to:

- Follow the plan's intent while adapting to what you find
- Implement each phase fully before moving to the next
- Verify your work makes sense in the broader codebase context
- Update checkboxes in the plan as you complete sections

When things don't match the plan exactly, think about why and communicate clearly. The plan is your guide, but your judgment matters too.

If you encounter a mismatch:

- STOP and think deeply about why the plan can't be followed
- Present the issue clearly:

  ```bash
  Issue in Phase [N]:
  Expected: [what the plan says]
  Found: [actual situation]
  Why this matters: [explanation]

  How should I proceed?
  ```

## Verification Approach

After implementing a phase:

- Run the success criteria checks (automated tests, build, lint commands)
- Fix any issues before proceeding
- Update your progress in both the plan and your todos
- Check off completed items in the plan file itself using Edit
- **Pause for human verification**: After completing all automated verification for a phase, pause and inform the human that the phase is ready for manual testing. Use this format:

  ```bash
  Phase [N] Complete - Ready for Manual Verification

  Automated verification passed:
  - [List automated checks that passed]

  Please perform the manual verification steps listed in the plan:
  - [List manual verification items from the plan]

  Let me know when manual testing is complete so I can proceed to Phase [N+1].
  ```

If instructed to execute multiple phases consecutively, skip the pause until the last phase. Otherwise, assume you are just doing one phase.

Do not check off items in the manual testing steps until confirmed by the user.

## TDD Workflow

For test-driven development:

1. **Write tests first** before implementing functionality
2. **Run tests** to verify they fail (red)
3. **Implement** the minimum code to pass tests (green)
4. **Refactor** while keeping tests green
5. **Commit** with tests and implementation together

## If You Get Stuck

When something isn't working as expected:

- First, make sure you've read and understood all the relevant code
- Consider if the codebase has evolved since the plan was written
- Present the mismatch clearly and ask for guidance

Use sub-tasks sparingly - mainly for targeted debugging or exploring unfamiliar territory.

## Resuming Work

If the plan has existing checkmarks:

- Trust that completed work is done
- Pick up from the first unchecked item
- Verify previous work only if something seems off

## Commit Guidelines

- Make atomic commits for each logical change
- Use conventional commit format if configured
- Reference issue numbers in commit messages
- Include plan file path in commit body for traceability

## Best Practices

1. **Read the full plan** before starting
2. **Understand the "why"** behind each phase
3. **Test thoroughly** at each phase
4. **Update the plan** as you complete items
5. **Communicate blockers** immediately
6. **Respect the phasing** - don't skip ahead

Remember: You're implementing a solution, not just checking boxes. Keep the end goal in mind and maintain forward momentum.

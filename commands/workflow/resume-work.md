# Resume Work

Resume work after a break, context clear, or session handoff.

## Step 0: Check for Checkpoints (Automatic)

**Before asking for input**, check for saved checkpoints:

```bash
# Detect checkpoint directory
if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
  CHECKPOINTS_PATH=$(jq -r '.paths.sessions // "docs/sessions"' .claude-plugin-config.json)
elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
  CHECKPOINTS_PATH=$(jq -r '.paths.checkpoints // "docs/sessions"' .claude/config.json)
else
  if [ -d "docs/sessions" ]; then
    CHECKPOINTS_PATH="docs/sessions"
  else
    CHECKPOINTS_PATH="docs/sessions"
  fi
fi

# Find most recent checkpoint
LATEST_CHECKPOINT=$(ls -t "$CHECKPOINTS_PATH"/*-checkpoint.md 2>/dev/null | head -1)
```

**If checkpoint found**:
1. Read it completely
2. Present summary to user:
   ```text
   Found saved checkpoint from [date/time]:

   Context: [brief description]
   Completed: [X tasks]
   Next: [immediate next step]

   Continue from this checkpoint? (or provide different document path)
   ```

3. If user confirms, use checkpoint as the document
4. If user provides different path, use that instead

**If no checkpoint found**:
- Ask user for document path

## Input Required

The user will provide a path to a checkpoint, plan, or progress document. This document contains all context about previous work.

## Step 1: Read and Analyze the Plan Document

Read the provided document completely. It should contain:
- Session overview (completed tasks, current status)
- Technical context (modified files, decisions, failed approaches, working patterns)
- Immediate next steps
- Remaining work and dependencies
- Environment and setup information

## Step 2: Build Mental Model

Based on the document, establish:
- **Primary Goal**: What is the overall objective?
- **Current State**: Where exactly did the previous session leave off?
- **Next Action**: What is the immediate next step?
- **Context**: What decisions or approaches are important to maintain?

## Step 3: Verify Environment Setup

Check the documented environment requirements:
- Confirm correct git branch
- Verify any required services are running
- Check test status if mentioned
- Note any setup prerequisites

## Step 4: Present Understanding

Provide a clear summary showing:
1. **What I understand we're working on**: Brief description of the goal
2. **Current status**: What's been completed and what's in progress
3. **Immediate next steps**: The specific tasks I'll begin with
4. **Any questions or concerns**: Anything unclear or that needs clarification

Format this as a concise summary, NOT a repetition of the entire document.

## Step 5: Get Confirmation

Ask:
- "Does this match your understanding?"
- "Should I proceed with [specific next step], or is there anything you want to adjust?"

## Step 6: Begin Work

Once confirmed:
- Use TodoWrite to create a task list based on immediate next steps
- Begin executing the first task
- Follow all normal development practices (TDD, git commits, etc.)

## Important Principles

- **Assume Zero Prior Knowledge**: You have NO memory of previous conversations. Everything you know comes from the document.
- **Don't Reinvent**: Respect documented decisions, patterns, and approaches unless there's a clear technical reason to change
- **Ask Don't Assume**: If something is unclear or missing, ask rather than guessing
- **Maintain Continuity**: This is continuing existing work, not starting fresh

## What NOT To Do

- Don't suggest rewriting or refactoring unless the document specifically identifies a problem
- Don't question past technical decisions unless they're clearly blocking progress
- Don't start by reading all the code - use the document's context to focus your attention
- Don't ignore "failed approaches" sections - they save time by documenting what doesn't work

## Output Format

After reading the document, provide:

```text
## Work Resumption Summary

**Goal**: [One line description]

**Status**: [Brief current state]

**Completed**:
- [Key accomplishment 1]
- [Key accomplishment 2]

**Next Steps**:
1. [Immediate next action]
2. [Following action]
3. [Subsequent action]

**Questions/Concerns**:
- [Any unclear points or concerns]

Ready to proceed with step 1?
```

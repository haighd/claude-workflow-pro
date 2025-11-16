---
description: Save session progress before clearing context
model: haiku
---

# Checkpoint

Save current session progress to resume later after context clearing.

## When to Use

- Context usage reaches 60% (check with `/context`)
- Before planned context clearing
- End of work session with incomplete tasks
- Before switching to a different task/feature

## Process

### Step 1: Detect Checkpoint Directory

```bash
# Check for config file first
if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
  CHECKPOINTS_PATH=$(jq -r '.paths.sessions // "docs/sessions"' .claude-plugin-config.json)
elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
  CHECKPOINTS_PATH=$(jq -r '.paths.checkpoints // "docs/sessions"' .claude/config.json)
else
  # Auto-detect path
  if [ -d "docs/sessions" ]; then
    CHECKPOINTS_PATH="docs/sessions"
  elif [ -d "docs" ]; then
    CHECKPOINTS_PATH="docs/sessions"
  else
    CHECKPOINTS_PATH="docs/sessions"
  fi
fi

# Ensure directory exists
mkdir -p "$CHECKPOINTS_PATH"
```

### Step 2: Gather Context

Collect the following information:

1. **Current branch and uncommitted changes**:

   ```bash
   git branch --show-current
   git status --short
   ```

2. **Active todos** (from TodoWrite):
   - What tasks are in_progress?
   - What tasks are pending?

3. **Recent file changes**:

   ```bash
   git diff --name-only HEAD
   git ls-files --others --exclude-standard
   ```

4. **Key decisions made** during this session

### Step 3: Create Checkpoint Document

Create file: `$CHECKPOINTS_PATH/YYYY-MM-DD-HHMM-checkpoint.md`

Use this template:

```markdown
# Session Checkpoint - YYYY-MM-DD HH:MM

## Status

**Branch**: [current branch]
**Context**: [brief description of what you're working on]
**Issue/PR**: [if applicable]

## What's Done

- [completed task 1]
- [completed task 2]
- ...

## What's Next

**Immediate next step**: [the very next thing to do]

**Remaining tasks**:

- [ ] [task 1]
- [ ] [task 2]
- ...

## Key Files

### Modified Files

- `path/to/file1.ts` - [what was changed]
- `path/to/file2.ts` - [what was changed]

### Important Files for Context

- `path/to/file3.ts` - [why this matters]
- `path/to/file4.ts` - [why this matters]

## Key Decisions

- **Decision 1**: [what was decided and why]
- **Decision 2**: [what was decided and why]

## Blockers/Issues

[Any blockers, open questions, or issues encountered]

## Notes

[Any other important context, patterns discovered, etc.]

## To Resume

1. Read this checkpoint file
2. Run `git status` to verify branch state
3. Read key files listed above
4. Continue with "What's Next" tasks
```

### Step 4: Save and Confirm

```bash
# Save the checkpoint file
echo "Checkpoint saved to: $CHECKPOINTS_PATH/YYYY-MM-DD-HHMM-checkpoint.md"

# Optionally commit the checkpoint
git add "$CHECKPOINTS_PATH/YYYY-MM-DD-HHMM-checkpoint.md"
git commit -m "chore: save session checkpoint"
```

### Step 5: Inform User

```bash
✅ Session checkpoint saved!

File: $CHECKPOINTS_PATH/YYYY-MM-DD-HHMM-checkpoint.md

You can now:
- Run `/clear` to reset context
- Run `/resume-work` later to continue from this checkpoint
- Switch to a different task

The checkpoint includes:
- Task status (X done, Y remaining)
- Key files and decisions
- Next steps
```

## Integration with Other Commands

### `/resume-work` Integration

The `/resume-work` command should:

1. Check for checkpoints in `$CHECKPOINTS_PATH/`
2. Find the most recent checkpoint
3. Read it fully
4. Present summary to user
5. Ask if they want to continue from this checkpoint

### High-Token Commands

Commands that typically consume significant context should remind about checkpointing:

```markdown
**Context checkpoint reminder**: If context >60%, run `/checkpoint` then `/clear` before continuing.
```

Add this reminder to:

- `/research-codebase`
- `/create-plan`
- `/implement-plan`

## Best Practices

1. **Checkpoint frequency**: Every 60% context usage or major task completion
2. **Commit checkpoints**: Git commit them so they're part of project history
3. **Be specific**: "Next step" should be immediately actionable
4. **List key files**: Include both modified and important context files
5. **Document decisions**: Capture the "why" behind choices made

## Error Handling

### Common Issues and Solutions

**Issue: Cannot create checkpoint directory**

```bash
# Check if directory exists and is writable
if [ ! -d "docs/sessions" ]; then
  mkdir -p docs/sessions
fi

# If permission denied:
# Report: "Unable to create checkpoint directory. Please check permissions for docs/sessions/"
```

**Issue: Checkpoint file already exists**

```bash
# If file exists with same timestamp
# Options:
# 1. Add suffix: 2025-11-15-1500-checkpoint-v2.md
# 2. Ask user if they want to overwrite
# 3. Increment timestamp by 1 minute
```

**Issue: Unable to determine session path**

```bash
# Fallback logic:
# 1. Check .claude-plugin-config.json
# 2. Check .claude/config.json
# 3. Default to docs/sessions/
# 4. If all fail, use current directory: ./checkpoint-{timestamp}.md

# Report location to user
```

**Issue: Git not initialized**

```bash
# Check git status
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  # Report: "This is not a git repository. Checkpoint created but cannot be committed."
  # Suggestion: "Run 'git init' to enable checkpoint version control."
fi
```

**Issue: Context too large to summarize**

If conversation history is very large:
- Focus on last major task/milestone
- Summarize older work in bullet points
- Reference previous checkpoints by filename
- Keep "Next Steps" section detailed and specific

**Issue: No clear completion point**

If work is mid-task:
- Document current state clearly
- Note what's partially complete
- List blockers or unknowns
- Provide exact next command or action

### Verification Steps

After creating checkpoint:

```bash
# Verify file was created
ls -lh docs/sessions/*-checkpoint.md | tail -1

# Verify file is readable
head -5 docs/sessions/[checkpoint-file].md

# Verify file size is reasonable (>100 bytes)
# If file is too small, may indicate incomplete write
```

## Implementation Notes

- Checkpoints are markdown files for easy reading and editing
- Store in `docs/sessions/` by default (configurable via `.claude-plugin-config.json`)
- Commit checkpoints to git for project history
- `/resume-work` automatically discovers and reads latest checkpoint
- ALWAYS verify that you've **actually created** the checkpoint file before announcing its creation

## Troubleshooting

**Checkpoint not found by /resume-work:**
- Verify file follows naming pattern: `*-checkpoint.md`
- Check file is in correct directory (docs/sessions/ by default)
- Ensure file has `.md` extension
- Verify no typos in filename

**Checkpoint file is empty or corrupted:**
- Check disk space: `df -h`
- Verify write permissions: `ls -ld docs/sessions/`
- Re-create checkpoint if needed
- Keep previous checkpoints as backup

**Cannot determine what to checkpoint:**
- Review conversation history
- Check git log for recent commits
- List modified files: `git status`
- Ask user what they want captured

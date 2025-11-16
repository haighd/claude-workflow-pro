# Team Handoff

Transfer work context and progress to another team member with complete workflow state.

## Purpose

Enable seamless work handoffs between team members by packaging and transferring complete workflow context, progress, and knowledge.

## Usage

```bash
/team/handoff <command> [options]
```

## Commands

### Create Handoff

```bash
/team/handoff create --to=@teammate [--message="notes"]
```

Creates a comprehensive handoff package.

### Receive Handoff

```bash
/team/handoff receive <handoff-id>
```

Receive and load a handoff package.

### List Handoffs

```bash
/team/handoff list [--from=@user] [--to=@user]
```

## What's Included in Handoff

1. **Workflow State**
   - Current branch and uncommitted changes
   - Active checkpoints
   - Workflow plans and progress
   - Todo lists and task status

2. **Context**
   - Work summary and goals
   - Decisions made
   - Open questions
   - Blockers and dependencies

3. **Knowledge**
   - Relevant documentation links
   - Code annotations
   - Learning resources
   - Best practices applied

4. **Technical Details**
   - Environment setup
   - Configuration changes
   - Test status
   - Deployment notes

## Example Handoff

```bash
$ /team/handoff create --to=@sarah --message="Implemented OAuth2 core, token refresh remaining"

Creating handoff package...

📦 Handoff Package Created

Handoff ID: handoff-20251116-oauth2
From: @john
To: @sarah

Included:
  ✓ Current branch: feature/oauth2
  ✓ 3 checkpoints
  ✓ Workflow plan (60% complete)
  ✓ 5 uncommitted files
  ✓ 8 code annotations
  ✓ Environment setup notes
  ✓ 12 relevant docs links
  ✓ Test status (15/18 passing)

Summary:
  Implemented OAuth2 core functionality.
  Token refresh still needs implementation.

Next steps:
  1. Implement token refresh logic
  2. Fix 3 failing tests
  3. Add integration tests
  4. Update documentation

Share with @sarah:
  https://claude-workflow.dev/handoff/handoff-20251116-oauth2
```

## Configuration

```json
{
  "handoff": {
    "include": {
      "uncommitted-changes": true,
      "checkpoints": true,
      "plans": true,
      "annotations": true,
      "environment-setup": true,
      "test-results": true
    },
    "privacy": {
      "exclude-sensitive": true,
      "sanitize-secrets": true
    },
    "expiration": "7 days",
    "notifications": {
      "notify-recipient": true,
      "channel": "slack"
    }
  }
}
```

## Related Commands

- `/team/pair-program` - Pair programming
- `/workflow/checkpoint` - Create checkpoints
- `/workflow/resume-work` - Resume from checkpoint

---

**Command Type:** Team Collaboration
**Version:** 1.0.0

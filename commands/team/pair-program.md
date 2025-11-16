# Team Pair Programming

Facilitate pair programming sessions with synchronized workflows and shared context.

## Purpose

Enable effective pair programming by sharing workflow state, synchronizing checkpoints, and maintaining collaborative context across team members.

## Usage

```bash
/team/pair-program <command> [options]
```

## Commands

### Start Session

```bash
/team/pair-program start --with=@teammate [--role=driver|navigator]
```

Starts a new pair programming session.

**Parameters:**
- `--with` - GitHub username of pair partner
- `--role` - Your role (driver writes code, navigator reviews)
- `--topic` - Session topic/feature being worked on

### Join Session

```bash
/team/pair-program join <session-id>
```

Join an existing pair programming session.

### Sync State

```bash
/team/pair-program sync
```

Synchronize current workflow state with pair partner.

### Switch Roles

```bash
/team/pair-program switch
```

Switch driver and navigator roles.

### End Session

```bash
/team/pair-program end [--summary]
```

End the current pair programming session.

**Options:**
- `--summary` - Generate session summary

## What It Does

### Session Management

1. **Initialize Session**
   - Create shared session space
   - Sync initial context
   - Establish communication channel
   - Set up real-time sync

2. **State Synchronization**
   - Share current branch
   - Sync checkpoints
   - Share workflow plans
   - Sync file changes

3. **Role Management**
   - Track driver/navigator roles
   - Facilitate role switching
   - Maintain session history

4. **Collaboration Tools**
   - Shared code annotations
   - Real-time change visibility
   - Checkpoint sharing
   - Plan synchronization

## Configuration

### Pair Programming Settings

Create `.claude-pair.json`:

```json
{
  "sessions": {
    "auto-sync-interval": 30,
    "sync-on-checkpoint": true,
    "sync-on-commit": true,
    "share-uncommitted-changes": false
  },
  "roles": {
    "switch-interval": 25,
    "switch-reminder": true,
    "enforce-switching": false
  },
  "communication": {
    "integrated-chat": false,
    "external-tool": "slack",
    "notifications": true
  },
  "sync": {
    "auto-sync": true,
    "sync-items": [
      "checkpoints",
      "plans",
      "annotations",
      "branch-state"
    ],
    "conflict-resolution": "prompt"
  },
  "privacy": {
    "share-file-contents": true,
    "share-git-history": true,
    "share-environment-vars": false
  }
}
```

## Pair Programming Workflow

### Example Session

```bash
# Developer A (Driver) starts session
$ /team/pair-program start --with=@developerB --role=driver --topic="Add OAuth2"

Output:
🤝 Starting pair programming session

Session ID: pair-2025-11-16-oauth2
Topic: Add OAuth2
Driver: @developerA
Navigator: @developerB

Session started!
Share session ID with @developerB to join.

Sync URL: https://claude-workflow.dev/pair/pair-2025-11-16-oauth2

# Developer B (Navigator) joins
$ /team/pair-program join pair-2025-11-16-oauth2

Output:
🤝 Joined pair programming session

Session: pair-2025-11-16-oauth2
Topic: Add OAuth2
Driver: @developerA (driving)
Navigator: @developerB (you)

Syncing state...
✓ Branch synced: feature/oauth2
✓ Latest checkpoint loaded: oauth2-planning-complete
✓ Workflow plan synced
✓ Current file: src/auth/oauth2.js

Ready to navigate!

# Auto-sync checkpoint when driver creates one
$ /workflow/checkpoint "oauth2-core-implemented"

Output (Developer A):
Checkpoint created: oauth2-core-implemented

Output (Developer B - auto-notification):
🔔 Pair partner created checkpoint: oauth2-core-implemented
   Sync? [Y/n]: y
   ✓ Checkpoint synced

# Switch roles after 25 minutes
$ /team/pair-program switch

Output:
🔄 Switching roles

Previous:
  Driver: @developerA
  Navigator: @developerB

Current:
  Driver: @developerB
  Navigator: @developerA

@developerB is now driving.
@developerA is now navigating.

Commit current work before switching? [Y/n]: y
✓ Work committed
✓ Roles switched
✓ @developerB can now push code

# End session
$ /team/pair-program end --summary

Output:
🤝 Ending pair programming session

Session: pair-2025-11-16-oauth2
Duration: 2 hours 15 minutes
Role switches: 5

Summary:
  ✓ 3 checkpoints created
  ✓ 8 commits made
  ✓ 12 files changed (+450, -120 lines)
  ✓ OAuth2 core functionality implemented

Participants:
  @developerA - 1h 10m as driver, 1h 5m as navigator
  @developerB - 1h 5m as driver, 1h 10m as navigator

Session log saved: .claude/sessions/pair-2025-11-16-oauth2.md

Great work! 🎉
```

## Session Features

### Real-Time Synchronization

```bash
# When driver makes changes
Developer A: Editing src/auth/oauth2.js

Developer B sees:
🔔 @developerA is editing src/auth/oauth2.js
   View changes? [Y/n]: y

   [Shows live diff]

# When driver creates checkpoint
Developer A: /workflow/checkpoint "oauth2-token-refresh"

Developer B sees:
🔔 Checkpoint created: oauth2-token-refresh
   Description: Implement token refresh logic
   Sync now? [Y/n]
```

### Shared Annotations

```bash
# Navigator adds code annotation
$ /team/pair-program annotate src/auth/oauth2.js:45 \
  "Consider caching the token"

Output (Driver sees):
📝 @developerB added annotation:
   File: src/auth/oauth2.js:45
   Note: Consider caching the token

# Driver responds
$ /team/pair-program respond "Good idea, adding now"

Output (Navigator sees):
💬 @developerA: Good idea, adding now
```

### Shared Plans

```bash
# Plans are automatically synced
Developer A: /workflow/create-plan

Plan created: oauth2-implementation

Developer B sees:
🔔 @developerA created plan: oauth2-implementation
   View plan? [Y/n]: y

   [Shows plan details]

# Both can update plan
Developer B: /workflow/update-plan --add="Add token caching"

Developer A sees:
🔔 @developerB updated plan
   Added task: Add token caching
```

### Role-Based Permissions

```javascript
// Driver permissions
- Write code
- Commit changes
- Create checkpoints
- Execute commands

// Navigator permissions
- Read code
- Add annotations
- Suggest changes
- Review commits
- Sync checkpoints

// Switching roles transfers all permissions
```

## Advanced Features

### Async Pair Programming

For different time zones:

```bash
# Developer A works and creates checkpoints
$ /team/pair-program start --with=@developerB --async

# Developer B can review and continue later
$ /team/pair-program join pair-session-id
$ /team/pair-program review
  Shows: All changes since last sync

$ /team/pair-program continue
  Takes over as driver
```

### Mob Programming

More than 2 developers:

```bash
# Start mob session
$ /team/pair-program start --with=@dev2,@dev3,@dev4 --mode=mob

Roles:
  Driver: @dev1
  Navigators: @dev2, @dev3, @dev4

# Rotate through all developers
$ /team/pair-program rotate
  Driver: @dev2 (next in rotation)
  Navigators: @dev1, @dev3, @dev4
```

### Session Recording

```bash
# Enable session recording
$ /team/pair-program start --record

Records:
- All code changes
- Checkpoint history
- Role switches
- Annotations
- Communication
- Time spent

# Review session later
$ /team/pair-program replay pair-session-id
  Plays back entire session
```

### Remote Pair Programming

Integration with video/screen sharing:

```json
{
  "remote": {
    "enabled": true,
    "video": {
      "provider": "zoom",
      "auto-start": true
    },
    "screen-share": {
      "provider": "screen-share-tool",
      "auto-start": false
    },
    "audio": {
      "provider": "discord",
      "channel": "#pairing"
    }
  }
}
```

## Metrics and Analytics

### Session Metrics

```bash
$ /team/pair-program stats

Pair Programming Statistics (Last 30 days):

Sessions: 15
Total time: 32 hours
Avg session: 2h 8m

Partners:
  @developerB: 8 sessions, 18 hours
  @developerC: 5 sessions, 10 hours
  @developerD: 2 sessions, 4 hours

Productivity:
  Commits per session: 6.5
  Lines added per hour: 145
  Issues resolved: 23

Most productive pairs:
  1. @developerA + @developerB: 12 features completed
  2. @developerA + @developerC: 8 bugs fixed
  3. @developerA + @developerD: 2 refactorings done

Best practices:
  ✓ Role switching every 23 minutes (avg)
  ✓ Checkpoints every 35 minutes (avg)
  ✓ High navigator engagement: 87%
```

### Team Analytics

```bash
$ /team/pair-program team-stats

Team Pair Programming Report:

Team size: 8 developers

Pairing frequency:
  @dev1: 15 sessions (highest)
  @dev2: 12 sessions
  @dev3: 10 sessions
  @dev4: 8 sessions
  @dev5: 5 sessions
  @dev6: 3 sessions
  @dev7: 2 sessions
  @dev8: 1 session

Knowledge sharing:
  Cross-team pairing: 45%
  Same-team pairing: 55%

  Skills transferred:
    - OAuth2 implementation: 5 developers
    - Database optimization: 4 developers
    - Testing patterns: 6 developers

Quality metrics:
  Bugs in paired code: -60% vs solo
  Code review time: -40% vs solo
  Knowledge retention: +75% vs solo
```

## Best Practices

### Driver Responsibilities

```markdown
As driver:
- [ ] Write code based on navigator's guidance
- [ ] Think out loud while coding
- [ ] Ask questions when unclear
- [ ] Create checkpoints regularly
- [ ] Commit working code frequently
- [ ] Switch roles on schedule
- [ ] Share screen (remote pairing)
```

### Navigator Responsibilities

```markdown
As navigator:
- [ ] Review code as it's written
- [ ] Suggest improvements
- [ ] Think about edge cases
- [ ] Consider architecture
- [ ] Look up documentation
- [ ] Add helpful annotations
- [ ] Keep driver on track
- [ ] Watch for errors/typos
```

### Session Best Practices

```markdown
Before session:
- [ ] Define clear goal
- [ ] Estimate duration
- [ ] Agree on roles
- [ ] Set up environment
- [ ] Align on approach

During session:
- [ ] Take breaks (every hour)
- [ ] Switch roles regularly (20-25 min)
- [ ] Checkpoint progress
- [ ] Stay engaged
- [ ] Communicate clearly

After session:
- [ ] Create summary
- [ ] Update tickets
- [ ] Schedule follow-up (if needed)
- [ ] Share learnings
```

## Examples

### Feature Development Session

```bash
$ /team/pair-program start --with=@sarah --topic="User authentication"

[2 hour session]
  ✓ Implemented login flow
  ✓ Added JWT tokens
  ✓ Created tests
  ✓ Updated documentation

$ /team/pair-program end --summary

Session Summary:
  Feature: User authentication
  Status: Complete
  Commits: 12
  Tests added: 8
  Coverage: +15%
```

### Bug Fix Session

```bash
$ /team/pair-program start --with=@john --topic="Fix login redirect bug"

[45 minute session]
  ✓ Reproduced bug
  ✓ Identified root cause
  ✓ Implemented fix
  ✓ Added regression test

$ /team/pair-program end

Bug fixed collaboratively in 45 minutes!
```

### Code Review Session

```bash
$ /team/pair-program start --with=@lisa --mode=review --topic="Review PR #456"

[1 hour review session]
  ✓ Reviewed all changes
  ✓ Added 8 code comments
  ✓ Suggested 3 improvements
  ✓ Approved PR

$ /team/pair-program end

Thorough code review completed together.
```

## Troubleshooting

### Sync Issues

```bash
# Manual re-sync
$ /team/pair-program sync --force

# Check sync status
$ /team/pair-program status
  Sync status: Connected
  Last sync: 2 minutes ago
  Partner status: Active
```

### Conflict Resolution

```bash
# When both make changes
$ /team/pair-program resolve

Conflict detected:
  File: src/auth.js
  Your changes: Lines 45-50
  Partner changes: Lines 48-52

Resolution options:
  1. Keep your changes
  2. Keep partner changes
  3. Merge both
  4. Manual resolve

Choose [1-4]:
```

## Related Commands

- `/workflow/checkpoint` - Create checkpoints (auto-synced)
- `/workflow/create-plan` - Create plans (auto-shared)
- `/development/code-review` - Review code together
- `/team/handoff` - Hand off work to teammate

## See Also

- Pair programming best practices
- Remote collaboration tools
- Team workflow patterns
- Knowledge sharing strategies

---

**Command Type:** Team Collaboration
**Agent Used:** collaboration-agent
**Requires:** Team configuration, network connection
**Version:** 1.0.0

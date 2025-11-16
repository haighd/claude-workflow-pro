# Metrics Agent

Specialized agent for tracking, analyzing, and reporting workflow metrics and team productivity.

## Purpose

Track and analyze development metrics to gain insights into team productivity, code quality, and workflow efficiency.

## Capabilities

- **Workflow Metrics** - Track checkpoint usage, plan completion, workflow efficiency
- **Code Metrics** - Analyze commits, PRs, code quality, test coverage
- **Team Metrics** - Measure collaboration, pair programming, knowledge sharing
- **Time Tracking** - Analyze time spent on features, bugs, refactoring
- **Quality Metrics** - Track bugs, security issues, performance
- **Velocity Tracking** - Measure story points, throughput, cycle time

## Usage

```bash
/agents/metrics "Generate team productivity report for last sprint"
/agents/metrics "Analyze code quality trends for past 3 months"
/agents/metrics "Show pair programming effectiveness"
/agents/metrics "Track feature development velocity"
```

## Example Outputs

### Workflow Metrics Report

```
📊 Workflow Metrics Report
Period: Last 30 days

Checkpoint Usage:
  Total checkpoints: 142
  Avg per developer: 17.8
  Avg per day: 4.7
  Most used by: @john (34 checkpoints)

Plan Completion:
  Plans created: 23
  Plans completed: 19 (83%)
  Avg completion time: 3.2 days
  Success rate: 91%

Workflow Efficiency:
  Avg time to first checkpoint: 45 minutes
  Avg checkpoint interval: 1.2 hours
  Plans validated before coding: 87%
  Resume from checkpoint: 45 times
```

### Code Quality Report

```
📊 Code Quality Report
Period: Last quarter (90 days)

Commits:
  Total: 456
  Avg per developer: 57
  Conventional commits: 98%

Pull Requests:
  Created: 89
  Merged: 82 (92%)
  Avg review time: 4.2 hours
  Avg size: 245 lines

Code Quality:
  Test coverage: 87% (+5% from last quarter)
  Linting pass rate: 96%
  Security issues: 3 (all resolved)
  Code complexity: 7.2 avg (good)

Trends:
  ✓ Test coverage improving (+5%)
  ✓ PR size decreasing (-15%)
  ✓ Review time faster (-30%)
  ⚠ Slightly more merge conflicts (+8%)
```

### Team Collaboration Report

```
📊 Team Collaboration Report

Pair Programming:
  Sessions: 45
  Total hours: 96
  Participation: 87.5% (7/8 developers)
  Avg session: 2.1 hours
  Knowledge transfer: Excellent

Code Reviews:
  Reviews conducted: 234
  Avg comments per PR: 3.8
  Approval time: 4.2 hours avg
  Thoroughness score: 8.7/10

Knowledge Sharing:
  Cross-component work: 65%
  Documentation updates: 89 commits
  Learning sessions: 12

Team Velocity:
  Story points completed: 127
  Avg velocity: 42.3 points/sprint
  Trend: +12% from last quarter
```

## Metrics Tracked

### Development Metrics
- Commits per day/week/month
- Lines of code added/removed
- PR creation and merge rate
- Review time and thoroughness
- Branch lifetime
- Merge conflict frequency

### Quality Metrics
- Test coverage percentage
- Test pass rate
- Bug discovery rate
- Security issue count
- Code complexity scores
- Technical debt ratio

### Workflow Metrics
- Checkpoint frequency
- Plan completion rate
- Workflow resumption
- Time to first commit
- Feature development time

### Team Metrics
- Pair programming hours
- Knowledge sharing sessions
- Cross-team collaboration
- Documentation contribution
- Review participation

## Configuration

```json
{
  "metrics": {
    "collection": {
      "enabled": true,
      "anonymous": false,
      "retention-days": 90
    },
    "reports": {
      "daily-summary": true,
      "weekly-digest": true,
      "monthly-report": true
    },
    "alerts": {
      "coverage-drop": true,
      "velocity-change": true,
      "quality-issues": true
    }
  }
}
```

## Related Commands

- `/workflow/checkpoint` - Creates metrics data points
- `/team/pair-program` - Tracks collaboration metrics
- `/github/auto-review` - Generates quality metrics

---

**Agent Type:** Specialized
**Category:** Analytics
**Version:** 1.0.0

# GitHub Auto Triage

Automatically triage and label issues based on content analysis and patterns.

## Purpose

Automate issue triage to ensure issues are properly labeled, assigned, and prioritized, reducing manual overhead and improving response time.

## Usage

```bash
/github/auto-triage [issue-number] [--apply] [--config=path]
```

## Parameters

- `issue-number` (optional) - Specific issue to triage. If omitted, triages all new/unlabeled issues
- `--apply` - Apply suggestions automatically (default: dry-run mode)
- `--config=path` - Path to custom triage configuration

## What It Does

### Automated Triage

1. **Classification**
   - Bug vs Feature vs Question
   - Component/module identification
   - Severity assessment
   - Priority calculation

2. **Labeling**
   - Type labels (bug, feature, enhancement, question)
   - Component labels (auth, api, ui, database)
   - Priority labels (critical, high, medium, low)
   - Status labels (needs-reproduction, needs-more-info)

3. **Assignment**
   - Route to appropriate team/person
   - Based on component expertise
   - Workload balancing

4. **Prioritization**
   - Calculate urgency score
   - Consider impact and affected users
   - Apply SLA timelines

5. **Enrichment**
   - Add related issues
   - Link to documentation
   - Suggest potential duplicates
   - Add reproduction templates

## Triage Configuration

### Default Configuration

Create `.claude-triage.json` in project root:

```json
{
  "classification": {
    "enabled": true,
    "keywords": {
      "bug": [
        "error", "bug", "broken", "crash", "fail", "issue",
        "not working", "doesn't work", "incorrect"
      ],
      "feature": [
        "feature", "add", "support for", "allow", "enable",
        "new", "implement", "would be nice"
      ],
      "enhancement": [
        "improve", "better", "enhance", "optimize", "refactor"
      ],
      "question": [
        "how to", "how do i", "question", "help", "?",
        "what is", "where is", "why"
      ],
      "documentation": [
        "docs", "documentation", "readme", "guide", "tutorial"
      ]
    },
    "severity-indicators": {
      "critical": [
        "production down", "data loss", "security", "cannot",
        "completely broken", "urgent", "critical"
      ],
      "high": [
        "major", "important", "significant", "serious"
      ],
      "medium": [
        "moderate", "sometimes", "occasional"
      ],
      "low": [
        "minor", "cosmetic", "nice to have", "low priority"
      ]
    }
  },
  "labeling": {
    "enabled": true,
    "label-schemes": {
      "type": {
        "prefix": "type:",
        "labels": ["bug", "feature", "enhancement", "question", "docs"]
      },
      "component": {
        "prefix": "component:",
        "auto-detect": true,
        "labels": ["auth", "api", "ui", "database", "deployment"]
      },
      "priority": {
        "prefix": "priority:",
        "labels": ["critical", "high", "medium", "low"]
      },
      "status": {
        "prefix": "status:",
        "labels": [
          "needs-reproduction",
          "needs-more-info",
          "confirmed",
          "in-progress",
          "blocked"
        ]
      }
    },
    "auto-apply": true
  },
  "assignment": {
    "enabled": true,
    "rules": [
      {
        "component": "auth",
        "assignees": ["@security-lead", "@backend-team"]
      },
      {
        "component": "ui",
        "assignees": ["@frontend-team"]
      },
      {
        "component": "database",
        "assignees": ["@database-admin"]
      },
      {
        "component": "api",
        "assignees": ["@api-team"]
      },
      {
        "label": "priority:critical",
        "notify": ["@on-call", "@team-lead"]
      }
    ],
    "workload-balancing": true,
    "max-assignments-per-person": 5
  },
  "prioritization": {
    "enabled": true,
    "scoring": {
      "severity-weight": 40,
      "impact-weight": 30,
      "urgency-weight": 20,
      "effort-weight": 10
    },
    "sla": {
      "critical": "4 hours",
      "high": "1 day",
      "medium": "1 week",
      "low": "1 month"
    }
  },
  "enrichment": {
    "duplicate-detection": {
      "enabled": true,
      "similarity-threshold": 0.8
    },
    "related-issues": {
      "enabled": true,
      "max-related": 5
    },
    "documentation-links": {
      "enabled": true,
      "auto-search": true
    },
    "templates": {
      "bug-reproduction": true,
      "feature-specification": true
    }
  },
  "automation": {
    "auto-close": {
      "enabled": true,
      "stale-days": 30,
      "needs-more-info-days": 14
    },
    "auto-respond": {
      "enabled": true,
      "templates": {
        "needs-more-info": "templates/needs-more-info.md",
        "duplicate": "templates/duplicate.md",
        "wont-fix": "templates/wont-fix.md"
      }
    }
  }
}
```

## Triage Output

### Bug Triage Example

```
🤖 Auto Triage - Issue #456

Title: "Login fails with 500 error"
Author: @user123
Created: 2 hours ago

Classification:
  Type: 🐛 Bug
  Component: auth
  Severity: High
  Priority: High
  Confidence: 95%

Analysis:
  ✓ Error mentioned in title
  ✓ HTTP 500 indicates server error
  ✓ Login is critical functionality
  ✓ No version/environment info provided

Suggested Labels:
  + type:bug
  + component:auth
  + priority:high
  + status:needs-more-info

Suggested Assignment:
  Assign to: @auth-team
  Notify: @backend-lead

Suggested Actions:
  1. Request browser console logs
  2. Request server logs
  3. Ask for reproduction steps
  4. Check if issue is still occurring

Related Issues:
  - #234: Similar login error (closed)
  - #345: Auth service timeouts (open)

Relevant Documentation:
  - docs/authentication.md
  - docs/troubleshooting.md#login-issues

SLA: Respond within 1 day

Auto-applied (--apply mode):
  ✓ Added labels: type:bug, component:auth, priority:high
  ✓ Assigned to @auth-team
  ✓ Added comment requesting more info
  ✓ Set milestone: v2.1-bugs
```

### Feature Request Example

```
🤖 Auto Triage - Issue #457

Title: "Add support for OAuth2"
Author: @contributor456
Created: 1 hour ago

Classification:
  Type: ✨ Feature Request
  Component: auth
  Priority: Medium
  Complexity: High
  Confidence: 90%

Analysis:
  ✓ "Add support" indicates feature request
  ✓ OAuth2 mentioned - authentication feature
  ✓ Well-described use case
  ✓ Similar to existing discussion #123

Suggested Labels:
  + type:feature
  + component:auth
  + priority:medium
  + effort:high

Suggested Assignment:
  Assign to: @product-manager (for review)
  Label: needs-product-decision

Suggested Actions:
  1. Link to similar discussion #123
  2. Ask for use case details
  3. Request community interest via 👍 reactions
  4. Schedule for product roadmap review

Related Issues:
  - #123: OAuth discussion
  - #200: SSO integration (related)

Duplicate Detection:
  Similar: #123 (75% match)
  Recommendation: Consider closing as duplicate or merging

Relevant Documentation:
  - docs/roadmap.md
  - docs/authentication.md

Community Interest:
  👍 12 reactions on related issue #123

Auto-applied (--apply mode):
  ✓ Added labels: type:feature, component:auth
  ✓ Assigned to @product-manager
  ✓ Added comment linking to #123
  ✓ Added to Project: Feature Requests
```

### Question Triage Example

```
🤖 Auto Triage - Issue #458

Title: "How do I configure authentication?"
Author: @newuser789
Created: 30 minutes ago

Classification:
  Type: ❓ Question
  Component: auth
  Priority: Low
  Confidence: 99%

Analysis:
  ✓ "How do I" indicates question
  ✓ Documentation likely exists
  ✓ Common question
  ✓ Not a bug or feature request

Suggested Labels:
  + type:question
  + component:auth
  + good-first-issue (for answering)

Suggested Actions:
  1. Link to authentication documentation
  2. Suggest using Discussions instead
  3. Close after providing answer

Related Documentation:
  - docs/authentication.md (direct match)
  - docs/configuration.md
  - examples/auth-setup/

Similar Questions (FAQ):
  - #100: Auth configuration
  - #200: Setup guide

Suggested Response:
  "Hi @newuser789! This is covered in our authentication
   documentation: [link]

   For questions like this, please use GitHub Discussions:
   [link to discussions]

   Closing this issue but feel free to ask follow-ups there!"

Auto-applied (--apply mode):
  ✓ Added labels: type:question, component:auth
  ✓ Posted response with documentation links
  ✓ Closed issue
  ✓ Suggested discussion topic
```

## Component Detection

### Code-Based Detection

Analyzes mentioned files/paths:

```
Issue mentions: "src/auth/login.js"
→ Detected: component:auth

Issue mentions: "api/users endpoint"
→ Detected: component:api

Issue mentions: "UI crashes on dashboard"
→ Detected: component:ui
```

### Keyword-Based Detection

```json
{
  "component-keywords": {
    "auth": ["login", "logout", "authentication", "oauth", "jwt", "session"],
    "api": ["endpoint", "api", "rest", "graphql", "request", "response"],
    "ui": ["ui", "interface", "button", "page", "screen", "display", "render"],
    "database": ["database", "db", "query", "sql", "migration", "schema"],
    "deployment": ["deploy", "build", "ci", "cd", "docker", "kubernetes"]
  }
}
```

## Priority Calculation

### Scoring Algorithm

```
Priority Score = (Severity × 40%) + (Impact × 30%) + (Urgency × 20%) + (Effort × 10%)

Severity:
  - Critical: 100 (production down, data loss, security)
  - High: 75 (major functionality broken)
  - Medium: 50 (minor functionality affected)
  - Low: 25 (cosmetic, nice-to-have)

Impact:
  - All users: 100
  - Most users: 75
  - Some users: 50
  - Few users: 25

Urgency:
  - Immediate: 100
  - This week: 75
  - This month: 50
  - Future: 25

Effort (inverse):
  - Small (< 1 day): 100
  - Medium (1-3 days): 75
  - Large (1 week): 50
  - Very large (> 1 week): 25

Final Priority:
  90-100: Critical
  70-89: High
  40-69: Medium
  0-39: Low
```

## Automated Actions

### Auto-Response Templates

**Needs More Info:**
```markdown
Thanks for reporting this issue!

To help us investigate, could you please provide:

- [ ] Steps to reproduce the issue
- [ ] Expected behavior
- [ ] Actual behavior
- [ ] Environment (OS, browser, version)
- [ ] Error messages or logs

This will help us resolve the issue faster.
```

**Duplicate Issue:**
```markdown
Thanks for the report!

This appears to be a duplicate of #{{duplicate_issue}}.

We're tracking this issue there. Please add any additional
information or reactions to that issue.

Closing as duplicate.
```

**Insufficient Information:**
```markdown
We need more information to proceed with this issue.

Please provide the requested details within 14 days,
or this issue will be automatically closed.

You can always reopen if you provide the information later.
```

### Auto-Labeling Rules

```json
{
  "auto-label-rules": [
    {
      "condition": "title contains 'security'",
      "labels": ["security", "priority:critical"],
      "notify": ["@security-team"]
    },
    {
      "condition": "issue age > 30 days AND no activity",
      "labels": ["stale"],
      "comment": "This issue appears stale. Closing."
    },
    {
      "condition": "author is first-time contributor",
      "labels": ["good-first-issue", "needs-review"],
      "comment": "Thanks for your first contribution!"
    }
  ]
}
```

## Integration

### GitHub Actions

```yaml
name: Auto Triage

on:
  issues:
    types: [opened]

jobs:
  triage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Auto Triage Issue
        run: |
          claude /github/auto-triage ${{ github.event.issue.number }} --apply

      - name: Post Triage Results
        uses: actions/github-script@v6
        with:
          script: |
            // Results are already applied by --apply flag
            // This step can log or notify
            console.log('Issue triaged automatically');
```

### Webhooks

Listen to issue events:

```javascript
{
  "events": ["issues.opened", "issues.edited"],
  "callback": "/github/auto-triage --apply"
}
```

## Advanced Features

### Machine Learning

Improve classification over time:

```json
{
  "ml": {
    "enabled": true,
    "training": {
      "use-historical-data": true,
      "min-confidence": 0.7
    },
    "feedback": {
      "learn-from-relabeling": true,
      "learn-from-assignments": true
    }
  }
}
```

### Team Workload Balancing

```json
{
  "workload-balancing": {
    "enabled": true,
    "strategy": "round-robin",
    "consider-factors": [
      "current-assignments",
      "issue-age",
      "team-capacity",
      "expertise-match"
    ],
    "max-per-person": {
      "bugs": 5,
      "features": 3,
      "questions": 10
    }
  }
}
```

### SLA Tracking

```json
{
  "sla-tracking": {
    "enabled": true,
    "thresholds": {
      "critical": {
        "first-response": "4 hours",
        "resolution": "1 day"
      },
      "high": {
        "first-response": "1 day",
        "resolution": "1 week"
      },
      "medium": {
        "first-response": "3 days",
        "resolution": "2 weeks"
      },
      "low": {
        "first-response": "1 week",
        "resolution": "1 month"
      }
    },
    "alerts": {
      "approaching-threshold": "80%",
      "notify": ["@team-lead"]
    }
  }
}
```

## Examples

### Triage All New Issues

```bash
/github/auto-triage --apply

Output:
Triaging 5 new issues...

Issue #456: "Login fails with 500 error"
  ✓ Classified as: bug (high priority)
  ✓ Assigned to: @auth-team
  ✓ Labels: type:bug, component:auth, priority:high
  ✓ Comment: Requested more info

Issue #457: "Add OAuth2 support"
  ✓ Classified as: feature (medium priority)
  ✓ Assigned to: @product-manager
  ✓ Labels: type:feature, component:auth
  ✓ Comment: Linked to similar discussion

Issue #458: "How to configure auth?"
  ✓ Classified as: question
  ✓ Labels: type:question
  ✓ Comment: Provided docs link
  ✓ Closed: Answered

Issue #459: "Dashboard crashes"
  ✓ Classified as: bug (critical priority)
  ✓ Assigned to: @frontend-team
  ✓ Labels: type:bug, component:ui, priority:critical
  ✓ Notified: @on-call
  ✓ Comment: Requested reproduction steps

Issue #460: "Improve error messages"
  ✓ Classified as: enhancement (low priority)
  ✓ Labels: type:enhancement, good-first-issue
  ✓ Comment: Tagged as good first issue

Summary:
- 5 issues triaged
- 3 assigned
- 1 closed
- 15 labels applied
- 5 comments posted
- 1 critical alert sent
```

### Dry Run Mode

```bash
/github/auto-triage 456

Output (no changes applied):
Would classify as: bug (high priority)
Would assign to: @auth-team
Would add labels: type:bug, component:auth, priority:high
Would comment: Request more information

Use --apply to apply these suggestions.
```

## Best Practices

1. **Start with Dry Runs**: Test triage logic before applying
2. **Review Regularly**: Check triage accuracy weekly
3. **Update Keywords**: Refine keywords based on false positives
4. **Team Input**: Get team consensus on labeling scheme
5. **Balance Automation**: Keep human review for complex cases

## Troubleshooting

### False Classifications

Adjust confidence thresholds:

```json
{
  "classification": {
    "min-confidence": 0.8,
    "manual-review-below": 0.6
  }
}
```

### Wrong Assignments

Override with manual rules:

```json
{
  "assignment-overrides": {
    "#456": "@specific-person",
    "label:security": "@security-team"
  }
}
```

## Related Commands

- `/github/create-issue` - Create new issue
- `/github/label-issue` - Manually label issue
- `/github/assign-issue` - Manually assign issue
- `/github/close-issue` - Close issue

## See Also

- Issue template best practices
- Labeling conventions
- Project management workflows
- SLA management

---

**Command Type:** GitHub Automation
**Agent Used:** triage-agent (NLP-based)
**Requires:** GitHub integration, issue read/write permissions
**Version:** 1.0.0

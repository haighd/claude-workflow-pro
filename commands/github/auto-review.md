# GitHub Auto Review

Automatically review pull requests based on customizable rules and best practices.

## Purpose

Automate initial PR review to catch common issues before human review, saving reviewer time and improving code quality consistency.

## Usage

```bash
/github/auto-review [pr-number] [--strict] [--config=path]
```

## Parameters

- `pr-number` (optional) - PR number to review. If omitted, reviews current branch's PR
- `--strict` - Apply strict review rules (fails on warnings)
- `--config=path` - Path to custom review configuration

## What It Does

### Automated Checks

1. **Code Quality**
   - Linting violations
   - Code style consistency
   - Complexity metrics
   - Duplicate code detection

2. **Security**
   - Exposed secrets
   - Vulnerable dependencies
   - Security anti-patterns
   - Input validation issues

3. **Testing**
   - Test coverage changes
   - Missing tests for new code
   - Test quality assessment
   - Breaking test changes

4. **Documentation**
   - Missing docstrings/comments
   - Outdated documentation
   - README updates needed
   - CHANGELOG entry required

5. **Best Practices**
   - Naming conventions
   - File organization
   - Error handling
   - Logging standards

6. **Performance**
   - N+1 queries
   - Inefficient algorithms
   - Resource leaks
   - Blocking operations

7. **Git Hygiene**
   - Commit message quality
   - PR size (too large)
   - Merge conflicts
   - Branch naming

## Review Configuration

### Default Configuration

Create `.claude-review.json` in project root:

```json
{
  "rules": {
    "code-quality": {
      "enabled": true,
      "complexity-threshold": 10,
      "file-length-limit": 500,
      "function-length-limit": 50
    },
    "security": {
      "enabled": true,
      "fail-on-secrets": true,
      "scan-dependencies": true
    },
    "testing": {
      "enabled": true,
      "coverage-threshold": 80,
      "require-tests-for-new-code": true
    },
    "documentation": {
      "enabled": true,
      "require-docstrings": true,
      "require-changelog": true
    },
    "best-practices": {
      "enabled": true,
      "naming-conventions": "strict",
      "require-error-handling": true
    },
    "performance": {
      "enabled": true,
      "warn-on-complexity": true
    },
    "git": {
      "enabled": true,
      "commit-message-format": "conventional",
      "max-pr-size": 400,
      "require-linear-history": false
    }
  },
  "exclusions": {
    "files": [
      "*.generated.*",
      "vendor/**",
      "node_modules/**",
      "*.min.js"
    ],
    "rules": {
      "test/**": ["complexity"],
      "migrations/**": ["documentation"]
    }
  },
  "severity-levels": {
    "blocking": ["security", "tests-failing"],
    "required": ["coverage", "linting"],
    "recommended": ["documentation", "complexity"],
    "optional": ["style-suggestions"]
  }
}
```

### Custom Rules

Add project-specific rules:

```json
{
  "custom-rules": [
    {
      "name": "require-jsdoc",
      "pattern": "function\\s+\\w+\\s*\\(",
      "require": "/\\*\\*[\\s\\S]*?\\*/\\s*function",
      "message": "All functions must have JSDoc comments",
      "severity": "warning"
    },
    {
      "name": "no-console-log",
      "pattern": "console\\.log\\(",
      "message": "Use logger instead of console.log",
      "severity": "error",
      "exclude": ["scripts/**", "tools/**"]
    }
  ]
}
```

## Review Output

### Success Example

```
🤖 Auto Review - PR #123

✅ Code Quality: PASS
  - No linting violations
  - Complexity within limits
  - No duplicate code detected

✅ Security: PASS
  - No secrets detected
  - Dependencies up to date
  - No security anti-patterns

✅ Testing: PASS
  - Coverage: 85% (+2%)
  - All new code tested
  - Tests passing

⚠️  Documentation: WARNING
  - 2 functions missing docstrings
  - CHANGELOG entry needed

✅ Best Practices: PASS
  - Naming conventions followed
  - Error handling present

✅ Performance: PASS
  - No obvious performance issues

✅ Git Hygiene: PASS
  - Commit messages follow convention
  - PR size appropriate (245 lines)

Overall: APPROVED WITH SUGGESTIONS

Suggestions:
1. Add docstrings to calculateTotal() and processOrder()
2. Add entry to CHANGELOG.md

Auto-approve: No (requires documentation updates)
```

### Failure Example

```
🤖 Auto Review - PR #124

❌ Code Quality: FAIL
  - 5 linting violations
  - Function complexity: 15 (threshold: 10)

❌ Security: FAIL
  - Potential secret detected in config.js:42
  - Vulnerable dependency: lodash@4.17.15

⚠️  Testing: WARNING
  - Coverage: 65% (-5%)
  - 3 new files without tests

❌ Documentation: FAIL
  - No CHANGELOG entry
  - 10 functions missing docstrings

Overall: CHANGES REQUESTED

Required actions:
1. Fix linting violations
2. Remove secret from config.js
3. Update lodash dependency
4. Reduce complexity in processData()
5. Add tests for new services
6. Add CHANGELOG entry

Auto-approve: No (blocking issues found)
```

## Review Workflow

### Manual Trigger

```bash
# Review specific PR
/github/auto-review 123

# Review with strict mode
/github/auto-review 123 --strict

# Review with custom config
/github/auto-review 123 --config=.claude-review-strict.json
```

### Automated Trigger

Add to GitHub Actions (`.github/workflows/auto-review.yml`):

```yaml
name: Auto Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  auto-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Run Auto Review
        run: |
          # Run Claude auto-review
          claude /github/auto-review ${{ github.event.pull_request.number }}

      - name: Post Review Comment
        uses: actions/github-script@v6
        with:
          script: |
            // Post review results as comment
            const fs = require('fs');
            const review = fs.readFileSync('review-output.md', 'utf8');

            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: review
            });
```

## Review Categories Detail

### 1. Code Quality

**Checks:**
- ESLint/Pylint/Rubocop violations
- Cyclomatic complexity
- Cognitive complexity
- Code duplication
- File/function length
- Magic numbers
- Deep nesting

**Configuration:**
```json
{
  "code-quality": {
    "linter": "auto-detect",
    "complexity-metrics": {
      "cyclomatic": 10,
      "cognitive": 15
    },
    "duplication-threshold": 6,
    "nesting-depth": 4
  }
}
```

### 2. Security

**Checks:**
- Secret scanning (API keys, passwords, tokens)
- Dependency vulnerabilities (npm audit, pip-audit)
- SQL injection patterns
- XSS vulnerabilities
- Insecure cryptography
- Path traversal
- Command injection

**Configuration:**
```json
{
  "security": {
    "secret-patterns": [
      "api[-_]?key",
      "secret[-_]?key",
      "password",
      "token"
    ],
    "dependency-scanner": "npm-audit",
    "fail-on-high": true
  }
}
```

### 3. Testing

**Checks:**
- Test coverage percentage
- Coverage delta
- New code without tests
- Test file naming
- Assertion quality
- Test isolation
- Mocking patterns

**Configuration:**
```json
{
  "testing": {
    "coverage-tool": "jest",
    "minimum-coverage": 80,
    "require-tests-for-new-files": true,
    "test-file-pattern": "*.test.{js,ts}",
    "coverage-delta-threshold": -2
  }
}
```

### 4. Documentation

**Checks:**
- Missing docstrings/JSDoc
- Outdated comments
- CHANGELOG entry
- README updates
- API documentation
- Type annotations
- Example code

**Configuration:**
```json
{
  "documentation": {
    "docstring-style": "google",
    "require-for-public-apis": true,
    "changelog-required": true,
    "readme-update-on-feature": true
  }
}
```

### 5. Best Practices

**Checks:**
- Naming conventions (camelCase, snake_case, etc.)
- Error handling patterns
- Logging standards
- Resource cleanup
- Null checks
- Type safety
- Import organization

**Configuration:**
```json
{
  "best-practices": {
    "naming": {
      "variables": "camelCase",
      "functions": "camelCase",
      "classes": "PascalCase",
      "constants": "UPPER_SNAKE_CASE"
    },
    "error-handling": "required",
    "logging-level": "info"
  }
}
```

### 6. Performance

**Checks:**
- N+1 query patterns
- Inefficient loops
- Unnecessary computation
- Memory leaks
- Blocking I/O
- Large payload warnings

**Configuration:**
```json
{
  "performance": {
    "warn-on-n-plus-one": true,
    "max-loop-iterations": 10000,
    "async-required-for-io": true
  }
}
```

### 7. Git Hygiene

**Checks:**
- Commit message format
- PR size
- Branch naming
- Merge conflicts
- Commit granularity

**Configuration:**
```json
{
  "git": {
    "commit-format": {
      "pattern": "^(feat|fix|docs|style|refactor|test|chore)(\\(.+\\))?: .+",
      "example": "feat(auth): add OAuth2 support"
    },
    "max-pr-lines": 400,
    "branch-pattern": "^(feature|fix|refactor|hotfix)/.+",
    "require-issue-reference": true
  }
}
```

## Integration with Review Process

### Auto-Approve Safe Changes

```json
{
  "auto-approve": {
    "enabled": true,
    "conditions": {
      "all-checks-pass": true,
      "no-security-issues": true,
      "coverage-maintained": true,
      "author-is-trusted": ["dependabot", "renovate"],
      "change-types": ["docs", "test", "chore"],
      "max-lines-changed": 20
    }
  }
}
```

### Request Changes Automatically

```json
{
  "auto-request-changes": {
    "enabled": true,
    "conditions": {
      "security-issues": true,
      "tests-failing": true,
      "coverage-drop": 10,
      "linting-errors": true
    }
  }
}
```

## Advanced Features

### Custom Reviewers

Assign reviewers based on changed files:

```json
{
  "reviewer-assignment": {
    "enabled": true,
    "rules": [
      {
        "files": ["src/auth/**"],
        "reviewers": ["@security-team"]
      },
      {
        "files": ["*.sql", "migrations/**"],
        "reviewers": ["@database-team"]
      },
      {
        "files": ["docs/**"],
        "reviewers": ["@docs-team"]
      }
    ],
    "fallback-reviewers": ["@team-lead"]
  }
}
```

### Labels

Auto-apply labels based on review:

```json
{
  "auto-labeling": {
    "enabled": true,
    "labels": {
      "security-review-needed": {
        "condition": "security-issues-found"
      },
      "needs-tests": {
        "condition": "coverage-below-threshold"
      },
      "needs-docs": {
        "condition": "documentation-incomplete"
      },
      "ready-to-merge": {
        "condition": "all-checks-pass"
      }
    }
  }
}
```

### Notifications

Configure notifications:

```json
{
  "notifications": {
    "slack": {
      "webhook": "${SLACK_WEBHOOK_URL}",
      "notify-on": ["security-issues", "blocking-issues"],
      "channel": "#pr-reviews"
    },
    "email": {
      "enabled": false
    }
  }
}
```

## Examples

### Review Frontend PR

```bash
/github/auto-review 456

Output:
✅ Code Quality: ESLint passing, no complexity issues
✅ Security: No issues
⚠️  Testing: Coverage 75% (below 80% threshold)
❌ Documentation: Missing PropTypes for 3 components
✅ Best Practices: React hooks correctly used
✅ Performance: No expensive renders detected
✅ Git: Conventional commits followed

Verdict: Approved with suggestions
- Add tests for UserProfile, Header, Footer components
- Add PropTypes or TypeScript types
```

### Review Backend PR

```bash
/github/auto-review 789 --strict

Output:
✅ Code Quality: Pylint score 9.5/10
❌ Security: Found hardcoded API key in config.py:23
✅ Testing: Coverage 92%
✅ Documentation: All functions documented
❌ Best Practices: No error handling in process_payment()
⚠️  Performance: Potential N+1 query in get_user_orders()
✅ Git: PR size appropriate

Verdict: Changes requested (strict mode)
- Remove hardcoded API key, use environment variable
- Add try/except in process_payment()
- Optimize query in get_user_orders() using select_related()
```

## Troubleshooting

### False Positives

```json
{
  "false-positive-suppression": {
    "inline-comments": {
      "enabled": true,
      "format": "// claude-review-ignore: <rule-name>"
    },
    "file-level": {
      "enabled": true,
      "format": "// claude-review-ignore-file"
    }
  }
}
```

Usage:
```javascript
// claude-review-ignore: complexity
function complexLegacyFunction() {
  // ... complex but necessary code
}
```

### Performance

For large PRs, optimize review:

```json
{
  "performance": {
    "max-files": 100,
    "timeout": 300,
    "parallel-checks": true,
    "cache-results": true
  }
}
```

## Best Practices

1. **Start Lenient**: Begin with warnings, gradually enforce
2. **Team Consensus**: Review rules should be team decision
3. **Regular Updates**: Update rules as team evolves
4. **Balance Automation**: Auto-review complements, doesn't replace human review
5. **Fast Feedback**: Keep review fast (<30 seconds)

## Related Commands

- `/github/create-pr` - Create pull request
- `/github/request-review` - Request human review
- `/github/merge-pr` - Merge pull request
- `/development/code-review` - Manual code review with agent

## See Also

- Code review best practices
- Conventional commits specification
- Security scanning tools
- Testing guidelines

---

**Command Type:** GitHub Automation
**Agent Used:** code-review-agent
**Requires:** GitHub integration
**Version:** 1.0.0

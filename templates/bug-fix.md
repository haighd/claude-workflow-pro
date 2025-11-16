# Bug Fix Workflow Template

This template provides a systematic approach to investigating, fixing, and validating bug fixes.

## Template Variables

Replace these placeholders when using this template:

- `{{BUG_ID}}` - Bug tracking ID (e.g., issue number)
- `{{BUG_TITLE}}` - Brief description of the bug
- `{{SEVERITY}}` - critical/high/medium/low
- `{{AFFECTED_VERSION}}` - Version where bug was found
- `{{REPORTER}}` - Person who reported the bug

## Phase 1: Investigation

### 1.1 Reproduce the Bug
```bash
# Document reproduction steps
Create file: bug-{{BUG_ID}}-reproduction.md

Include:
- Environment details
- Step-by-step reproduction
- Expected behavior
- Actual behavior
- Screenshots/logs if applicable
```

### 1.2 Analyze Root Cause
```bash
# Use debug agent to investigate
/development/debug-agent

Task: Analyze root cause of bug {{BUG_ID}}

Context:
- Bug: {{BUG_TITLE}}
- Severity: {{SEVERITY}}
- Reproduction steps: [paste steps]
- Error logs: [paste relevant logs]

Questions to answer:
1. Where does the error occur?
2. What is the root cause?
3. What components are affected?
4. Are there related issues?
```

### 1.3 Impact Assessment
```bash
# Assess impact
/research/plan-agent

Task: Assess impact of bug {{BUG_ID}}

Analyze:
- Affected users/systems
- Data integrity concerns
- Security implications
- Performance impact
- Workaround availability
```

### 1.4 Create Investigation Report
```bash
# Document findings
Create: docs/bugs/bug-{{BUG_ID}}-analysis.md

Include:
- Reproduction steps
- Root cause analysis
- Impact assessment
- Proposed solution
- Testing strategy
```

## Phase 2: Planning the Fix

### 2.1 Design Solution
```bash
# Plan the fix
/workflow/create-plan

Plan name: bug-{{BUG_ID}}-fix
Description: Fix for {{BUG_TITLE}}

Tasks:
1. [ ] Identify files to modify
2. [ ] Design fix approach
3. [ ] Plan for backward compatibility
4. [ ] Identify regression test needs
5. [ ] Plan deployment strategy
6. [ ] Prepare rollback plan
```

### 2.2 Validate Approach
```bash
# Review with relevant agents
/workflow/validate-plan

Focus areas:
- Does fix address root cause?
- Are there side effects?
- Is fix minimal and targeted?
- Will it prevent recurrence?
```

### 2.3 Create Bug Fix Branch
```bash
# Create branch based on severity
# For critical/high bugs:
git checkout -b hotfix/bug-{{BUG_ID}}

# For medium/low bugs:
git checkout -b fix/bug-{{BUG_ID}}
```

## Phase 3: Implementation

### 3.1 Implement Fix
```bash
# Make the fix
/development/code-with-agent

Task: Implement fix for bug {{BUG_ID}}

Approach: [Describe fix approach]
Files to modify: [List files]

Requirements:
- Minimal change scope
- Clear code comments
- No unrelated changes
```

### 3.2 Verify Fix Resolves Issue
```bash
# Test the fix manually
Steps:
1. Apply fix
2. Follow original reproduction steps
3. Verify bug no longer occurs
4. Test edge cases
5. Document verification results
```

### 3.3 Checkpoint Progress
```bash
/workflow/checkpoint "bug-{{BUG_ID}}-fix-implemented"
```

## Phase 4: Testing

### 4.1 Create Regression Test
```bash
# Add test that would have caught this bug
/development/test-agent

Task: Create regression test for bug {{BUG_ID}}

Test should:
- Reproduce original bug condition
- Verify fix resolves issue
- Catch future regressions
- Cover edge cases
```

### 4.2 Run Related Tests
```bash
# Run tests for affected components
npm test -- --grep="{{affected_component}}"
# or
pytest tests/test_{{affected_component}}.py -v
```

### 4.3 Full Test Suite
```bash
# Run complete test suite
npm test
# or
pytest
# or appropriate test command

# Ensure no regressions introduced
```

### 4.4 Manual Testing
```bash
# Manual test checklist
- [ ] Original bug scenario
- [ ] Edge cases identified
- [ ] Related functionality
- [ ] Different environments (if applicable)
- [ ] Different user roles (if applicable)
- [ ] Integration points
```

## Phase 5: Code Review

### 5.1 Self-Review
```bash
# Review your own fix
/development/code-review

Scope: {{branch_name}}

Focus on:
- Fix addresses root cause
- No over-engineering
- Minimal scope
- Clear comments
- Tests included
```

### 5.2 Security Check
```bash
# For security-related bugs
/development/security-audit

Scope: bug fix for {{BUG_ID}}
Focus: Ensure fix doesn't introduce vulnerabilities
```

### 5.3 Performance Check
```bash
# Verify no performance regression
/development/performance-test

Test: Fixed functionality
Compare: Before and after fix
```

## Phase 6: Documentation

### 6.1 Update Code Comments
```bash
# Add comments explaining:
- What the bug was
- Why the fix works
- Any gotchas for future developers
```

### 6.2 Update CHANGELOG
```bash
# Add entry to CHANGELOG.md
## [Version] - Date

### Fixed
- Fix {{BUG_TITLE}} (#{{BUG_ID}})
  - Root cause: [brief explanation]
  - Impact: [who/what was affected]
```

### 6.3 Update Issue/Ticket
```bash
# Update bug tracking system
1. Add comment with fix details
2. Link to PR
3. Add "fixed" label
4. Update status (if not auto-closed)
```

## Phase 7: Pull Request

### 7.1 Create PR
```bash
# Create pull request
/github/create-pr

Title: fix: {{BUG_TITLE}} (#{{BUG_ID}})

Description:
## Bug Description
{{BUG_TITLE}}

## Root Cause
[Explain what caused the bug]

## Fix Description
[Explain how the fix works]

## Testing
- [ ] Regression test added
- [ ] All tests passing
- [ ] Manual testing complete
- [ ] No performance regression

## Impact
- Affected users: [description]
- Severity: {{SEVERITY}}
- Backward compatible: yes/no

## Verification Steps
1. [Step 1]
2. [Step 2]
3. [Verify bug no longer occurs]

Fixes #{{BUG_ID}}
```

### 7.2 Set PR Priority
```bash
# Add labels based on severity
/github/label-pr

Labels:
- bug
- {{SEVERITY}}-priority
- needs-review
```

### 7.3 Request Fast-Track (if critical)
```bash
# For critical bugs only
Add labels: critical, fast-track
Request reviews from: [senior developers]
Notify: team lead/manager
```

## Phase 8: Review and Merge

### 8.1 Address Review Comments
```bash
# Respond to feedback quickly
For each comment:
1. Acknowledge
2. Implement or explain
3. Request re-review
```

### 8.2 Pre-Merge Verification
```bash
# Final checks before merge
- [ ] All approvals received
- [ ] CI/CD passing
- [ ] Regression test included
- [ ] Documentation updated
- [ ] No merge conflicts
```

### 8.3 Merge Strategy
```bash
# For hotfixes (critical/high):
Merge to: main + release branches
Strategy: cherry-pick or merge

# For regular fixes (medium/low):
Merge to: main
Strategy: squash or merge
```

## Phase 9: Post-Merge

### 9.1 Verify in Production
```bash
# After deployment
1. Monitor error rates
2. Verify fix in production
3. Check related metrics
4. Monitor for new issues
```

### 9.2 Communicate Fix
```bash
# Notify stakeholders
1. Update bug ticket (auto-closes from PR)
2. Notify reporter
3. Post to team channel
4. Update status page (if applicable)
```

### 9.3 Post-Mortem (for critical bugs)
```bash
# Create post-mortem document
docs/post-mortems/bug-{{BUG_ID}}.md

Include:
- What happened
- Root cause
- How it was fixed
- How to prevent similar bugs
- Timeline of events
- Lessons learned
```

## Phase 10: Prevention

### 10.1 Process Improvements
```bash
# Identify how to prevent similar bugs
Questions:
- Should we add linting rules?
- Should we add pre-commit hooks?
- Should we update coding guidelines?
- Should we add monitoring/alerts?
```

### 10.2 Knowledge Sharing
```bash
# Share learnings with team
1. Team meeting discussion
2. Add to best practices doc
3. Update coding guidelines
4. Create training material (if needed)
```

## Severity-Based Workflows

### Critical (P0) - Production Down
```bash
Timeline: Fix within hours
Process:
1. Immediate investigation
2. Quick fix (may not be perfect)
3. Fast-track review
4. Hotfix deployment
5. Follow-up PR for comprehensive fix
6. Required post-mortem
```

### High (P1) - Major Feature Broken
```bash
Timeline: Fix within 1-2 days
Process:
1. Investigation within hours
2. Thorough fix
3. Expedited review
4. Next deployment cycle
5. Post-mortem recommended
```

### Medium (P2) - Minor Feature Broken
```bash
Timeline: Fix within 1 week
Process:
1. Investigation within 1 day
2. Standard fix process
3. Normal review cycle
4. Regular deployment
5. No post-mortem needed
```

### Low (P3) - Cosmetic/Nice-to-have
```bash
Timeline: Fix when convenient
Process:
1. Add to backlog
2. Fix in regular sprint
3. Standard process
4. Bundle with other changes
```

## Common Pitfalls to Avoid

1. **Treating symptoms, not root cause** - Always find root cause
2. **Over-engineering the fix** - Keep fixes minimal and focused
3. **No regression test** - Always add test to prevent recurrence
4. **Introducing new bugs** - Run full test suite
5. **Poor communication** - Keep stakeholders informed
6. **Incomplete testing** - Test edge cases and related functionality

## Rollback Plan

```bash
# If fix causes issues
1. Immediate rollback:
   git revert [merge-commit]

2. Investigate new issue:
   /development/debug-agent

3. Implement better fix:
   Follow this template again
```

## Quick Reference

```bash
# Investigation
/development/debug-agent

# Planning
/workflow/create-plan

# Implementation
/development/code-with-agent

# Testing
/development/test-agent

# Review
/development/code-review

# PR Creation
/github/create-pr

# Checkpoint
/workflow/checkpoint "bug-{{BUG_ID}}-[milestone]"
```

## Related Templates

- `feature-development.md` - For new features
- `security-patch.md` - For security vulnerabilities
- `performance-optimization.md` - For performance issues
- `refactoring.md` - For technical debt

---

**Template Version:** 1.0.0
**Last Updated:** 2025-11-16
**Maintained By:** Claude Workflow Pro Team

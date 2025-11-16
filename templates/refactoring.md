# Refactoring Workflow Template

This template provides a structured approach to code refactoring, ensuring improvements don't break functionality.

## Template Variables

Replace these placeholders when using this template:

- `{{REFACTOR_NAME}}` - Name of the refactoring effort
- `{{TARGET_COMPONENT}}` - Component/module being refactored
- `{{REASON}}` - Why refactoring is needed
- `{{SCOPE}}` - small/medium/large

## Phase 1: Assessment

### 1.1 Identify Refactoring Need
```bash
# Document current issues
Create: docs/refactoring/{{REFACTOR_NAME}}-assessment.md

Document:
- Current problems (technical debt, complexity, etc.)
- Impact on development velocity
- Risks of not refactoring
- Estimated effort
```

### 1.2 Analyze Current State
```bash
# Use architecture agent to analyze
/research/architecture-agent

Task: Analyze current architecture of {{TARGET_COMPONENT}}

Focus on:
- Code complexity metrics
- Dependency graph
- Test coverage
- Performance characteristics
- Maintainability issues
```

### 1.3 Define Success Criteria
```bash
# Clear objectives for refactoring
Success metrics:
- [ ] Reduced complexity (specific target)
- [ ] Improved test coverage (target %)
- [ ] Better performance (specific metrics)
- [ ] Easier to understand (subjective)
- [ ] Reduced dependencies
- [ ] Better separation of concerns
```

## Phase 2: Planning

### 2.1 Create Refactoring Plan
```bash
/workflow/create-plan

Plan name: {{REFACTOR_NAME}}
Description: Refactor {{TARGET_COMPONENT}} because {{REASON}}

Strategy: [Choose one or more]
- Extract method/class
- Rename for clarity
- Simplify complex logic
- Remove duplication
- Improve data structures
- Restructure modules
- Update patterns/practices

Tasks:
1. [ ] Ensure comprehensive test coverage exists
2. [ ] Identify refactoring steps
3. [ ] Plan incremental changes
4. [ ] Create backup/checkpoint strategy
5. [ ] Define rollback plan
```

### 2.2 Establish Test Baseline
```bash
# Critical: Tests must pass before refactoring
npm test
# or
pytest -v

# Document current coverage
npm run coverage
# or
pytest --cov

Baseline metrics:
- Tests passing: [number/number]
- Coverage: [percentage]
- Performance: [benchmarks]
```

### 2.3 Validate Approach
```bash
/workflow/validate-plan

Validation points:
- Will refactoring achieve goals?
- Is scope manageable?
- Are changes incremental?
- Is rollback plan clear?
- Are tests sufficient?
```

## Phase 3: Pre-Refactoring

### 3.1 Add Missing Tests
```bash
# Ensure code is well-tested before refactoring
/development/test-agent

Task: Add tests for {{TARGET_COMPONENT}} before refactoring

Target coverage: 90%+ for code being refactored

Focus on:
- Happy paths
- Edge cases
- Error conditions
- Integration points
```

### 3.2 Run Full Test Suite
```bash
# Verify all tests pass
npm test
# Must be: ALL TESTS PASSING ✓

# If tests fail, fix them first
# Do not proceed with refactoring until tests pass
```

### 3.3 Create Checkpoint
```bash
/workflow/checkpoint "{{REFACTOR_NAME}}-pre-refactor"

# This is your safety net
# You can return to this point if needed
```

### 3.4 Create Refactoring Branch
```bash
git checkout -b refactor/{{REFACTOR_NAME}}
```

## Phase 4: Incremental Refactoring

### 4.1 First Increment
```bash
# Make smallest meaningful change
/development/code-with-agent

Task: First refactoring step for {{REFACTOR_NAME}}

Rules:
- Change only what's necessary
- Keep commits small and focused
- One logical change per commit
- Run tests after each change

First step: [Describe specific change]
```

### 4.2 Test After Each Change
```bash
# After EVERY change, run tests
npm test

# If tests fail:
# - Fix the code, OR
# - Fix the test (if refactoring changed behavior intentionally)

# Never proceed with failing tests
```

### 4.3 Commit Incrementally
```bash
# Commit after each successful change
git add [changed files]
git commit -m "refactor({{TARGET_COMPONENT}}): [specific change]

- What was changed
- Why it was changed
- Tests still passing

Part of: {{REFACTOR_NAME}}"
```

### 4.4 Repeat for Each Step
```bash
# Continue incremental refactoring
For each refactoring step:
1. Make small change
2. Run tests
3. Fix any issues
4. Commit
5. Repeat

# Create checkpoint at major milestones
/workflow/checkpoint "{{REFACTOR_NAME}}-step-[N]-complete"
```

## Phase 5: Verification

### 5.1 Code Quality Check
```bash
# Review refactored code
/development/code-review

Scope: refactor/{{REFACTOR_NAME}}

Quality checks:
- Code is simpler than before
- Naming is clearer
- Complexity reduced
- Duplication removed
- Patterns consistent
```

### 5.2 Performance Comparison
```bash
# Ensure no performance regression
/development/performance-test

Test: {{TARGET_COMPONENT}}

Compare:
- Before refactoring: [baseline metrics]
- After refactoring: [new metrics]

Acceptable: Similar or better performance
```

### 5.3 Test Coverage Verification
```bash
# Verify coverage maintained or improved
npm run coverage
# or
pytest --cov

Compare to baseline:
- Coverage should be ≥ baseline
- All tests should pass
- No flaky tests introduced
```

### 5.4 Success Criteria Review
```bash
# Check against defined success criteria
Review:
- [ ] Complexity reduced (measure with tools)
- [ ] Test coverage maintained/improved
- [ ] Performance maintained/improved
- [ ] Code more maintainable
- [ ] Documentation updated
```

## Phase 6: Documentation

### 6.1 Update Code Documentation
```bash
# Update inline documentation
/development/docs-agent

Task: Update documentation for refactored {{TARGET_COMPONENT}}

Update:
- Function/class docstrings
- Inline comments (remove outdated, add new)
- Type hints/annotations
- API documentation
```

### 6.2 Update Architecture Docs
```bash
# Update high-level documentation
Files to update:
- Architecture diagrams
- Component relationships
- Module structure
- Design decisions

Document:
- What was refactored
- Why it was refactored
- New structure/approach
```

### 6.3 Migration Guide (if needed)
```bash
# If refactoring affects API/interfaces
Create: docs/migrations/{{REFACTOR_NAME}}-migration.md

Include:
- What changed
- How to update consuming code
- Before/after examples
- Deprecation timeline (if applicable)
```

### 6.4 Update CHANGELOG
```bash
# Add entry
## [Unreleased]

### Changed
- Refactor {{TARGET_COMPONENT}} for improved [clarity/performance/etc]
  - Details: {{REASON}}
  - Breaking changes: [yes/no]
  - Migration guide: [link if applicable]
```

## Phase 7: Pull Request

### 7.1 Prepare PR
```bash
/github/create-pr

Title: refactor: {{REFACTOR_NAME}}

Description:
## Refactoring Summary
{{REASON}}

## What Changed
[List major changes]

## Before vs After
### Complexity
- Before: [metrics]
- After: [metrics]

### Performance
- Before: [benchmarks]
- After: [benchmarks]

### Test Coverage
- Before: [%]
- After: [%]

## Breaking Changes
[List any breaking changes or "None"]

## Migration Required
[Yes/No - link to migration guide if yes]

## Testing
- [ ] All existing tests pass
- [ ] Test coverage maintained/improved
- [ ] Performance verified
- [ ] Manual testing complete

## Review Focus
Please review for:
- Code clarity and maintainability
- Completeness of refactoring
- Test coverage
- Documentation quality
```

### 7.2 Request Thorough Review
```bash
/github/request-review

Reviewers: [Include architect/senior developers]
Labels: refactoring, needs-careful-review

Note: Request reviewers to verify:
- Refactoring improves code quality
- No subtle bugs introduced
- Tests are comprehensive
- Performance acceptable
```

## Phase 8: Review Process

### 8.1 Respond to Feedback
```bash
# Address review comments
For each comment:
1. Acknowledge
2. Discuss if needed
3. Implement changes or explain reasoning
4. Re-test after changes
5. Request re-review
```

### 8.2 Additional Testing
```bash
# If reviewers suggest edge cases
/development/test-agent

Task: Add tests for [reviewer-identified scenarios]
```

### 8.3 Pre-Merge Verification
```bash
# Final checks
- [ ] All reviews approved
- [ ] CI/CD passing
- [ ] Tests passing locally
- [ ] No merge conflicts
- [ ] Documentation complete
- [ ] Performance verified
```

## Phase 9: Deployment

### 9.1 Merge Strategy
```bash
# For refactoring, prefer merge over squash
# to preserve incremental commit history

/github/merge-pr

Strategy: merge (not squash)
Reason: Preserve refactoring steps for future reference
```

### 9.2 Monitor After Merge
```bash
# Watch for issues post-deployment
Monitor:
- Error rates
- Performance metrics
- User reports
- System health

Duration: First 24-48 hours critical
```

### 9.3 Rollback Plan
```bash
# If serious issues discovered
1. Immediate rollback:
   git revert -m 1 [merge-commit]

2. Investigate:
   /development/debug-agent

3. Fix forward or keep reverted:
   Decide based on severity and fix complexity
```

## Refactoring Patterns

### Extract Method
```bash
# Problem: Long, complex method
# Solution: Extract to smaller methods

Before:
- One 100-line method doing multiple things

After:
- Multiple focused methods
- Each with single responsibility
- Clear naming
```

### Extract Class
```bash
# Problem: Class doing too much
# Solution: Split into multiple classes

Before:
- God class with many responsibilities

After:
- Multiple focused classes
- Clear separation of concerns
- Better testability
```

### Rename for Clarity
```bash
# Problem: Unclear naming
# Solution: Rename to reveal intent

Before: data, tmp, val, x
After: userData, temporaryCache, validationResult, xCoordinate
```

### Simplify Complex Logic
```bash
# Problem: Nested conditionals, complex boolean logic
# Solution: Extract to well-named methods, use guard clauses

Before:
if (condition1) {
  if (condition2) {
    if (!condition3) {
      // deeply nested logic
    }
  }
}

After:
if (!shouldProcess()) return;
processData();

function shouldProcess() {
  return condition1 && condition2 && !condition3;
}
```

### Remove Duplication
```bash
# Problem: Same/similar code in multiple places
# Solution: Extract to shared function/method

Before:
- Copy-pasted code
- Similar logic in multiple places

After:
- Single source of truth
- Shared utility functions
- DRY principle applied
```

### Improve Data Structures
```bash
# Problem: Inefficient or unclear data structures
# Solution: Use appropriate data structures

Before:
- Array used where Set appropriate
- Multiple parallel arrays

After:
- Appropriate data structure
- Related data grouped
- Type safety improved
```

## Refactoring Best Practices

### 1. Test First
```bash
Always have comprehensive tests before refactoring
- Tests are your safety net
- Failing tests catch mistakes
- Green tests give confidence
```

### 2. Small Steps
```bash
Make smallest possible changes
- One logical change at a time
- Commit frequently
- Test after each change
- Easy to identify what broke
```

### 3. No Feature Changes
```bash
Refactoring = behavior preservation
- Don't add features during refactoring
- Don't fix bugs during refactoring (usually)
- Focus solely on code structure
- Separate concerns in separate PRs
```

### 4. Continuous Integration
```bash
Keep code working at all times
- Every commit should have passing tests
- No "broken" intermediate states
- Can pause refactoring anytime
```

### 5. Communicate
```bash
Keep team informed
- Share refactoring plans
- Get feedback early
- Coordinate with other work
- Avoid merge conflicts
```

## Common Pitfalls to Avoid

1. **Big bang refactoring** - Trying to change everything at once
2. **No tests** - Refactoring without test coverage
3. **Mixing concerns** - Adding features during refactoring
4. **Breaking backward compatibility** - Without migration plan
5. **Premature optimization** - Refactoring without evidence of need
6. **Scope creep** - Expanding refactoring beyond initial plan

## When to Stop Refactoring

Know when you're done:
- Success criteria met
- Code quality improved
- Tests passing
- Team satisfied
- Diminishing returns

Avoid gold plating:
- "Perfect" is the enemy of "better"
- Ship improvements incrementally
- Can always refactor more later

## Emergency Rollback

```bash
# If refactoring causes production issues

1. Immediate revert:
   git revert -m 1 [merge-commit-hash]

2. Deploy revert immediately

3. Post-mortem:
   - What went wrong?
   - What did tests miss?
   - How to prevent next time?

4. Fix and retry:
   - Address issues
   - Add missing tests
   - Attempt refactoring again
```

## Quick Reference

```bash
# Before starting
- Ensure tests exist and pass
- Create checkpoint
- Create branch

# During refactoring
- Small changes
- Test after each change
- Commit frequently
- Create checkpoints at milestones

# After refactoring
- Run full test suite
- Performance verification
- Code review
- Documentation update

# Commands
/workflow/create-plan
/development/test-agent
/workflow/checkpoint
/development/code-review
/development/performance-test
/github/create-pr
```

## Related Templates

- `feature-development.md` - For new features
- `bug-fix.md` - For bug fixes
- `performance-optimization.md` - For performance work
- `technical-debt.md` - For debt reduction

---

**Template Version:** 1.0.0
**Last Updated:** 2025-11-16
**Maintained By:** Claude Workflow Pro Team

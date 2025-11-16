# Feature Development Workflow Template

This template provides a structured approach to developing new features from planning through deployment.

## Template Variables

Replace these placeholders when using this template:

- `{{FEATURE_NAME}}` - Name of the feature being developed
- `{{FEATURE_DESCRIPTION}}` - Brief description of the feature
- `{{TARGET_BRANCH}}` - Target branch for the PR (usually main/master)
- `{{ASSIGNEE}}` - Person responsible for the feature

## Phase 1: Planning and Design

### 1.1 Requirements Analysis
```bash
# Use the plan agent to analyze requirements
/research/plan-agent

Task: Analyze requirements for {{FEATURE_NAME}}

Context:
- Feature: {{FEATURE_DESCRIPTION}}
- User stories: [List user stories]
- Acceptance criteria: [List criteria]
- Dependencies: [List dependencies]
```

### 1.2 Technical Design
```bash
# Create a detailed plan
/workflow/create-plan

Plan name: {{FEATURE_NAME}}-implementation
Description: Implementation plan for {{FEATURE_DESCRIPTION}}

Tasks:
1. [ ] Design data models/schemas
2. [ ] Plan API endpoints (if applicable)
3. [ ] Design UI components (if applicable)
4. [ ] Identify integration points
5. [ ] Plan testing strategy
6. [ ] Document edge cases
```

### 1.3 Validate Plan
```bash
# Validate the plan with the architecture agent
/workflow/validate-plan

Validate with: architecture, security, performance perspectives
```

## Phase 2: Implementation

### 2.1 Setup Feature Branch
```bash
# Create feature branch
git checkout -b feature/{{FEATURE_NAME}}
```

### 2.2 Implement Core Functionality
```bash
# Use specialized agents for implementation
/development/code-with-agent

Agent: full-stack (or choose appropriate agent)
Task: Implement {{FEATURE_NAME}} according to plan

Focus areas:
- Data layer
- Business logic
- API layer
- UI components
```

### 2.3 Checkpoint Progress
```bash
# Create checkpoint after major milestones
/workflow/checkpoint "{{FEATURE_NAME}}-core-complete"
```

## Phase 3: Testing

### 3.1 Unit Tests
```bash
# Generate unit tests
/development/test-agent

Task: Create comprehensive unit tests for {{FEATURE_NAME}}

Coverage targets:
- Business logic: 100%
- Edge cases: All identified cases
- Error handling: All paths
```

### 3.2 Integration Tests
```bash
# Create integration tests
/development/test-agent

Task: Create integration tests for {{FEATURE_NAME}}

Test scenarios:
- Happy path flows
- Error scenarios
- Edge cases
- Performance benchmarks
```

### 3.3 Run Test Suite
```bash
# Run all tests
npm test
# or
pytest
# or appropriate test command
```

## Phase 4: Code Review

### 4.1 Self Review
```bash
# Use code review agent
/development/code-review

Scope: feature/{{FEATURE_NAME}} branch
Focus: security, performance, maintainability
```

### 4.2 Address Issues
```bash
# Fix any issues found
/development/code-with-agent

Task: Address code review findings
Priority: Security > Performance > Style
```

## Phase 5: Documentation

### 5.1 Code Documentation
```bash
# Generate documentation
/development/docs-agent

Task: Document {{FEATURE_NAME}}

Include:
- API documentation
- Usage examples
- Configuration options
- Migration guide (if needed)
```

### 5.2 Update User Documentation
```bash
# Update user-facing docs
Update files:
- README.md (if feature affects usage)
- CHANGELOG.md (add feature entry)
- User guide (add feature section)
```

## Phase 6: Pre-Deployment

### 6.1 Performance Testing
```bash
# Run performance tests
/development/performance-test

Feature: {{FEATURE_NAME}}
Benchmarks: [Define expected performance]
```

### 6.2 Security Audit
```bash
# Security review
/development/security-audit

Scope: {{FEATURE_NAME}}
Focus: OWASP Top 10, data validation, auth/authz
```

### 6.3 Final Checkpoint
```bash
/workflow/checkpoint "{{FEATURE_NAME}}-ready-for-review"
```

## Phase 7: Pull Request

### 7.1 Prepare PR
```bash
# Create PR with detailed description
/github/create-pr

Title: feat: Add {{FEATURE_NAME}}

Description:
## Summary
{{FEATURE_DESCRIPTION}}

## Changes
- [List major changes]

## Testing
- [List testing performed]
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Manual testing complete

## Documentation
- [ ] Code documented
- [ ] User docs updated
- [ ] CHANGELOG updated

## Checklist
- [ ] Code review complete
- [ ] Tests passing
- [ ] Security audit done
- [ ] Performance validated
- [ ] Documentation complete

Closes: #[issue-number]
```

### 7.2 Request Reviews
```bash
# Assign reviewers
/github/request-review

Reviewers: [List team members]
Labels: feature, needs-review
```

## Phase 8: Address Feedback

### 8.1 Respond to Comments
```bash
# Address PR comments systematically
For each comment:
1. Acknowledge
2. Implement fix or explain reasoning
3. Request re-review if needed
```

### 8.2 Update Based on Feedback
```bash
# Make requested changes
/development/code-with-agent

Task: Address PR feedback
Context: [Paste relevant feedback]
```

## Phase 9: Deployment

### 9.1 Pre-Merge Checklist
```bash
# Verify before merge
- [ ] All reviews approved
- [ ] CI/CD pipeline passing
- [ ] No merge conflicts
- [ ] Branch up to date with target
- [ ] All discussions resolved
```

### 9.2 Merge
```bash
# Merge via GitHub UI or CLI
/github/merge-pr

Strategy: squash (or merge/rebase as per team policy)
Delete branch: yes
```

### 9.3 Post-Merge Actions
```bash
# After merge
1. Verify deployment
2. Monitor for issues
3. Update issue/ticket status
4. Communicate to team
```

## Rollback Plan

If issues are discovered post-deployment:

```bash
# Revert if needed
git revert [merge-commit-hash]

# Or hotfix
git checkout -b hotfix/{{FEATURE_NAME}}-fix
# Make fix
# Fast-track through review
```

## Metrics and Success Criteria

Track these metrics:

- Development time
- Test coverage achieved
- PR review cycles
- Time to merge
- Post-deployment issues
- User adoption

## Common Pitfalls to Avoid

1. **Skipping planning** - Always validate plan before coding
2. **Incomplete testing** - Aim for high coverage, test edge cases
3. **Poor documentation** - Document as you go, not after
4. **Ignoring security** - Security audit before PR
5. **Large PRs** - Break into smaller PRs if feature is large
6. **Skipping checkpoints** - Checkpoint at major milestones

## Template Usage Example

```bash
# Quick start with this template
FEATURE_NAME="user-authentication"
FEATURE_DESCRIPTION="Add OAuth2-based user authentication"
TARGET_BRANCH="main"
ASSIGNEE="@username"

# Follow phases 1-9 above, replacing variables
```

## Related Templates

- `bug-fix.md` - For fixing bugs
- `refactoring.md` - For code refactoring
- `documentation.md` - For documentation updates
- `security-patch.md` - For security fixes

## Customization

This template can be customized for your team:

1. Adjust phases based on your workflow
2. Add/remove checklist items
3. Modify agent usage based on available agents
4. Adapt to your CI/CD pipeline

---

**Template Version:** 1.0.0
**Last Updated:** 2025-11-16
**Maintained By:** Claude Workflow Pro Team

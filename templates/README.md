# Workflow Templates

This directory contains reusable workflow templates for common development tasks. These templates provide structured, step-by-step guidance for consistent and high-quality software development.

## Available Templates

### 1. Feature Development (`feature-development.md`)

**Use when:** Adding new functionality to your application

**Key phases:**
- Planning and design
- Implementation with checkpoints
- Comprehensive testing
- Code review
- Documentation
- Pull request and deployment

**Best for:**
- New features
- Feature enhancements
- User-facing functionality
- API additions

---

### 2. Bug Fix (`bug-fix.md`)

**Use when:** Fixing bugs or defects

**Key phases:**
- Investigation and root cause analysis
- Fix planning and validation
- Implementation with testing
- Regression test creation
- Post-deployment monitoring

**Severity-based workflows:**
- **Critical (P0):** Production down - Fix within hours
- **High (P1):** Major feature broken - Fix within 1-2 days
- **Medium (P2):** Minor feature broken - Fix within 1 week
- **Low (P3):** Cosmetic issues - Fix when convenient

**Best for:**
- Bug fixes
- Defect resolution
- Error handling
- Edge case fixes

---

### 3. Refactoring (`refactoring.md`)

**Use when:** Improving code structure without changing behavior

**Key phases:**
- Assessment and planning
- Test baseline establishment
- Incremental refactoring
- Continuous verification
- Documentation updates

**Refactoring patterns:**
- Extract method/class
- Rename for clarity
- Simplify complex logic
- Remove duplication
- Improve data structures

**Best for:**
- Code cleanup
- Technical debt reduction
- Maintainability improvements
- Performance optimization
- Architecture improvements

---

### 4. Security Audit (`security-audit.md`)

**Use when:** Conducting security reviews or audits

**Key phases:**
- Planning and scope definition
- Automated scanning
- Manual code review
- Dynamic testing
- Remediation and verification

**Coverage areas:**
- OWASP Top 10
- Authentication/authorization
- Input validation
- Cryptography
- Data protection
- Infrastructure security

**Best for:**
- Security audits
- Vulnerability assessment
- Penetration testing preparation
- Compliance requirements
- Security incidents

---

## How to Use Templates

### 1. Choose the Right Template

Select the template that matches your task:

```bash
# New feature
Use: feature-development.md

# Fixing a bug
Use: bug-fix.md

# Improving code quality
Use: refactoring.md

# Security review
Use: security-audit.md
```

### 2. Customize Template Variables

Each template has variables to replace:

```bash
# Example for feature development
{{FEATURE_NAME}} → "user-authentication"
{{FEATURE_DESCRIPTION}} → "Add OAuth2-based user authentication"
{{TARGET_BRANCH}} → "main"
{{ASSIGNEE}} → "@username"
```

### 3. Follow the Phases

Work through each phase sequentially:

```bash
# Each template is organized in phases
Phase 1: Planning
Phase 2: Implementation
Phase 3: Testing
Phase 4: Review
Phase 5: Deployment
...

# Complete phases in order
# Use checkpoints between phases
```

### 4. Adapt to Your Workflow

Templates are starting points - customize them:

```bash
# Add/remove steps based on your needs
# Adjust to your team's process
# Modify commands for your tools
# Adapt agent usage to available agents
```

## Template Structure

All templates follow a consistent structure:

```
# Template Title

## Template Variables
- Variables to customize

## Phase 1: [Name]
### 1.1 [Step]
- Commands to run
- Actions to take
- Checkpoints to create

## Phase 2: [Name]
### 2.1 [Step]
...

## Quick Reference
- Common commands
- Shortcuts
- Troubleshooting

## Related Templates
- Links to related templates
```

## Integration with Claude Workflow Pro

### Using Commands in Templates

Templates reference Claude Workflow Pro commands:

```bash
# Workflow commands
/workflow/create-plan
/workflow/validate-plan
/workflow/checkpoint
/workflow/resume-work

# Development commands
/development/code-with-agent
/development/test-agent
/development/code-review
/development/debug-agent

# GitHub commands
/github/create-pr
/github/request-review
/github/merge-pr

# Research commands
/research/plan-agent
/research/architecture-agent
```

### Using Agents in Templates

Templates leverage specialized agents:

```bash
# Common agents used in templates
- full-stack-agent: General development
- security-agent: Security reviews
- test-agent: Test generation
- debug-agent: Bug investigation
- architecture-agent: Design analysis
- performance-agent: Performance optimization
```

### Creating Checkpoints

All templates emphasize checkpoint usage:

```bash
# Checkpoint at major milestones
/workflow/checkpoint "{{task-name}}-{{milestone}}"

# Examples from templates:
/workflow/checkpoint "feature-auth-core-complete"
/workflow/checkpoint "bug-123-fix-implemented"
/workflow/checkpoint "refactor-api-step-3-complete"
/workflow/checkpoint "security-audit-scanning-complete"
```

## Best Practices

### 1. Planning First
```bash
# Always start with planning
- Use /workflow/create-plan
- Define clear objectives
- Break down into manageable tasks
- Validate plan before implementation
```

### 2. Incremental Progress
```bash
# Work in small increments
- One logical change at a time
- Test after each change
- Commit frequently
- Checkpoint at milestones
```

### 3. Comprehensive Testing
```bash
# Test thoroughly
- Unit tests
- Integration tests
- Manual testing
- Regression tests
- Security testing
- Performance testing
```

### 4. Documentation
```bash
# Document as you go
- Code comments
- API documentation
- Architecture docs
- CHANGELOG updates
- Migration guides
```

### 5. Code Review
```bash
# Always get review
- Self-review first
- Use code review agent
- Request peer review
- Address all feedback
```

## Template Customization

### Creating Custom Templates

You can create your own templates:

```bash
# 1. Copy existing template
cp feature-development.md my-custom-template.md

# 2. Modify for your needs
- Add/remove phases
- Adjust commands
- Customize checklist
- Add team-specific steps

# 3. Document variables
- List all {{VARIABLES}}
- Provide examples
- Document assumptions

# 4. Share with team
- Add to templates directory
- Update this README
- Train team on usage
```

### Team-Specific Adaptations

Adapt templates for your team:

```bash
# Examples:
- Add company-specific compliance steps
- Include custom CI/CD commands
- Reference team's coding standards
- Add required review processes
- Include deployment checklists
```

## Common Workflows

### New Feature Development
```bash
1. Use feature-development.md
2. Create plan
3. Validate with stakeholders
4. Implement incrementally
5. Test comprehensively
6. Document thoroughly
7. PR and deploy
```

### Bug Investigation and Fix
```bash
1. Use bug-fix.md
2. Reproduce bug
3. Root cause analysis
4. Plan fix
5. Implement with tests
6. Verify fix
7. Deploy and monitor
```

### Code Quality Improvement
```bash
1. Use refactoring.md
2. Assess current state
3. Establish test baseline
4. Refactor incrementally
5. Verify continuously
6. Document changes
7. Deploy gradually
```

### Security Assessment
```bash
1. Use security-audit.md
2. Define scope
3. Automated scanning
4. Manual review
5. Document findings
6. Prioritize remediation
7. Fix and verify
```

## Troubleshooting

### Template doesn't fit my use case
- Mix and match phases from different templates
- Create custom template
- Adapt existing template

### Commands not available
- Replace with equivalent commands
- Use alternative tools
- Request feature addition

### Template too detailed
- Skip optional steps
- Focus on critical phases
- Create simplified version

### Template too simple
- Add more detailed steps
- Include team-specific requirements
- Enhance with tools/automation

## Version Control

Templates are versioned:

```bash
# Each template includes version
Template Version: 1.0.0
Last Updated: 2025-11-16

# When updating templates:
- Increment version
- Document changes
- Notify team
- Update examples
```

## Feedback and Improvements

Help improve templates:

```bash
# Contribute improvements:
1. Use template in real project
2. Note pain points
3. Suggest improvements
4. Submit PR with updates

# Share your custom templates:
1. Create custom template
2. Document usage
3. Share with community
4. Contribute back
```

## Quick Start Examples

### Example 1: New Authentication Feature
```bash
# 1. Choose template
Template: feature-development.md

# 2. Set variables
FEATURE_NAME="oauth-authentication"
FEATURE_DESCRIPTION="Add OAuth2 login"
TARGET_BRANCH="main"

# 3. Follow phases
Phase 1: Plan authentication system
Phase 2: Implement OAuth flow
Phase 3: Test security
Phase 4: Review code
Phase 5: Document usage
Phase 6: Deploy to staging
Phase 7: Create PR
Phase 8: Production deployment
```

### Example 2: Critical Bug Fix
```bash
# 1. Choose template
Template: bug-fix.md

# 2. Set variables
BUG_ID="1234"
BUG_TITLE="Login fails for 2FA users"
SEVERITY="critical"

# 3. Fast-track workflow
Phase 1: Reproduce immediately
Phase 2: Quick root cause analysis
Phase 3: Implement minimal fix
Phase 4: Test fix works
Phase 5: Fast-track review
Phase 6: Emergency deployment
Phase 7: Monitor closely
```

### Example 3: API Refactoring
```bash
# 1. Choose template
Template: refactoring.md

# 2. Set variables
REFACTOR_NAME="api-simplification"
TARGET_COMPONENT="REST API layer"
SCOPE="medium"

# 3. Careful workflow
Phase 1: Assess current API complexity
Phase 2: Plan incremental changes
Phase 3: Ensure 100% test coverage
Phase 4: Refactor step by step
Phase 5: Verify after each step
Phase 6: Document new structure
Phase 7: Gradual rollout
```

### Example 4: Quarterly Security Audit
```bash
# 1. Choose template
Template: security-audit.md

# 2. Set variables
AUDIT_NAME="q4-2025-audit"
SCOPE="full-application"
URGENCY="routine"

# 3. Comprehensive workflow
Phase 1: Plan full scope audit
Phase 2: Automated dependency scan
Phase 3: Manual code review
Phase 4: Penetration testing
Phase 5: Document all findings
Phase 6: Prioritize by severity
Phase 7: Remediate critical issues
Phase 8: Verify all fixes
Phase 9: Implement preventive measures
Phase 10: Report to stakeholders
```

## Related Documentation

- **[USAGE.md](../USAGE.md)** - General usage guide
- **[CONTRIBUTING.md](../CONTRIBUTING.md)** - Contributing guidelines
- **[Examples](../examples/)** - Example projects
- **[FAQ.md](../docs/FAQ.md)** - Frequently asked questions

## Support

Need help with templates?

- Check **[FAQ.md](../docs/FAQ.md)**
- Read **[TROUBLESHOOTING.md](../docs/TROUBLESHOOTING.md)**
- See **[examples/](../examples/)** for real usage
- Open issue for template improvements

---

**Maintained By:** Claude Workflow Pro Team
**Last Updated:** 2025-11-16
**Version:** 1.0.0

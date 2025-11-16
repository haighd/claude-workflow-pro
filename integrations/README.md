# CI/CD Integrations

This directory contains integration templates for popular CI/CD platforms.

## Available Integrations

### GitHub Actions (`github-actions.yml`)

Pre-configured workflows for:
- **Basic CI/CD Pipeline** - Test, lint, security, deploy
- **Claude Workflow Automation** - Auto-review and auto-triage
- **Automated Release** - Automatic version detection and release
- **Scheduled Metrics** - Weekly productivity reports

**Setup:**
1. Copy templates to `.github/workflows/`
2. Configure secrets (SNYK_TOKEN, DEPLOY_TOKEN, SLACK_WEBHOOK)
3. Customize as needed

### GitLab CI (Coming Soon)

Templates for GitLab CI/CD pipelines.

### Jenkins (Coming Soon)

Jenkinsfile templates for Jenkins pipelines.

### CircleCI (Coming Soon)

CircleCI configuration templates.

## Usage

### GitHub Actions

```bash
# Copy template
cp integrations/github-actions.yml .github/workflows/claude-workflow.yml

# Customize for your project
vim .github/workflows/claude-workflow.yml

# Commit and push
git add .github/workflows/claude-workflow.yml
git commit -m "ci: add Claude Workflow automation"
git push
```

### Required Secrets

Configure these in your repository settings:

- `SNYK_TOKEN` - Snyk security scanning
- `DEPLOY_TOKEN` - Deployment authentication
- `SLACK_WEBHOOK` - Slack notifications
- `GITHUB_TOKEN` - Automatic (provided by GitHub)

## Best Practices

1. **Start Simple** - Begin with basic CI, add features incrementally
2. **Test First** - Always run tests before deployment
3. **Security Scanning** - Include security checks in pipeline
4. **Parallel Jobs** - Run independent jobs in parallel
5. **Cache Dependencies** - Cache node_modules, pip packages, etc.
6. **Fail Fast** - Fail early on critical errors
7. **Notifications** - Alert team of failures and releases

## Examples

See `examples/` directory for complete project setups with CI/CD configurations.

---

**Version:** 1.0.0

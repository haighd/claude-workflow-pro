# Migration Guides

**Purpose**: Step-by-step guides for upgrading between major versions of Claude Workflow Pro.

## Overview

This directory contains migration guides for upgrading Claude Workflow Pro across major versions. Each guide provides detailed instructions, automated tools, and examples to ensure smooth transitions.

## Available Migrations

### Current Version: 1.0.0

| From    | To      | Guide                        | Status      |
|---------|---------|------------------------------|-------------|
| 0.x     | 1.0.0   | [v1.0.0.md](./v1.0.0.md)     | Current     |
| 1.x     | 2.0.0   | [v2.0.0.md](./v2.0.0.md)     | Future      |

## Migration Process

### 1. Review the Migration Guide

Before upgrading, read the complete migration guide for your target version:

```bash
# View migration guide
cat docs/migrations/v2.0.0.md
```

### 2. Check Your Current Version

```bash
# Check installed version
/workflow/version

# Check for deprecations
/maintenance/check-deprecations
```

### 3. Backup Your Configuration

```bash
# Backup Claude Code settings
cp ~/.config/claude-code/settings.json ~/.config/claude-code/settings.json.backup

# Backup project configuration
cp .claude-settings.json .claude-settings.json.backup
```

### 4. Run Migration Analysis

```bash
# Analyze what needs to be migrated
/maintenance/migrate --version 2.0.0 --analyze

# Preview changes
/maintenance/migrate --version 2.0.0 --dry-run
```

### 5. Apply Migration

```bash
# Apply migration
/maintenance/migrate --version 2.0.0 --apply

# Verify migration
/maintenance/migrate --version 2.0.0 --verify
```

### 6. Test Your Workflows

```bash
# Test basic workflow
/workflow/init test-project

# Test specific features
/workflow/create-plan "Test migration"
/workflow/checkpoint create "Test checkpoint"
```

### 7. Rollback if Needed

```bash
# Rollback migration
/maintenance/migrate --version 2.0.0 --rollback

# Restore backup
cp ~/.config/claude-code/settings.json.backup ~/.config/claude-code/settings.json
```

## Migration Guide Template

Each migration guide follows this structure:

```markdown
# Migration Guide: v{VERSION}

## Overview
Brief description of major changes

## Breaking Changes
List of breaking changes with impact assessment

## New Features
Highlights of new capabilities

## Deprecations
Features deprecated in this version

## Migration Timeline
- Announcement: [DATE]
- Beta Release: [DATE]
- Stable Release: [DATE]
- Deprecation Complete: [DATE]

## Step-by-Step Migration

### Prerequisites
- Current version requirement
- Backup instructions
- System requirements

### Configuration Changes
- Old vs new configuration
- Automated migration tools
- Manual steps if needed

### Command Changes
- Renamed commands
- New command syntax
- Examples

### Agent Changes
- Updated agents
- New agents
- Removed agents

### Template Changes
- Updated templates
- Migration for custom templates

## Automated Migration

### Using Migration Tool
```bash
/maintenance/migrate --version {VERSION} --apply
```

### Manual Migration
Steps for manual migration if automation fails

## Common Issues

### Issue 1: [Description]
**Symptom**: ...
**Cause**: ...
**Solution**: ...

## Testing Your Migration

### Smoke Tests
Basic tests to verify migration success

### Integration Tests
Comprehensive testing checklist

## Rollback Instructions

### Automated Rollback
```bash
/maintenance/migrate --version {VERSION} --rollback
```

### Manual Rollback
Steps for manual rollback

## Getting Help

- GitHub Issues
- GitHub Discussions
- Documentation
- Community Support

## FAQ

Common migration questions and answers
```

## Version-Specific Notes

### v1.0.0 (Initial Release)

**Highlights**:
- 14 workflow phases implemented
- 50+ commands and agents
- Comprehensive documentation
- Testing framework
- Plugin system

**Migration from 0.x**:
- No breaking changes (initial release)
- Fresh installation recommended
- Import existing workflows manually

### v2.0.0 (Future)

**Planned Changes**:
- Enhanced plugin API
- Improved checkpoint format
- New workflow engine
- Breaking configuration changes

**Migration Timeline**:
- Announcement: Q2 2026
- Beta: Q3 2026
- Stable: Q4 2026

## Best Practices

### Before Migration

1. **Read the Full Guide**: Don't skip sections
2. **Backup Everything**: Configuration, workflows, data
3. **Test in Non-Production**: Use test projects first
4. **Check Dependencies**: Ensure compatibility
5. **Review Deprecations**: Understand what's changing

### During Migration

1. **Follow Steps in Order**: Don't skip ahead
2. **Use Automated Tools**: When available
3. **Take Notes**: Document any issues
4. **Monitor Output**: Watch for warnings/errors
5. **Don't Interrupt**: Let migration complete

### After Migration

1. **Verify Everything**: Run comprehensive tests
2. **Update Documentation**: Project-specific docs
3. **Train Team**: Share changes with collaborators
4. **Monitor for Issues**: Watch for unexpected behavior
5. **Provide Feedback**: Report issues or successes

## Automated Migration Tools

### Check for Deprecations

```bash
/maintenance/check-deprecations

# Output:
# ⚠️  Found 3 deprecations:
#
# 1. Command: /workflow/old-plan
#    Status: Deprecated in v1.5.0
#    Replacement: /workflow/plan create
#    Removal: v2.0.0
#
# 2. Config: workflow.checkpointDir
#    Status: Deprecated in v1.5.0
#    Replacement: workflow.checkpoint.directory
#    Removal: v2.0.0
```

### Analyze Migration Impact

```bash
/maintenance/migrate --version 2.0.0 --analyze

# Output:
# 📊 Migration Analysis: v1.5.0 → v2.0.0
#
# Configuration Changes:
#   - 5 settings need updating
#   - 2 settings deprecated
#   - 3 new settings available
#
# Commands:
#   - 4 commands renamed
#   - 1 command removed
#   - 6 new commands
#
# Agents:
#   - 2 agents updated
#   - 1 agent deprecated
#
# Estimated Time: 5-10 minutes
# Automated: 95%
# Manual Steps: 1
```

### Preview Migration

```bash
/maintenance/migrate --version 2.0.0 --dry-run

# Output:
# 🔍 Migration Preview (Dry Run)
#
# Configuration Changes:
#   .claude-settings.json:
#     - workflow.checkpointDir → workflow.checkpoint.directory
#     - workflow.maxSteps → workflow.execution.maxSteps
#
# Command Updates:
#   - /workflow/create-plan → /workflow/plan create
#   - /workflow/implement-plan → /workflow/plan implement
#
# No changes will be applied (dry run mode)
```

### Apply Migration

```bash
/maintenance/migrate --version 2.0.0 --apply

# Output:
# 🚀 Applying Migration: v1.5.0 → v2.0.0
#
# [1/5] Backing up configuration...
# [2/5] Updating .claude-settings.json...
# [3/5] Migrating command aliases...
# [4/5] Updating workflow files...
# [5/5] Verifying migration...
#
# ✅ Migration completed successfully!
#
# Summary:
#   - 5 files updated
#   - 3 commands migrated
#   - 0 errors
#   - 2 warnings
#
# Warnings:
#   - Custom template may need manual update
#   - Review new security settings
#
# Next Steps:
#   1. Run: /maintenance/migrate --verify
#   2. Test workflows
#   3. Review changes in .claude-settings.json
```

### Verify Migration

```bash
/maintenance/migrate --version 2.0.0 --verify

# Output:
# ✅ Migration Verification: v2.0.0
#
# Configuration: ✅ Valid
# Commands: ✅ All accessible
# Agents: ✅ All functional
# Templates: ✅ All compatible
# Workflows: ✅ All executable
#
# Migration successful! No issues found.
```

## Migration Checklist

Use this checklist for each migration:

```markdown
### Pre-Migration
- [ ] Read complete migration guide
- [ ] Backup configuration files
- [ ] Backup active workflows
- [ ] Document current setup
- [ ] Check system requirements
- [ ] Review breaking changes
- [ ] Test in non-production environment

### During Migration
- [ ] Run migration analysis
- [ ] Review dry-run output
- [ ] Apply migration
- [ ] Monitor for errors
- [ ] Document any issues

### Post-Migration
- [ ] Verify migration success
- [ ] Test critical workflows
- [ ] Test custom templates
- [ ] Test integrations
- [ ] Update team documentation
- [ ] Train team members
- [ ] Monitor for issues (24-48 hours)
- [ ] Provide feedback to maintainers

### Rollback Plan
- [ ] Know how to rollback
- [ ] Keep backups accessible
- [ ] Document rollback steps
- [ ] Test rollback procedure (if critical)
```

## Support Resources

### Documentation
- [DEPRECATION_POLICY.md](../DEPRECATION_POLICY.md)
- [VERSIONING.md](../VERSIONING.md)
- [CHANGELOG.md](../../CHANGELOG.md)
- [TROUBLESHOOTING.md](../TROUBLESHOOTING.md)

### Community
- [GitHub Issues](https://github.com/anthropics/claude-workflow-pro/issues)
- [GitHub Discussions](https://github.com/anthropics/claude-workflow-pro/discussions)
- [Discord Community](https://discord.gg/claude-workflow)

### Maintenance Commands
- `/maintenance/migrate` - Migration tool
- `/maintenance/check-deprecations` - Check for deprecations
- `/maintenance/health` - System health check
- `/maintenance/verify` - Verify installation

## Contributing

Found an issue with a migration guide? Please:

1. Check existing issues
2. Open a new issue with details
3. Tag with `migration` label
4. Include version numbers

Want to improve migration guides?

1. Fork the repository
2. Update the guide
3. Test the migration process
4. Submit a pull request

## Version History

| Version | Date       | Changes                          |
|---------|------------|----------------------------------|
| 1.0.0   | 2025-11-16 | Initial migration guide system   |

---

**Need Help?** Open an issue or start a discussion on GitHub.

# Deprecation Policy

**Version**: 1.0.0
**Last Updated**: 2025-11-16
**Status**: Active

## Overview

This document outlines the deprecation and sunset policies for Claude Workflow Pro features, commands, and APIs. Our goal is to balance innovation with stability, ensuring smooth transitions for users.

## Principles

### 1. User-First Approach
- Minimize disruption to existing workflows
- Provide ample notice and migration paths
- Clear communication at every stage
- Support during transition periods

### 2. Gradual Transitions
- Multi-phase deprecation process
- Overlapping support periods
- Automated migration tools when possible
- Backward compatibility where feasible

### 3. Transparent Communication
- Public deprecation notices
- Version-specific documentation
- Migration guides and examples
- Community engagement

## Versioning Strategy

We follow **Semantic Versioning 2.0.0** (semver.org):

```
MAJOR.MINOR.PATCH
```

- **MAJOR**: Breaking changes, incompatible API changes
- **MINOR**: New features, backward-compatible
- **PATCH**: Bug fixes, backward-compatible

### Version Support Lifecycle

```
┌─────────────┬──────────────┬─────────────┬──────────────┐
│   Active    │  Maintenance │ Security    │     EOL      │
│             │    Only      │   Only      │              │
├─────────────┼──────────────┼─────────────┼──────────────┤
│ 12 months   │   6 months   │  6 months   │  Deprecated  │
│             │              │             │              │
│ All updates │ Bug fixes    │ Security    │ No support   │
│ New features│ Security     │ fixes only  │              │
└─────────────┴──────────────┴─────────────┴──────────────┘
```

## Deprecation Process

### Phase 1: Announcement (3-6 months before deprecation)

**Actions**:
- Deprecation notice in CHANGELOG
- Documentation updated with warnings
- GitHub discussion thread created
- Social media/blog announcement

**Example Notice**:
```markdown
⚠️ **DEPRECATION NOTICE**: The `/workflow/old-command` command will be
deprecated in version 2.0.0 (estimated Q2 2026). Please migrate to
`/workflow/new-command`. See migration guide: docs/migrations/v2.0.0.md
```

### Phase 2: Soft Deprecation (Current version + 1 MAJOR)

**Actions**:
- Feature still works but shows warnings
- Documentation marked as "deprecated"
- Migration guide available
- Automated migration tool (if applicable)

**Runtime Warning Example**:
```
⚠️  WARNING: /workflow/old-command is deprecated and will be removed
in v3.0.0. Use /workflow/new-command instead.
Migration guide: /workflow/help migrate old-command
```

### Phase 3: Hard Deprecation (Current version + 2 MAJOR)

**Actions**:
- Feature removed from codebase
- Documentation archived
- Migration guide remains available
- Error message with migration path

**Error Message Example**:
```
❌ ERROR: /workflow/old-command was removed in v3.0.0
Please use: /workflow/new-command
Migration guide: https://docs.claude-workflow.pro/migrations/v3.0.0
```

## Deprecation Categories

### 1. Commands

**Timeline**: Minimum 6 months notice

**Process**:
1. Announce deprecation in release notes
2. Add runtime warnings in next minor version
3. Provide equivalent replacement command
4. Create migration guide
5. Remove in next MAJOR version

**Example**:
```yaml
Command: /workflow/create-plan
Status: Deprecated in v1.5.0
Removal: v2.0.0
Replacement: /workflow/plan create
Migration: docs/migrations/plan-command.md
```

### 2. Configuration Options

**Timeline**: Minimum 6 months notice

**Process**:
1. Support both old and new options
2. Log warnings when old options used
3. Auto-migrate configuration files
4. Remove old options in next MAJOR

**Example**:
```json
{
  "workflow.checkpointDir": "deprecated",
  "workflow.checkpoint.directory": "new option",
  "_migration": "Auto-converted on 2025-11-16"
}
```

### 3. Agents

**Timeline**: Minimum 3 months notice

**Process**:
1. Mark agent as deprecated in metadata
2. Show warnings in agent output
3. Provide replacement agent
4. Archive agent in next MAJOR

### 4. Templates

**Timeline**: Minimum 3 months notice

**Process**:
1. Add deprecation notice to template
2. Create updated version
3. Move to archive directory
4. Remove in next MAJOR

### 5. Integrations

**Timeline**: Based on third-party service

**Special Considerations**:
- External API changes may force immediate deprecation
- Security vulnerabilities require immediate action
- Best-effort backward compatibility

## Breaking Changes

### What Constitutes a Breaking Change

- Removing or renaming commands
- Changing command arguments (required/optional)
- Removing configuration options
- Changing output format significantly
- Removing agents or templates
- Major architectural changes

### Breaking Change Process

1. **Proposal**: RFC (Request for Comments) in GitHub Discussions
2. **Community Feedback**: 2-week minimum feedback period
3. **Implementation**: Feature flagged initially
4. **Migration Guide**: Comprehensive guide created
5. **Beta Testing**: Optional beta period
6. **Release**: In next MAJOR version only

### Breaking Change Checklist

- [ ] RFC created and community consulted
- [ ] Migration guide written
- [ ] Automated migration tool (if possible)
- [ ] Tests updated
- [ ] Documentation updated
- [ ] CHANGELOG entry
- [ ] Release notes entry
- [ ] Announcement prepared

## Communication Channels

### Before Deprecation
1. **GitHub Discussions**: Feature-specific threads
2. **CHANGELOG.md**: Deprecation notices section
3. **Documentation**: Warning banners
4. **Release Notes**: Highlighted section

### During Deprecation
1. **Runtime Warnings**: In CLI output
2. **Documentation**: "Deprecated" badges
3. **Migration Guides**: Step-by-step instructions
4. **Support Channels**: Issue templates

### After Removal
1. **Error Messages**: Clear migration paths
2. **Archived Documentation**: Historical reference
3. **Migration Tools**: Remain available

## Migration Support

### Migration Guides

Each deprecated feature includes:

```markdown
# Migration Guide: [Feature Name]

## Overview
Brief description of what changed and why

## Impact
Who is affected and how

## Timeline
- Deprecated: v1.5.0 (2025-11-16)
- Removed: v2.0.0 (2026-06-01)

## Migration Steps

### Before
```bash
# Old command
/workflow/old-command --arg value
```

### After
```bash
# New command
/workflow/new-command --new-arg value
```

## Automated Migration

```bash
# Run migration tool
/maintenance/migrate old-command
```

## FAQ
Common questions and answers

## Support
Where to get help
```

### Automated Migration Tools

When possible, provide automated migration:

```bash
# Analyze what needs migration
/maintenance/migrate --analyze

# Preview changes
/maintenance/migrate --dry-run

# Apply migration
/maintenance/migrate --apply

# Rollback if needed
/maintenance/migrate --rollback
```

## Exceptions and Emergency Deprecation

### Security Vulnerabilities

**Immediate deprecation** if:
- Critical security vulnerability discovered
- Third-party dependency compromise
- Data breach risk

**Process**:
1. Immediate security patch release
2. Emergency deprecation notice
3. Expedited migration guide
4. Direct user notification if possible

### Legal/Compliance Issues

**Immediate deprecation** if:
- Legal requirement
- Compliance violation
- Licensing conflict

### External Service Shutdown

**Accelerated deprecation** if:
- Third-party API discontinued
- Service provider shutdown
- Breaking API changes from provider

## Long-term Support (LTS)

### LTS Versions

Every 4th MAJOR version is designated LTS:

```
v1.0.0 (LTS) ────── 24 months support
v2.0.0     ─────── 12 months support
v3.0.0     ─────── 12 months support
v4.0.0 (LTS) ────── 24 months support
```

### LTS Support Includes
- Security updates
- Critical bug fixes
- Backported patches (selective)
- Extended documentation

### LTS Does NOT Include
- New features
- Non-critical bug fixes
- Performance optimizations
- Dependency updates (unless security-related)

## Frequently Asked Questions

### Q: How much notice will I get before a feature is removed?
**A**: Minimum 6 months for commands, 3 months for agents/templates. LTS versions get longer support.

### Q: Will automated migration tools be provided?
**A**: Yes, when technically feasible. We provide migration guides for all deprecations.

### Q: Can I continue using deprecated features?
**A**: Yes, until they're removed in a MAJOR version. You'll see warnings but functionality remains.

### Q: What if I depend on a deprecated feature?
**A**: Use the migration guide, reach out for support, or stay on current MAJOR version until ready to migrate.

### Q: How do I track deprecations?
**A**: Check CHANGELOG.md, release notes, and use `/maintenance/check-deprecations` command.

### Q: Can deprecated features be un-deprecated?
**A**: In rare cases, based on community feedback during the announcement phase.

## Responsibilities

### Maintainers
- Follow deprecation process strictly
- Provide comprehensive migration guides
- Respond to migration questions
- Monitor feedback during deprecation period

### Users
- Subscribe to release notifications
- Test new versions before deploying
- Report migration issues early
- Participate in RFC discussions

## Review and Updates

This policy is reviewed:
- **Quarterly**: Minor adjustments
- **Annually**: Major review
- **As needed**: Based on community feedback

## Version History

| Version | Date       | Changes                    |
|---------|------------|----------------------------|
| 1.0.0   | 2025-11-16 | Initial deprecation policy |

## References

- [Semantic Versioning 2.0.0](https://semver.org/)
- [CHANGELOG.md](../CHANGELOG.md)
- [VERSIONING.md](./VERSIONING.md)
- [Migration Guides](./migrations/)
- [LTS Policy](./LTS.md)

---

**Questions?** Open an issue or discussion on GitHub.
**Concerns?** Contact maintainers at [email protected]

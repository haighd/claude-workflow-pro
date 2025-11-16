# Version Migration Tool

**Command**: `/maintenance/migrate`
**Purpose**: Automated migration between Claude Workflow Pro versions
**Category**: Maintenance & Updates

## Overview

Automates the migration process when upgrading Claude Workflow Pro to a new major version. Handles configuration updates, command migrations, checkpoint conversions, and plugin updates.

## Usage

```bash
# Check what needs migration
/maintenance/migrate --version 2.0.0 --check

# Analyze migration impact
/maintenance/migrate --version 2.0.0 --analyze

# Preview changes (dry run)
/maintenance/migrate --version 2.0.0 --dry-run

# Apply migration
/maintenance/migrate --version 2.0.0 --apply

# Verify migration
/maintenance/migrate --version 2.0.0 --verify

# Rollback migration
/maintenance/migrate --version 2.0.0 --rollback
```

## Migration Phases

### Phase 1: Check

Identify what needs to be migrated:

```bash
/maintenance/migrate --version 2.0.0 --check

# Output:
# 📊 Migration Check: v1.5.0 → v2.0.0
#
# Configuration Files:
#   ⚠️  2 files need updates
#   - ~/.config/claude-code/settings.json
#   - .claude-settings.json
#
# Commands:
#   ⚠️  5 commands have new syntax
#   - /workflow/create-plan → /workflow/plan create
#   - /workflow/validate-plan → /workflow/plan validate
#   - /workflow/implement-plan → /workflow/plan execute
#   - /github/auto-review → /github/review auto
#   - /github/auto-triage → /github/triage auto
#
# Checkpoints:
#   ⚠️  12 checkpoints in old format
#   ✅ Can be auto-converted
#
# Plugins:
#   ⚠️  2 plugins need updates
#   ❌ 1 plugin incompatible (contact author)
#
# Migration feasibility: ✅ AUTOMATED (95%)
# Manual steps required: 1
```

### Phase 2: Analyze

Detailed impact analysis:

```bash
/maintenance/migrate --version 2.0.0 --analyze

# Output:
# 🔍 Migration Analysis: v1.5.0 → v2.0.0
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Configuration Changes
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# ~/.config/claude-code/settings.json:
#   workflow.checkpointDir → workflow.checkpoint.directory
#     Current: "docs/sessions"
#     New: {"directory": "docs/sessions", "format": "v2"}
#
#   workflow.maxSteps → workflow.execution.maxSteps
#     Current: 100
#     New: {"maxSteps": 100, "parallel": false}
#
# .claude-settings.json:
#   Similar changes for project config
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Command Updates
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Aliases will be created:
#   /workflow/create-plan → /workflow/plan create
#   (Alias valid until v3.0.0)
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Checkpoint Conversion
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# 12 checkpoints will be converted:
#   Format: v1 → v2
#   Benefits: Compression, faster loading
#   Backward compatible: Yes (v2 reads v1)
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Plugin Updates
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Compatible:
#   ✅ custom-metrics-plugin v1.2.0
#
# Needs Update:
#   ⚠️  test-generator v1.0.0
#      Update available: v2.0.0
#      Run: /plugins/update test-generator
#
#   ⚠️  custom-validator v0.9.0
#      Update available: v1.0.0
#      Run: /plugins/update custom-validator
#
# Incompatible:
#   ❌ old-integration v0.5.0
#      No v2-compatible version available
#      Action: Remove or contact plugin author
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Estimated Time & Effort
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Time: 5-10 minutes
# Automated: 95%
# Manual steps: 1 (review incompatible plugin)
#
# Risk Level: LOW
# Rollback available: YES
```

### Phase 3: Dry Run

Preview all changes without applying:

```bash
/maintenance/migrate --version 2.0.0 --dry-run

# Output:
# 🔍 Migration Preview (Dry Run)
#
# The following changes would be made:
#
# [1/4] Configuration Updates
#
# File: ~/.config/claude-code/settings.json
# ─────────────────────────────────────────────
# - "workflow": {
# -   "checkpointDir": "docs/sessions",
# -   "maxSteps": 100
# - }
# + "workflow": {
# +   "checkpoint": {
# +     "directory": "docs/sessions",
# +     "format": "v2"
# +   },
# +   "execution": {
# +     "maxSteps": 100,
# +     "parallel": false
# +   }
# + }
#
# [2/4] Checkpoint Conversions
#
# docs/sessions/checkpoint-2025-11-16.md
#   Format: v1 → v2
#   Size: 2.3 KB → 1.1 KB (52% smaller)
#
# [12 more checkpoints...]
#
# [3/4] Plugin Updates
#
# Update: test-generator v1.0.0 → v2.0.0
# Update: custom-validator v0.9.0 → v1.0.0
#
# [4/4] Create Command Aliases
#
# /workflow/create-plan → /workflow/plan create
# /workflow/validate-plan → /workflow/plan validate
# [3 more aliases...]
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Summary
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# No changes applied (dry run mode)
#
# To apply migration:
#   /maintenance/migrate --version 2.0.0 --apply
```

### Phase 4: Apply

Execute the migration:

```bash
/maintenance/migrate --version 2.0.0 --apply

# Output:
# 🚀 Applying Migration: v1.5.0 → v2.0.0
#
# [1/6] Creating backup...
#   ✅ Configuration backed up
#   ✅ Checkpoints backed up
#   📁 Backup location: ~/.claude-workflow-backup/2025-11-16-143000
#
# [2/6] Updating configuration...
#   ✅ ~/.config/claude-code/settings.json updated
#   ✅ .claude-settings.json updated
#
# [3/6] Converting checkpoints...
#   ✅ checkpoint-2025-11-16.md (v1 → v2)
#   ✅ checkpoint-2025-11-15.md (v1 → v2)
#   [10 more...]
#   ✅ 12/12 checkpoints converted
#
# [4/6] Updating plugins...
#   ✅ test-generator updated to v2.0.0
#   ✅ custom-validator updated to v1.0.0
#   ⚠️  old-integration disabled (incompatible)
#
# [5/6] Creating command aliases...
#   ✅ 5 aliases created
#   💡 Old commands will work until v3.0.0
#
# [6/6] Verifying migration...
#   ✅ Configuration valid
#   ✅ Checkpoints readable
#   ✅ Plugins functional
#   ✅ Commands accessible
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Migration Complete! ✅
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Migrated: v1.5.0 → v2.0.0
# Duration: 3m 42s
#
# Summary:
#   ✅ 2 configuration files updated
#   ✅ 12 checkpoints converted
#   ✅ 2 plugins updated
#   ⚠️  1 plugin disabled
#   ✅ 5 command aliases created
#
# Warnings:
#   ⚠️  Plugin 'old-integration' disabled (incompatible)
#      Action: Remove or check for updates
#
# Next Steps:
#   1. Run: /maintenance/migrate --verify
#   2. Test your workflows
#   3. Review changes in configuration files
#   4. Update or remove incompatible plugins
#
# Rollback available:
#   /maintenance/migrate --version 2.0.0 --rollback
#
# Backup location:
#   ~/.claude-workflow-backup/2025-11-16-143000
```

### Phase 5: Verify

Verify migration success:

```bash
/maintenance/migrate --version 2.0.0 --verify

# Output:
# ✅ Migration Verification: v2.0.0
#
# Configuration: ✅ Valid
#   - Schema compliance: ✅ Pass
#   - Required fields: ✅ Present
#   - No deprecated options: ✅ Pass
#
# Commands: ✅ All accessible
#   - Core commands: ✅ 50/50
#   - Aliases: ✅ 5/5
#
# Agents: ✅ All functional
#   - Core agents: ✅ 20/20
#   - Load test: ✅ Pass
#
# Templates: ✅ All compatible
#   - Workflow templates: ✅ 4/4
#   - Syntax validation: ✅ Pass
#
# Checkpoints: ✅ All readable
#   - Format v2: ✅ 12/12
#   - Load test: ✅ Pass
#
# Plugins: ⚠️  Issues detected
#   - Compatible: ✅ 2/3
#   - Incompatible: ⚠️  1/3 (disabled)
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Verification Result: ✅ PASSED
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Migration successful! No critical issues found.
#
# Recommendations:
#   • Update or remove incompatible plugin: old-integration
#   • Test your workflows thoroughly
#   • Review new features in v2.0.0
```

### Phase 6: Rollback

If needed, rollback the migration:

```bash
/maintenance/migrate --version 2.0.0 --rollback

# Output:
# ⏪ Rolling Back Migration: v2.0.0 → v1.5.0
#
# [1/4] Restoring configuration...
#   ✅ Restored: ~/.config/claude-code/settings.json
#   ✅ Restored: .claude-settings.json
#
# [2/4] Restoring checkpoints...
#   ✅ Restored 12 checkpoints to v1 format
#
# [3/4] Restoring plugins...
#   ✅ Restored plugin versions
#   ✅ Re-enabled old-integration
#
# [4/4] Removing aliases...
#   ✅ Removed v2 command aliases
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Rollback Complete! ✅
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Reverted to: v1.5.0
# Duration: 1m 23s
#
# All changes have been undone.
# Your system is back to v1.5.0 state.
```

## Migration Scope

### What Gets Migrated

✅ **Configuration Files**
- Global settings (`~/.config/claude-code/settings.json`)
- Project settings (`.claude-settings.json`)
- Environment variables

✅ **Checkpoints**
- Format conversion
- Metadata updates
- Compression (if applicable)

✅ **Command References**
- Create aliases for old commands
- Update scripts/workflows using commands

✅ **Plugins**
- Update compatible plugins
- Disable incompatible plugins
- Migrate plugin configurations

✅ **Templates**
- Update template syntax
- Migrate template variables

### What Doesn't Get Migrated

❌ **Custom Code**
- User scripts
- Custom integrations
- External tools

❌ **Data Files**
- Project source code
- Build artifacts
- Log files

❌ **External Services**
- GitHub repositories
- CI/CD configurations
- Cloud services

## Backup and Safety

### Automatic Backups

Every migration creates automatic backups:

```
~/.claude-workflow-backup/
  └── 2025-11-16-143000/
      ├── settings.json
      ├── .claude-settings.json
      ├── checkpoints/
      │   └── [all checkpoint files]
      └── plugins/
          └── [plugin configurations]
```

### Manual Backups

Create additional backups:

```bash
# Backup configuration
/maintenance/migrate --backup-only

# Backup to specific location
/maintenance/migrate --backup-only --output /path/to/backup

# Restore from backup
/maintenance/migrate --restore-backup /path/to/backup
```

### Safety Features

- **Dry run mode**: Preview changes before applying
- **Automatic backups**: Every migration backed up
- **Verification**: Post-migration validation
- **Rollback**: Undo migrations if needed
- **Error handling**: Graceful failure with rollback

## Migration Strategies

### Strategy 1: Direct Migration

Migrate directly to target version:

```bash
# v1.5.0 → v2.0.0
/maintenance/migrate --version 2.0.0 --apply
```

**Pros**: Fastest, single migration
**Cons**: Larger change set, higher risk

### Strategy 2: Incremental Migration

Migrate through intermediate versions:

```bash
# v1.3.0 → v1.5.0 → v2.0.0
/maintenance/migrate --version 1.5.0 --apply
/maintenance/migrate --version 2.0.0 --apply
```

**Pros**: Smaller change sets, lower risk
**Cons**: More steps, takes longer

### Strategy 3: Parallel Testing

Test migration in isolated environment:

```bash
# Clone to test directory
cp -r project test-migration
cd test-migration

# Test migration
/maintenance/migrate --version 2.0.0 --apply

# Verify and test
/maintenance/migrate --verify
# Run workflow tests

# If successful, migrate production
cd ../project
/maintenance/migrate --version 2.0.0 --apply
```

**Pros**: Risk-free testing, confidence
**Cons**: Requires duplicate environment

## Command-Line Options

### Analysis Options

```bash
--check            # Check migration requirements
--analyze          # Detailed impact analysis
--dry-run          # Preview changes without applying
```

### Execution Options

```bash
--apply            # Apply migration
--verify           # Verify migration success
--rollback         # Undo migration
```

### Scope Options

```bash
--component <name> # Migrate specific component
                   # (config, checkpoints, plugins, commands)
--skip <component> # Skip specific component
```

### Output Options

```bash
--verbose          # Detailed output
--quiet            # Minimal output
--format json      # JSON output
--output <file>    # Save to file
```

### Safety Options

```bash
--backup-only      # Create backup without migrating
--no-backup        # Skip backup (not recommended)
--force            # Skip confirmations
--yes              # Answer yes to all prompts
```

## Examples

### Example 1: Safe Migration

```bash
# Step 1: Check requirements
/maintenance/migrate --version 2.0.0 --check

# Step 2: Analyze impact
/maintenance/migrate --version 2.0.0 --analyze

# Step 3: Preview changes
/maintenance/migrate --version 2.0.0 --dry-run

# Step 4: Apply migration
/maintenance/migrate --version 2.0.0 --apply

# Step 5: Verify success
/maintenance/migrate --version 2.0.0 --verify
```

### Example 2: Component-Specific Migration

```bash
# Migrate only configuration
/maintenance/migrate --version 2.0.0 --component config --apply

# Migrate only checkpoints
/maintenance/migrate --version 2.0.0 --component checkpoints --apply

# Migrate plugins separately
/maintenance/migrate --version 2.0.0 --component plugins --apply
```

### Example 3: Migration with Manual Steps

```bash
# Apply automated parts
/maintenance/migrate --version 2.0.0 --apply

# Output lists manual steps:
# ⚠️  Manual steps required:
#   1. Review plugin: old-integration (incompatible)
#   2. Update custom scripts using old command syntax

# Complete manual steps
# Then verify
/maintenance/migrate --version 2.0.0 --verify
```

## Troubleshooting

### Issue: Migration fails partway through

**Solution**: Migration is atomic, will auto-rollback on failure

```bash
# Check status
/maintenance/migrate --version 2.0.0 --status

# If needed, manual rollback
/maintenance/migrate --version 2.0.0 --rollback
```

### Issue: Plugin incompatibility

**Solution**: Update, disable, or find alternative

```bash
# Check for plugin updates
/plugins/check-updates

# Update specific plugin
/plugins/update plugin-name

# Or disable incompatible plugin
/plugins/disable plugin-name
```

### Issue: Custom configuration lost

**Solution**: Restore from backup

```bash
# List backups
ls ~/.claude-workflow-backup/

# Restore specific backup
/maintenance/migrate --restore-backup ~/.claude-workflow-backup/2025-11-16-143000
```

## Related Commands

- `/maintenance/check-deprecations` - Check for deprecated features
- `/maintenance/check-updates` - Check for available updates
- `/maintenance/health` - System health check
- `/plugins/check-updates` - Check plugin updates

## Version History

| Version | Changes |
|---------|---------|
| 1.0.0   | Initial migration tool |

---

**Migration Support**: See [docs/migrations/](../../docs/migrations/) for version-specific guides.

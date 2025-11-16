# Backward Compatibility Guide

**Version**: 1.0.0
**Last Updated**: 2025-11-16
**Status**: Active

## Overview

This document outlines Claude Workflow Pro's commitment to backward compatibility, testing strategies, and guidelines for maintaining compatibility across versions.

## Compatibility Promise

### Within MAJOR Versions

Within the same MAJOR version (e.g., v1.x), we **guarantee**:

✅ **Configuration Compatibility**
- Configuration files from older MINOR/PATCH versions will work
- New options are always optional
- Default values maintain previous behavior
- Auto-migration for deprecated options

✅ **Command Compatibility**
- Existing commands maintain same syntax
- Arguments remain backward compatible
- Output format stays consistent (or expanded)
- New commands never conflict with existing ones

✅ **Agent Compatibility**
- Agents continue to function
- Agent interfaces remain stable
- Metadata format backward compatible
- New agents don't break existing workflows

✅ **Template Compatibility**
- Templates continue to work
- Variable syntax remains stable
- New features are opt-in
- Template format auto-upgraded when possible

✅ **Checkpoint Compatibility**
- Old checkpoints can be resumed
- Checkpoint format backward compatible
- Metadata remains readable
- Auto-migration for format updates

✅ **Plugin API Stability**
- Plugin API version remains stable
- Plugins built for v1.0 work in v1.x
- New API features are additive only
- Deprecation warnings for changes in v2.0

### Across MAJOR Versions

Between MAJOR versions (e.g., v1.x to v2.x):

⚠️ **Breaking Changes Allowed**
- Configuration schema may change
- Commands may be renamed or removed
- Agent interfaces may change
- Plugin API may have breaking changes

✅ **But With Support**
- Migration guides provided
- Automated migration tools
- Deprecation warnings in advance
- Compatibility layer when feasible

## Compatibility Matrix

### Current Version: v1.0.0

| Component | v1.0 | v1.1 | v1.2 | v2.0 | v3.0 |
|-----------|------|------|------|------|------|
| **Config Files** | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| **Commands** | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| **Agents** | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| **Templates** | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| **Checkpoints** | ✅ | ✅ | ✅ | ✅* | ✅* |
| **Plugins** | ✅ | ✅ | ✅ | ❌ | ❌ |

**Legend**:
- ✅ Fully compatible
- ✅* Compatible with auto-migration
- ⚠️ Migration required
- ❌ Not compatible (must upgrade plugin)

### Plugin API Compatibility

| Plugin API | v1.0-1.x | v2.0-2.x | v3.0-3.x |
|------------|----------|----------|----------|
| API v1 | ✅ | ❌ | ❌ |
| API v2 | ❌ | ✅ | ⚠️ |
| API v3 | ❌ | ❌ | ✅ |

## Compatibility Testing

### Automated Tests

We run comprehensive compatibility tests:

```bash
# Test suite structure
tests/compatibility/
├── config-compatibility.sh      # Config file backward compat
├── command-compatibility.sh     # Command syntax stability
├── agent-compatibility.sh       # Agent interface stability
├── checkpoint-compatibility.sh  # Checkpoint format compat
└── plugin-api-compatibility.sh  # Plugin API stability
```

### Test Coverage

#### Configuration Compatibility

```bash
# Test: v1.0 config works in v1.5
cp tests/fixtures/config-v1.0.json .claude-settings.json
/workflow/init test-project
# Expected: Success

# Test: Deprecated options migrated
/maintenance/check-deprecations
# Expected: Warnings, not errors
```

#### Command Compatibility

```bash
# Test: Old commands work with aliases
/workflow/create-plan "Test"  # v1.x syntax
# Expected: Works via alias in v2.x

# Test: Command output parseable
output=$(/workflow/validate-plan --format json)
# Expected: JSON structure unchanged
```

#### Checkpoint Compatibility

```bash
# Test: Old checkpoints resume
/workflow/resume-work @tests/fixtures/checkpoint-v1.0.md
# Expected: Successful resume with migration
```

#### Plugin Compatibility

```bash
# Test: Plugin API v1 in v1.x
/plugins/test test-plugin-api-v1
# Expected: Success

# Test: Plugin API v1 in v2.x
/plugins/test test-plugin-api-v1
# Expected: Error with clear message
```

### Manual Testing

Before each release, we manually test:

1. **Upgrade Path Testing**
   - Install oldest v1.x
   - Upgrade incrementally to latest
   - Verify all features work

2. **Real-world Workflow Testing**
   - Use actual projects from v1.0
   - Run complete workflows
   - Verify checkpoints resume correctly

3. **Plugin Testing**
   - Test popular community plugins
   - Verify plugin marketplace compatibility
   - Check plugin API stability

## Breaking Changes Policy

### What Constitutes a Breaking Change

A change is "breaking" if it:

❌ **Requires Code Changes**
- Changes command syntax
- Removes configuration options
- Changes output format (structure)
- Removes agents or templates
- Changes plugin API signatures

❌ **Changes Default Behavior**
- Alters workflow execution
- Modifies checkpoint format (non-compatible)
- Changes validation rules (stricter)

❌ **Removes Features**
- Deletes commands
- Removes agents
- Eliminates configuration options

### What Is NOT a Breaking Change

These changes are allowed in MINOR versions:

✅ **Additive Changes**
- New commands
- New configuration options (optional)
- New agents or templates
- Extended output (backward compatible)

✅ **Bug Fixes**
- Fixing incorrect behavior
- Performance improvements
- Security patches

✅ **Deprecations**
- Marking features for future removal
- Adding warnings (non-blocking)

## Deprecation Process

See [DEPRECATION_POLICY.md](./DEPRECATION_POLICY.md) for complete details.

### Summary

```
Phase 1: Announcement (6+ months notice)
  ↓
Phase 2: Soft Deprecation (warnings)
  ↓
Phase 3: Hard Deprecation (removed in next MAJOR)
```

### Compatibility Layer

During deprecation, we provide compatibility layer:

```javascript
// Example: Command alias
// Old command (deprecated)
/workflow/create-plan "Feature"

// Internally mapped to:
/workflow/plan create "Feature"

// User sees warning:
// ⚠️ /workflow/create-plan is deprecated
//    Use /workflow/plan create instead
//    This alias will be removed in v2.0.0
```

## Forward Compatibility

### Configuration Files

We strive for forward compatibility but don't guarantee it:

```json
// v1.5 config
{
  "workflow": {
    "checkpoint": {
      "directory": "docs/sessions",
      "format": "v2"
    }
  }
}

// Used in v1.0
// Behavior: Unknown options ignored with warning
// ⚠️ Unknown option 'format' - requires v1.5+
```

### Checkpoints

Newer checkpoints may work in older versions (degraded):

```markdown
# v1.5 checkpoint with new metadata
---
version: 1.5.0
features: ["parallel-execution"]  # New in v1.5
---

# Loaded in v1.0
# Behavior: Unknown metadata ignored
# Core checkpoint data still usable
```

## Compatibility Helpers

### Version Detection

```bash
# Check minimum required version
if ! /maintenance/check-version --min 1.5.0; then
  echo "This workflow requires v1.5.0+"
  exit 1
fi
```

### Feature Detection

```bash
# Check if feature available
if /maintenance/has-feature parallel-execution; then
  /workflow/plan execute --parallel
else
  /workflow/plan execute
fi
```

### Graceful Degradation

```json
{
  "workflow": {
    "features": {
      "parallel": {
        "enabled": true,
        "fallback": "sequential"
      }
    }
  }
}
```

## Migration Support

### Automated Migration

```bash
# Check what needs migration
/maintenance/migrate --check

# Preview migration
/maintenance/migrate --dry-run

# Apply migration
/maintenance/migrate --apply
```

### Manual Migration

When automation isn't possible, we provide:

✅ **Detailed Migration Guides**
- Step-by-step instructions
- Before/after examples
- Common issues and solutions

✅ **Migration Scripts**
- Helper scripts for bulk changes
- Validation tools
- Rollback procedures

✅ **Community Support**
- Migration assistance in forums
- Example migrations
- Best practices documentation

## Best Practices for Users

### 1. Stay Within MAJOR Versions

```bash
# Recommended: Stay on v1.x for stability
git checkout v1.x

# Upgrade MINOR/PATCH versions safely
git pull origin v1.x
```

### 2. Test Before Upgrading

```bash
# Test in separate environment
git clone project test-upgrade
cd test-upgrade
git checkout v1.6.0

# Run comprehensive tests
./run-tests.sh

# If successful, upgrade production
```

### 3. Use Configuration Versioning

```json
{
  "version": "1.5.0",
  "config": {
    // Your settings
  }
}
```

### 4. Pin Plugin Versions

```json
{
  "plugins": {
    "my-plugin": "1.2.3",  // Exact version
    "other-plugin": "^1.2.0"  // Compatible versions
  }
}
```

### 5. Check Deprecations Regularly

```bash
# Weekly deprecation check
/maintenance/check-deprecations

# Include in CI/CD
# See: .github/workflows/check-deprecations.yml
```

## Best Practices for Plugin Developers

### 1. Specify Compatible Versions

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "claudeWorkflow": {
    "apiVersion": 1,
    "minVersion": "1.0.0",
    "maxVersion": "1.x.x"
  }
}
```

### 2. Handle Missing Features Gracefully

```javascript
// Check for feature availability
if (context.hasFeature('parallel-execution')) {
  // Use parallel execution
} else {
  // Fall back to sequential
}
```

### 3. Validate API Version

```javascript
const requiredApiVersion = 1;
if (context.apiVersion !== requiredApiVersion) {
  throw new Error(`Plugin requires API v${requiredApiVersion}`);
}
```

### 4. Test Against Multiple Versions

```yaml
# .github/workflows/test-plugin.yml
strategy:
  matrix:
    claude-workflow-version: ['1.0.0', '1.5.0', '1.x']
```

## Compatibility Issues and Solutions

### Issue: Configuration not recognized

**Symptom**: ⚠️ Unknown configuration option

**Cause**: Using newer config in older version

**Solution**:
```bash
# Check version compatibility
/maintenance/check-version --config .claude-settings.json

# Migrate config if needed
/maintenance/migrate --component config --target-version 1.5.0
```

### Issue: Command not found

**Symptom**: ❌ Command not found

**Cause**: Using newer command in older version

**Solution**:
```bash
# Check command availability
/maintenance/check-version --command /workflow/plan

# Use older syntax if not available
/workflow/create-plan  # Instead of /workflow/plan create
```

### Issue: Checkpoint won't resume

**Symptom**: ❌ Incompatible checkpoint format

**Cause**: Checkpoint created in newer version

**Solution**:
```bash
# Convert checkpoint to compatible format
/maintenance/checkpoint convert \
  --input new-checkpoint.md \
  --output old-checkpoint.md \
  --format v1

# Or upgrade to newer version
git checkout v1.5.0
```

### Issue: Plugin fails to load

**Symptom**: ❌ Plugin API version mismatch

**Cause**: Plugin built for different API version

**Solution**:
```bash
# Check plugin compatibility
/plugins/check-compatibility my-plugin

# Update plugin if available
/plugins/update my-plugin

# Or disable incompatible plugin
/plugins/disable my-plugin
```

## Versioning and Compatibility

See also:
- [VERSIONING.md](./VERSIONING.md) - Complete versioning strategy
- [DEPRECATION_POLICY.md](./DEPRECATION_POLICY.md) - Deprecation process
- [Migration Guides](./migrations/) - Version-specific migration guides

## Testing Your Compatibility

### Compatibility Test Suite

Run compatibility tests before deploying:

```bash
# Run all compatibility tests
./tests/compatibility/run-all.sh

# Test specific component
./tests/compatibility/config-compatibility.sh
./tests/compatibility/command-compatibility.sh
./tests/compatibility/plugin-api-compatibility.sh
```

### Custom Compatibility Tests

Create custom tests for your setup:

```bash
#!/bin/bash
# tests/custom-compatibility.sh

# Test your specific configuration
/workflow/init test-project
/workflow/create-plan "Test feature"
/workflow/checkpoint create "Test checkpoint"
/workflow/resume-work @docs/sessions/latest.md

echo "✅ Compatibility test passed"
```

## Reporting Compatibility Issues

Found a compatibility issue?

1. **Check Known Issues**
   - [GitHub Issues](https://github.com/anthropics/claude-workflow-pro/issues)
   - [Compatibility label](https://github.com/anthropics/claude-workflow-pro/issues?q=label:compatibility)

2. **Report New Issue**
   ```markdown
   **Title**: Compatibility issue: [Brief description]

   **Environment**:
   - Version: 1.5.0
   - Previous version: 1.3.0
   - OS: macOS 14.0

   **Issue**:
   [Describe the compatibility problem]

   **Expected**:
   [What should work based on compatibility promise]

   **Actual**:
   [What actually happens]

   **Steps to Reproduce**:
   1. [First step]
   2. [Second step]
   ```

3. **Include Test Case**
   - Minimal reproduction
   - Configuration files
   - Error messages

## Version History

| Version | Date       | Changes |
|---------|------------|---------|
| 1.0.0   | 2025-11-16 | Initial compatibility guide |

---

**Compatibility Commitment**: We take backward compatibility seriously. Report issues early and we'll address them.

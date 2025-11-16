# Check for Deprecations

**Command**: `/maintenance/check-deprecations`
**Purpose**: Identify deprecated features in use
**Category**: Maintenance & Updates

## Overview

Scans your configuration, workflows, and custom code for deprecated features that will be removed in future versions. Helps you proactively update before breaking changes occur.

## Usage

```bash
# Check for all deprecations
/maintenance/check-deprecations

# Check for specific version
/maintenance/check-deprecations --version 2.0.0

# Check specific component
/maintenance/check-deprecations --component commands

# Output as JSON
/maintenance/check-deprecations --format json

# Include future deprecations
/maintenance/check-deprecations --include-future
```

## What It Checks

### 1. Commands

Scans for deprecated command usage:

```bash
# Deprecated commands in:
- Workflow files
- Custom scripts
- Documentation
- Configuration (command hooks)
```

### 2. Configuration Options

Checks for deprecated settings:

```bash
# Settings files checked:
- ~/.config/claude-code/settings.json
- .claude-settings.json
- Environment variables
```

### 3. Agents

Identifies deprecated agent references:

```bash
# Agent usage checked in:
- Workflow configurations
- Custom commands
- Scripts
```

### 4. Templates

Finds deprecated template syntax or features:

```bash
# Template files checked:
- Custom templates
- Workflow files
- Project configurations
```

### 5. Plugin APIs

Detects deprecated plugin API usage:

```bash
# Plugin files checked:
- Custom plugins
- Plugin configurations
- Plugin dependencies
```

## Output Format

### Standard Output

```
🔍 Deprecation Check
Version: 1.5.0
Date: 2025-11-16

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 Commands
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  Found 3 deprecated commands:

1. /workflow/create-plan
   📄 Used in: workflow.sh:12, README.md:45
   ⏱️  Deprecated: v1.5.0
   ❌ Removal: v2.0.0
   ✅ Replacement: /workflow/plan create
   📖 Guide: docs/migrations/v2.0.0.md#command-changes

2. /workflow/validate-plan
   📄 Used in: workflow.sh:15
   ⏱️  Deprecated: v1.5.0
   ❌ Removal: v2.0.0
   ✅ Replacement: /workflow/plan validate

3. /github/auto-review
   📄 Used in: .github/workflows/ci.yml:23
   ⏱️  Deprecated: v1.5.0
   ❌ Removal: v2.0.0
   ✅ Replacement: /github/review auto

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚙️  Configuration
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  Found 2 deprecated options:

1. workflow.checkpointDir
   📄 File: ~/.config/claude-code/settings.json:12
   ⏱️  Deprecated: v1.5.0
   ❌ Removal: v2.0.0
   ✅ Replacement: workflow.checkpoint.directory
   🔧 Auto-fix: /maintenance/migrate --component config

2. workflow.maxSteps
   📄 File: .claude-settings.json:8
   ⏱️  Deprecated: v1.5.0
   ❌ Removal: v2.0.0
   ✅ Replacement: workflow.execution.maxSteps
   🔧 Auto-fix: /maintenance/migrate --component config

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Agents
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ No deprecated agents in use

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 Templates
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ No deprecated template features in use

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔌 Plugins
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  Found 1 plugin with deprecated API:

1. test-generator v1.0.0
   ⚠️  Using Plugin API v1 (deprecated)
   ❌ API v1 removed: v2.0.0
   ✅ Update available: v2.0.0 (uses API v2)
   🔧 Update: /plugins/update test-generator

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Deprecations: 6
├─ Commands: 3
├─ Configuration: 2
├─ Agents: 0
├─ Templates: 0
└─ Plugins: 1

⚠️  All deprecated features will be removed in v2.0.0
📅 Estimated removal: Q4 2026

💡 Recommendations:
1. Update command usage in scripts and docs
2. Migrate configuration files
3. Update plugins to latest versions
4. Review migration guide: docs/migrations/v2.0.0.md

🔧 Quick Fix:
Run migration tool to automatically fix most issues:
  /maintenance/migrate --version 2.0.0 --dry-run

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### JSON Output

```json
{
  "version": "1.5.0",
  "checkDate": "2025-11-16T14:30:00Z",
  "deprecations": {
    "commands": [
      {
        "command": "/workflow/create-plan",
        "deprecatedIn": "1.5.0",
        "removedIn": "2.0.0",
        "replacement": "/workflow/plan create",
        "usages": [
          {
            "file": "workflow.sh",
            "line": 12,
            "context": "/workflow/create-plan \"Feature\""
          },
          {
            "file": "README.md",
            "line": 45,
            "context": "Use `/workflow/create-plan` to start"
          }
        ],
        "migrationGuide": "docs/migrations/v2.0.0.md#command-changes"
      }
    ],
    "configuration": [
      {
        "option": "workflow.checkpointDir",
        "deprecatedIn": "1.5.0",
        "removedIn": "2.0.0",
        "replacement": "workflow.checkpoint.directory",
        "file": "~/.config/claude-code/settings.json",
        "line": 12,
        "autoFix": true,
        "fixCommand": "/maintenance/migrate --component config"
      }
    ],
    "agents": [],
    "templates": [],
    "plugins": [
      {
        "name": "test-generator",
        "version": "1.0.0",
        "issue": "Using Plugin API v1 (deprecated)",
        "deprecatedIn": "1.5.0",
        "removedIn": "2.0.0",
        "updateAvailable": "2.0.0",
        "fixCommand": "/plugins/update test-generator"
      }
    ]
  },
  "summary": {
    "total": 6,
    "byCategory": {
      "commands": 3,
      "configuration": 2,
      "agents": 0,
      "templates": 0,
      "plugins": 1
    },
    "removalVersion": "2.0.0",
    "estimatedRemoval": "2026-Q4"
  },
  "recommendations": [
    "Update command usage in scripts and docs",
    "Migrate configuration files",
    "Update plugins to latest versions",
    "Review migration guide: docs/migrations/v2.0.0.md"
  ]
}
```

## Check Scope

### Current Version Deprecations

Check deprecations affecting current version:

```bash
/maintenance/check-deprecations

# Shows deprecations that will be removed in next MAJOR version
```

### Specific Version Deprecations

Check deprecations for target version:

```bash
/maintenance/check-deprecations --version 2.0.0

# Shows all deprecations removed in v2.0.0
```

### Future Deprecations

Include planned future deprecations:

```bash
/maintenance/check-deprecations --include-future

# Shows deprecations for v2.0.0, v3.0.0, etc.
```

### Component-Specific Check

Check specific component only:

```bash
# Check commands only
/maintenance/check-deprecations --component commands

# Check configuration only
/maintenance/check-deprecations --component configuration

# Check plugins only
/maintenance/check-deprecations --component plugins
```

## Scan Locations

### Files Scanned

The tool automatically scans:

```
Configuration Files:
├─ ~/.config/claude-code/settings.json
├─ .claude-settings.json
└─ .env

Workflow Files:
├─ *.sh (shell scripts)
├─ *.yml, *.yaml (CI/CD configs)
└─ docs/plans/*.md

Documentation:
├─ README.md
├─ docs/**/*.md
└─ USAGE.md

Custom Code:
├─ commands/**/*.md
├─ agents/**/*.md
└─ templates/**/*.md

Plugins:
└─ plugins/**/*
```

### Custom Scan Paths

Add custom paths to scan:

```bash
# Scan specific directory
/maintenance/check-deprecations --scan-path ./custom-scripts

# Scan specific file
/maintenance/check-deprecations --scan-path ./deploy.sh

# Multiple paths
/maintenance/check-deprecations --scan-path ./scripts --scan-path ./docs
```

## Deprecation Timeline

### Understanding Timeline

```
v1.5.0 (Current)
  ↓
  │ Feature deprecated
  │ Warnings shown
  │ Replacement available
  │
v1.6.0, v1.7.0, etc.
  ↓
  │ Feature still works
  │ Warnings continue
  │ Migration guide available
  │
v2.0.0 (Future)
  ↓
  │ Feature REMOVED
  │ Must use replacement
  │ Migration required
```

### Deprecation Categories

#### Immediate Attention (< 3 months)

```
⚠️  HIGH PRIORITY
Deprecated in: v1.5.0
Removed in: v1.6.0 (next minor - 3 months)
Action: Update immediately
```

#### Standard Deprecation (6-12 months)

```
⚠️  MEDIUM PRIORITY
Deprecated in: v1.5.0
Removed in: v2.0.0 (next major - 12 months)
Action: Plan migration
```

#### Long-term Deprecation (> 12 months)

```
ℹ️  LOW PRIORITY
Deprecated in: v1.5.0
Removed in: v3.0.0 (future major - 24+ months)
Action: Monitor and plan
```

## Auto-fix Deprecations

Some deprecations can be automatically fixed:

```bash
# Preview auto-fixes
/maintenance/check-deprecations --auto-fix --dry-run

# Apply auto-fixes
/maintenance/check-deprecations --auto-fix

# Output:
# 🔧 Auto-fixing Deprecations
#
# [1/3] Updating configuration...
#   ✅ workflow.checkpointDir → workflow.checkpoint.directory
#   ✅ workflow.maxSteps → workflow.execution.maxSteps
#
# [2/3] Creating command aliases...
#   ✅ /workflow/create-plan → /workflow/plan create
#   (Alias will work until v2.0.0)
#
# [3/3] Updating plugins...
#   ✅ test-generator v1.0.0 → v2.0.0
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Auto-fix Complete! ✅
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Fixed: 6/6 deprecations
# Manual updates needed: 0
#
# Remaining Tasks:
#   • Update script files (workflow.sh, etc.)
#   • Update documentation references
#   • Test updated configuration
```

## Integration with CI/CD

### GitHub Actions

```yaml
# .github/workflows/check-deprecations.yml
name: Check Deprecations

on:
  pull_request:
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Monday

jobs:
  deprecations:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check for deprecated features
        run: |
          /maintenance/check-deprecations --format json --output deprecations.json

      - name: Comment on PR
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const data = JSON.parse(fs.readFileSync('deprecations.json'));

            if (data.summary.total > 0) {
              await github.rest.issues.createComment({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                body: `⚠️ Found ${data.summary.total} deprecated features. See migration guide.`
              });
            }

      - name: Upload report
        uses: actions/upload-artifact@v3
        with:
          name: deprecation-report
          path: deprecations.json
```

### Pre-commit Hook

```bash
# .git/hooks/pre-commit
#!/bin/bash

# Check for deprecations before commit
/maintenance/check-deprecations --quiet

if [ $? -gt 0 ]; then
  echo "⚠️  Warning: Deprecated features detected"
  echo "Run '/maintenance/check-deprecations' for details"
  echo ""
  read -p "Continue anyway? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi
```

## Configuration

### Deprecation Check Settings

```json
{
  "maintenance": {
    "deprecationCheck": {
      "enabled": true,
      "scanPaths": [
        "./scripts",
        "./docs",
        "./.github"
      ],
      "ignorePaths": [
        "./node_modules",
        "./vendor",
        "./.git"
      ],
      "checkOnStartup": false,
      "warningLevel": "all"
    }
  }
}
```

### Warning Levels

```json
{
  "warningLevel": "all"         // Show all deprecations
  "warningLevel": "high"        // Only critical deprecations
  "warningLevel": "imminent"    // Only near-term removals
}
```

## Examples

### Example 1: Basic Check

```bash
$ /maintenance/check-deprecations

Found 3 deprecated features
See details above for migration guidance
```

### Example 2: Pre-migration Check

```bash
# Before migrating to v2.0.0
$ /maintenance/check-deprecations --version 2.0.0

Found 6 features that will break in v2.0.0
Run migration tool: /maintenance/migrate --version 2.0.0 --dry-run
```

### Example 3: CI Integration

```bash
# In CI pipeline
$ /maintenance/check-deprecations --format json --output report.json
$ cat report.json | jq '.summary.total'
6
```

### Example 4: Auto-fix

```bash
$ /maintenance/check-deprecations --auto-fix

Auto-fixed 4/6 deprecations
2 require manual updates (see details above)
```

## Related Commands

- `/maintenance/migrate` - Automated migration tool
- `/maintenance/check-updates` - Check for available updates
- `/maintenance/health` - System health check

## Exit Codes

```
0  - No deprecations found
1  - Deprecations found (informational)
2  - Critical deprecations (removal imminent)
10 - Check failed to run
```

## Version History

| Version | Changes |
|---------|---------|
| 1.0.0   | Initial deprecation checker |

---

**Stay Updated**: Run regular deprecation checks to avoid breaking changes.

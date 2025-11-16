# System Health Check

**Command**: `/maintenance/health`
**Purpose**: Comprehensive health check of Claude Workflow Pro installation
**Category**: Maintenance & Diagnostics

## Overview

Performs a comprehensive health check of your Claude Workflow Pro installation, including configuration validation, dependency checks, and system diagnostics.

## Usage

```bash
# Basic health check
/maintenance/health

# Detailed health check
/maintenance/health --verbose

# Check specific component
/maintenance/health --component workflows

# Output as JSON
/maintenance/health --format json

# Include performance metrics
/maintenance/health --include-metrics
```

## What It Checks

### 1. Installation Integrity

✅ **Command Files**
- All workflow commands present
- All GitHub commands present
- All team commands present
- All maintenance commands present

✅ **Agent Files**
- Core agents available
- Specialized agents available
- Agent metadata valid

✅ **Templates**
- All templates present
- Template syntax valid
- Template variables correct

✅ **Documentation**
- Core docs present
- Migration guides available
- Examples accessible

### 2. Configuration Validation

✅ **Global Settings**
- Settings file exists
- JSON syntax valid
- Schema compliance
- Required fields present

✅ **Project Settings**
- Project config exists (if applicable)
- Configuration valid
- No conflicts with global settings

✅ **Environment Variables**
- Required variables set
- Values valid

### 3. Dependency Status

✅ **Required Tools**
- Git installed and accessible
- Claude Code CLI available
- Version compatibility

✅ **Optional Tools**
- Node.js (for integrations)
- Python (for advanced features)
- Docker (for containerized workflows)

### 4. System Diagnostics

✅ **File System**
- Checkpoint directory writable
- Sufficient disk space
- File permissions correct

✅ **Performance**
- Memory usage healthy
- CPU availability
- I/O performance acceptable

✅ **Network** (optional)
- GitHub API accessible
- Integration endpoints reachable

## Output Format

### Standard Output

```
🔍 Claude Workflow Pro Health Check
Version: 1.0.0
Date: 2025-11-16 14:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📦 Installation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Commands         50/50 present
✅ Agents           20/20 available
✅ Templates        4/4 valid
✅ Documentation    Complete

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚙️  Configuration
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Global settings  Valid
✅ Project settings Valid
⚠️  Environment     1 optional variable missing

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔧 Dependencies
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Git              v2.39.0
✅ Claude Code      Latest
⚠️  Node.js         Not installed (optional)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🖥️  System
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Disk space       45 GB available
✅ Memory           8 GB available
✅ Permissions      Correct

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Overall Health: ✅ HEALTHY
Issues: 0 errors, 2 warnings

⚠️  Warnings:
  1. Optional environment variable NODE_PATH not set
  2. Optional dependency Node.js not installed

💡 Recommendations:
  • Install Node.js for enhanced GitHub integrations
  • Set NODE_PATH for custom plugin support

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Run '/maintenance/health --verbose' for detailed diagnostics
```

### JSON Output

```json
{
  "version": "1.0.0",
  "timestamp": "2025-11-16T14:30:00Z",
  "overallHealth": "healthy",
  "score": 95,
  "checks": {
    "installation": {
      "status": "pass",
      "commands": {
        "total": 50,
        "present": 50,
        "missing": []
      },
      "agents": {
        "total": 20,
        "available": 20,
        "missing": []
      },
      "templates": {
        "total": 4,
        "valid": 4,
        "invalid": []
      }
    },
    "configuration": {
      "status": "pass",
      "global": {
        "exists": true,
        "valid": true,
        "issues": []
      },
      "project": {
        "exists": true,
        "valid": true,
        "issues": []
      }
    },
    "dependencies": {
      "status": "warning",
      "required": [
        {"name": "git", "installed": true, "version": "2.39.0"},
        {"name": "claude-code", "installed": true, "version": "latest"}
      ],
      "optional": [
        {"name": "node", "installed": false, "impact": "low"}
      ]
    },
    "system": {
      "status": "pass",
      "diskSpace": {
        "available": "45 GB",
        "sufficient": true
      },
      "memory": {
        "available": "8 GB",
        "sufficient": true
      },
      "permissions": {
        "correct": true,
        "issues": []
      }
    }
  },
  "warnings": [
    "Optional dependency Node.js not installed",
    "Environment variable NODE_PATH not set"
  ],
  "errors": [],
  "recommendations": [
    "Install Node.js for enhanced GitHub integrations",
    "Set NODE_PATH for custom plugin support"
  ]
}
```

## Check Components

### Installation Check

```bash
/maintenance/health --component installation

# Checks:
# - Command files exist and are readable
# - Agent files present and valid
# - Templates available and properly formatted
# - Documentation complete
```

### Configuration Check

```bash
/maintenance/health --component configuration

# Checks:
# - Global settings valid JSON
# - Project settings valid (if present)
# - No schema violations
# - Required fields present
# - No deprecated options (with warnings)
```

### Dependencies Check

```bash
/maintenance/health --component dependencies

# Checks:
# - Git installed and version compatible
# - Claude Code CLI available
# - Optional tools status
# - Version compatibility
```

### System Check

```bash
/maintenance/health --component system

# Checks:
# - Disk space sufficient
# - Memory available
# - File permissions correct
# - Network connectivity (optional)
```

## Health Scores

### Score Calculation

```
Perfect Score: 100
- Installation issues: -5 per missing command/agent
- Configuration errors: -10 per error
- Missing required dependency: -20 per dependency
- System issues: -10 per issue
- Warnings: -1 per warning
```

### Health Levels

```
95-100: ✅ HEALTHY      (Excellent)
85-94:  ✅ GOOD         (Minor issues)
70-84:  ⚠️  FAIR        (Attention needed)
50-69:  ⚠️  DEGRADED    (Action required)
0-49:   ❌ UNHEALTHY    (Critical issues)
```

## Automated Fixes

Some issues can be auto-fixed:

```bash
# Attempt to fix detected issues
/maintenance/health --auto-fix

# Preview fixes without applying
/maintenance/health --auto-fix --dry-run

# Output:
# 🔧 Auto-fix available for 3 issues:
#
# 1. File permissions on checkpoint directory
#    Fix: chmod 755 docs/sessions
#
# 2. Missing .claude-settings.json
#    Fix: Copy from .claude-settings.example.json
#
# 3. Deprecated configuration option
#    Fix: Update to new option name
#
# Run with --auto-fix to apply these fixes
```

## Continuous Monitoring

### Scheduled Health Checks

```bash
# Check health on workflow start
# Add to .claude-settings.json:
{
  "workflow": {
    "preflightChecks": {
      "enabled": true,
      "runHealthCheck": true,
      "failOnError": false,
      "warnOnIssues": true
    }
  }
}
```

### CI/CD Integration

```yaml
# .github/workflows/health-check.yml
name: Health Check

on:
  schedule:
    - cron: '0 0 * * *'  # Daily

jobs:
  health:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run health check
        run: /maintenance/health --format json --output health.json
      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: health-report
          path: health.json
```

## Troubleshooting

### Issue: Health check fails to run

```bash
# Symptom
/maintenance/health
# Error: Command not found

# Solution
# Ensure you're in the project directory
cd /path/to/claude-workflow-pro

# Verify command exists
ls commands/maintenance/health.md
```

### Issue: Permission denied errors

```bash
# Symptom
❌ Permissions: Not writable

# Solution
# Fix checkpoint directory permissions
chmod 755 docs/sessions
chmod 644 docs/sessions/*.md
```

### Issue: Configuration validation fails

```bash
# Symptom
❌ Configuration: Invalid JSON

# Solution
# Validate JSON syntax
/maintenance/validate-config

# Fix common issues
/maintenance/validate-config --fix
```

## Agent Implementation

### Health Check Agent

This command uses the health-check agent:

```bash
# Agent: agents/health-check-agent.md
# Purpose: System diagnostics and validation
```

The agent:
1. Scans installation directory
2. Validates all configuration files
3. Checks system resources
4. Tests dependencies
5. Generates comprehensive report
6. Provides recommendations

## Best Practices

### 1. Run Regular Health Checks

```bash
# Before starting major work
/maintenance/health

# After configuration changes
/maintenance/health --component configuration

# After installing updates
/maintenance/health --verbose
```

### 2. Monitor Health Score

```bash
# Track health over time
/maintenance/health --format json >> logs/health-history.jsonl

# Alert on degradation
if [ $(health-score) -lt 85 ]; then
  echo "Health degraded, investigate"
fi
```

### 3. Fix Issues Promptly

```bash
# Auto-fix when possible
/maintenance/health --auto-fix

# Manual investigation for critical issues
/maintenance/health --verbose --component system
```

### 4. Include in CI/CD

```bash
# Fail builds on critical issues
/maintenance/health --fail-on-error

# Warn on minor issues
/maintenance/health --warn-on-issues
```

## Related Commands

- `/maintenance/validate-config` - Validate configuration only
- `/maintenance/check-updates` - Check for available updates
- `/maintenance/check-deprecations` - Check for deprecated features
- `/maintenance/verify` - Verify installation integrity

## Examples

### Basic Health Check

```bash
$ /maintenance/health

🔍 Claude Workflow Pro Health Check
Overall Health: ✅ HEALTHY (98/100)
0 errors, 1 warning
```

### Detailed Diagnostics

```bash
$ /maintenance/health --verbose

[Detailed output with all checks expanded]
```

### Component-Specific Check

```bash
$ /maintenance/health --component dependencies

🔧 Dependencies Check
✅ Git: v2.39.0
✅ Claude Code: Latest
⚠️  Node.js: Not installed (optional)
```

### JSON Export

```bash
$ /maintenance/health --format json --output health-report.json

Health report saved to: health-report.json
```

### Auto-fix Issues

```bash
$ /maintenance/health --auto-fix

🔧 Applying auto-fixes...
✅ Fixed checkpoint directory permissions
✅ Created missing .claude-settings.json
✅ Updated deprecated configuration option

Health improved: 87 → 98
```

## Exit Codes

```
0   - Healthy (score >= 95)
1   - Good (score 85-94)
2   - Fair (score 70-84)
3   - Degraded (score 50-69)
4   - Unhealthy (score < 50)
10  - Health check failed to run
```

## Configuration

### Health Check Settings

```json
{
  "maintenance": {
    "healthCheck": {
      "verbose": false,
      "includeOptional": true,
      "checkNetwork": false,
      "autoFix": false,
      "thresholds": {
        "healthy": 95,
        "good": 85,
        "fair": 70,
        "degraded": 50
      }
    }
  }
}
```

## Version History

| Version | Changes |
|---------|---------|
| 1.0.0   | Initial health check command |

---

**Need Help?** See [TROUBLESHOOTING.md](../../docs/TROUBLESHOOTING.md) or open an issue.

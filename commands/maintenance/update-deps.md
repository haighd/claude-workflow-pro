# Update Dependencies

**Command**: `/maintenance/update-deps`
**Purpose**: Update and manage project dependencies safely
**Category**: Maintenance & Security

## Overview

Safely update dependencies, check for security vulnerabilities, and ensure compatibility with Claude Workflow Pro.

## Usage

```bash
# Check for available updates
/maintenance/update-deps --check

# Update all dependencies
/maintenance/update-deps --all

# Update specific dependency
/maintenance/update-deps --package <name>

# Security updates only
/maintenance/update-deps --security-only

# Interactive mode
/maintenance/update-deps --interactive
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `--check` | Check for available updates |
| `--all` | Update all dependencies |
| `--security-only` | Security patches only |
| `--major` | Allow major version updates |
| `--dry-run` | Preview updates without applying |
| `--rollback` | Rollback last update |

---

**Security**: Run weekly to stay protected
**Compatibility**: Automated compatibility checks included

# Advanced Configuration

Advanced configuration options for customizing Claude Workflow Pro behavior.

## Configuration Files

### Hierarchy

Configuration is loaded in this order (later overrides earlier):

1. **Global defaults** - Built-in defaults
2. **Global config** - `~/.claude-settings.json`
3. **Project config** - `.claude-settings.json`
4. **Environment variables** - `CLAUDE_*`
5. **Command-line flags** - `--config=path`

### Project Configuration

`.claude-settings.json` in project root:

```json
{
  "workflow": {
    "auto-checkpoint-interval": 30,
    "checkpoint-naming": "descriptive",
    "plan-validation-required": true,
    "resume-on-restart": true
  },
  "github": {
    "auto-review": {
      "enabled": true,
      "on-pr-open": true,
      "strict-mode": false
    },
    "auto-triage": {
      "enabled": true,
      "apply-automatically": false
    },
    "auto-release": {
      "enabled": false,
      "version-detection": "auto"
    }
  },
  "team": {
    "pair-programming": {
      "enabled": true,
      "auto-sync-interval": 30,
      "role-switch-reminder": 25
    },
    "handoff": {
      "include-uncommitted": false,
      "expiration-days": 7
    }
  },
  "agents": {
    "default-agent": "full-stack-agent",
    "timeout": 300,
    "parallel-limit": 3
  },
  "metrics": {
    "enabled": true,
    "anonymous": true,
    "retention-days": 90,
    "reports": {
      "daily": false,
      "weekly": true,
      "monthly": true
    }
  },
  "plugins": {
    "enabled": true,
    "auto-update": false,
    "allow-custom": true
  },
  "integrations": {
    "slack": {
      "enabled": false,
      "webhook": "${SLACK_WEBHOOK}"
    },
    "jira": {
      "enabled": false,
      "url": "${JIRA_URL}",
      "token": "${JIRA_TOKEN}"
    }
  }
}
```

## Environment-Specific Configuration

### Development Environment

`.claude-settings.dev.json`:

```json
{
  "workflow": {
    "auto-checkpoint-interval": 15,
    "verbose-logging": true
  },
  "github": {
    "auto-review": {
      "strict-mode": false
    }
  },
  "metrics": {
    "enabled": false
  }
}
```

### Production Environment

`.claude-settings.prod.json`:

```json
{
  "workflow": {
    "plan-validation-required": true,
    "require-tests": true
  },
  "github": {
    "auto-review": {
      "strict-mode": true,
      "block-on-failure": true
    }
  },
  "metrics": {
    "enabled": true,
    "detailed-reporting": true
  }
}
```

**Usage:**
```bash
# Use specific environment config
claude --env=dev /workflow/create-plan
claude --env=prod /github/auto-review
```

## Team Configuration

### Team Presets

`.claude-team.json`:

```json
{
  "team": {
    "name": "Engineering Team",
    "size": 8,
    "timezone": "America/New_York",
    "working-hours": {
      "start": "09:00",
      "end": "17:00",
      "days": ["mon", "tue", "wed", "thu", "fri"]
    }
  },
  "workflows": {
    "code-review-required": true,
    "min-reviewers": 2,
    "require-tests": true,
    "require-docs": true
  },
  "github": {
    "auto-assign-reviewers": true,
    "reviewer-pool": [
      "@alice",
      "@bob",
      "@charlie",
      "@diana"
    ],
    "codeowners-enforcement": true
  },
  "pair-programming": {
    "encouraged": true,
    "schedule": "flexible",
    "track-metrics": true
  }
}
```

## Custom Agent Configuration

`.claude-agents.json`:

```json
{
  "agents": {
    "full-stack-agent": {
      "enabled": true,
      "priority": "high",
      "timeout": 600,
      "max-retries": 3
    },
    "security-agent": {
      "enabled": true,
      "run-on": ["pr-create", "pre-merge"],
      "fail-on": ["critical", "high"]
    },
    "performance-agent": {
      "enabled": true,
      "benchmarks": {
        "response-time": 200,
        "memory-usage": "100MB",
        "cpu-usage": "50%"
      }
    },
    "custom-agent": {
      "enabled": true,
      "file": "agents/custom-agent.md",
      "trigger": "manual"
    }
  }
}
```

## Workflow Customization

`.claude-workflow.json`:

```json
{
  "workflows": {
    "feature-development": {
      "template": "templates/feature-development.md",
      "required-steps": [
        "plan-validation",
        "implementation",
        "testing",
        "code-review",
        "documentation"
      ],
      "optional-steps": [
        "performance-testing",
        "security-audit"
      ],
      "checkpoints": {
        "frequency": "after-each-step",
        "naming": "descriptive"
      }
    },
    "bug-fix": {
      "template": "templates/bug-fix.md",
      "fast-track": {
        "enabled": true,
        "criteria": {
          "severity": ["critical", "high"],
          "impact": "production"
        }
      }
    },
    "refactoring": {
      "template": "templates/refactoring.md",
      "require-test-coverage": 90,
      "incremental-commits": true
    }
  }
}
```

## Integration Configuration

### Slack Integration

`.claude-integrations.json`:

```json
{
  "slack": {
    "enabled": true,
    "webhook": "${SLACK_WEBHOOK}",
    "channels": {
      "releases": "#releases",
      "security": "#security",
      "general": "#engineering"
    },
    "notifications": {
      "pr-created": "#code-reviews",
      "pr-merged": "#releases",
      "security-alert": "#security",
      "metrics-report": "#engineering"
    },
    "mention-on": {
      "critical-security": "@security-team",
      "production-issue": "@on-call"
    }
  },
  "jira": {
    "enabled": true,
    "url": "${JIRA_URL}",
    "token": "${JIRA_TOKEN}",
    "project": "ENG",
    "auto-link-issues": true,
    "auto-transition": {
      "on-pr-create": "In Review",
      "on-pr-merge": "Done"
    }
  }
}
```

## Performance Tuning

```json
{
  "performance": {
    "caching": {
      "enabled": true,
      "ttl": 3600,
      "max-size": "100MB"
    },
    "concurrency": {
      "max-parallel-agents": 3,
      "max-parallel-commands": 5
    },
    "rate-limiting": {
      "github-api": 5000,
      "local-commands": 100
    },
    "optimization": {
      "lazy-loading": true,
      "preload-common": true
    }
  }
}
```

## Security Configuration

```json
{
  "security": {
    "secret-scanning": {
      "enabled": true,
      "patterns": [
        "api[-_]?key",
        "secret[-_]?key",
        "password",
        "token",
        "private[-_]?key"
      ],
      "exclude-files": [
        "*.example.*",
        "*.sample.*",
        "test/**"
      ]
    },
    "dependency-scanning": {
      "enabled": true,
      "scanner": "npm-audit",
      "fail-on": ["critical", "high"],
      "auto-fix": false
    },
    "code-scanning": {
      "enabled": true,
      "tools": ["semgrep", "eslint-security"],
      "config": ".semgrep.yml"
    }
  }
}
```

## Advanced Features

### Custom Hooks

```json
{
  "hooks": {
    "pre-checkpoint": "scripts/pre-checkpoint.sh",
    "post-checkpoint": "scripts/post-checkpoint.sh",
    "pre-commit": "scripts/lint-and-test.sh",
    "post-merge": "scripts/notify-team.sh"
  }
}
```

### Template Variables

```json
{
  "templates": {
    "variables": {
      "COMPANY_NAME": "Acme Corp",
      "TEAM_NAME": "Engineering",
      "DEFAULT_BRANCH": "main",
      "TEST_COMMAND": "npm test",
      "BUILD_COMMAND": "npm run build"
    },
    "custom-templates": "templates/custom/"
  }
}
```

### Aliases

```json
{
  "aliases": {
    "/review": "/github/auto-review",
    "/triage": "/github/auto-triage",
    "/metrics": "/agents/metrics",
    "/test": "/development/test-agent",
    "/deploy": "/development/deploy"
  }
}
```

## Configuration Validation

### Schema Validation

Claude Workflow Pro validates configuration against JSON schema:

```bash
# Validate configuration
claude --validate-config

# Validate and show errors
claude --validate-config --verbose

# Generate schema
claude --generate-schema > claude-config-schema.json
```

### Configuration Testing

```bash
# Test configuration
claude --test-config

# Test specific feature
claude --test-config workflow.auto-checkpoint

# Dry run with config
claude --dry-run --config=.claude-settings.json /workflow/create-plan
```

## Best Practices

1. **Version Control** - Commit `.claude-settings.json` to git
2. **Environment Secrets** - Use environment variables for sensitive data
3. **Team Alignment** - Share team configuration across projects
4. **Documentation** - Document custom configurations
5. **Validation** - Validate config changes before committing
6. **Backup** - Keep backup of working configurations

## Troubleshooting

### Configuration Not Loading

```bash
# Check which config files are loaded
claude --show-config-files

# Show effective configuration
claude --show-config

# Debug configuration loading
claude --debug-config
```

### Conflicting Settings

```bash
# Show configuration sources
claude --config-source workflow.auto-checkpoint-interval

# Show all overrides
claude --config-overrides
```

## Migration

### Upgrading Configuration

When upgrading Claude Workflow Pro:

```bash
# Check for config changes
claude --check-config-upgrade

# Migrate configuration
claude --migrate-config

# Show migration steps
claude --show-migration
```

## Resources

- [Configuration Schema](./config-schema.json)
- [Example Configurations](../examples/configs/)
- [Environment Variables](./ENVIRONMENT_VARIABLES.md)
- [Team Setup Guide](./TEAM_SETUP.md)

---

**Version:** 1.0.0
**Last Updated:** 2025-11-16

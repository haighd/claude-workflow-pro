# Claude Code Hooks Guide

Guide to using Claude Code hooks with Claude Workflow Pro.

## Overview

Claude Code supports hooks that run at various points during execution:
- **UserPromptSubmit**: Before processing user input
- **Stop**: When stopping or completing a session
- **PreToolUse**: Before a tool is executed
- **PostToolUse**: After a tool completes

## Critical Path Rule

**ALL hook commands MUST use `"$CLAUDE_PROJECT_DIR"` when referencing project files.**

### ✅ Correct Examples

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/scripts/validate.js"
          }
        ]
      }
    ]
  }
}
```

### ❌ Incorrect Examples

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/scripts/validate.js"
          }
        ]
      }
    ]
  }
}
```

**Why this is wrong:**
- Depends on current working directory
- May fail if Claude Code changes directories
- Not portable across environments

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "node ~/.claude/scripts/validate.js"
          }
        ]
      }
    ]
  }
}
```

**Why this is wrong:**
- References home directory, not project directory
- Not project-specific
- Won't work in team environments

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "node $CLAUDE_PROJECT_DIR/.claude/scripts/validate.js"
          }
        ]
      }
    ]
  }
}
```

**Why this is wrong:**
- Missing quotes around path
- Will break if project path contains spaces
- Shell won't properly expand variable

## Hook Types

### UserPromptSubmit

Runs before Claude processes your input.

**Use cases:**
- Validate user input
- Load context or state
- Activate project-specific features
- Log user interactions

**Example:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "description": "Load project context",
        "hooks": [
          {
            "type": "command",
            "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/hooks/load-context.js"
          }
        ]
      }
    ]
  }
}
```

### Stop

Runs when the session is stopped or completed.

**Use cases:**
- Save session state
- Cleanup temporary files
- Validate work completion
- Generate session reports

**Example:**
```json
{
  "hooks": {
    "Stop": [
      {
        "description": "Save session state",
        "hooks": [
          {
            "type": "command",
            "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/hooks/save-state.js"
          }
        ]
      }
    ]
  }
}
```

### PreToolUse

Runs before a tool is executed. Can be filtered by tool name.

**Use cases:**
- Validate commands before execution
- Log tool usage
- Enforce coding standards
- Security checks

**Example:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "description": "Validate Bash commands",
        "hooks": [
          {
            "type": "command",
            "command": "bash \"$CLAUDE_PROJECT_DIR\"/.claude/scripts/validate-bash.sh"
          }
        ]
      },
      {
        "matcher": "Edit|Write",
        "description": "Check file permissions",
        "hooks": [
          {
            "type": "command",
            "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/scripts/check-permissions.js"
          }
        ]
      }
    ]
  }
}
```

### PostToolUse

Runs after a tool completes. Can be filtered by tool name.

**Use cases:**
- Format code after edits
- Run linters
- Update indexes
- Log results

**Example:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "description": "Format modified files",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/format-file.py"
          }
        ]
      }
    ]
  }
}
```

## Tool Matchers

Hooks can be filtered by tool name using regex patterns:

- `"Bash"` - Only Bash tool
- `"Edit|Write"` - Edit or Write tools
- `"Read"` - Only Read tool
- `".*"` - All tools
- `"Bash|Edit|Write"` - Multiple specific tools

## Hook Script Examples

### Bash Script

```bash
#!/bin/bash
# .claude/scripts/validate-bash.sh

# Access tool input via stdin
TOOL_INPUT=$(cat)

# Extract command from JSON
COMMAND=$(echo "$TOOL_INPUT" | jq -r '.tool_input.command')

# Validate command
if [[ "$COMMAND" == *"rm -rf /"* ]]; then
  echo "ERROR: Dangerous command blocked" >&2
  exit 1
fi

exit 0
```

**Usage:**
```json
{
  "command": "bash \"$CLAUDE_PROJECT_DIR\"/.claude/scripts/validate-bash.sh"
}
```

### Node.js Script

```javascript
// .claude/hooks/load-context.js
const fs = require('fs');
const path = require('path');

// Project directory is available via environment
const projectDir = process.env.CLAUDE_PROJECT_DIR;

// Read context file
const contextPath = path.join(projectDir, '.claude', 'context.json');
const context = JSON.parse(fs.readFileSync(contextPath, 'utf8'));

// Output context for Claude
console.log(JSON.stringify(context, null, 2));
```

**Usage:**
```json
{
  "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/hooks/load-context.js"
}
```

### Python Script

```python
#!/usr/bin/env python3
# .claude/hooks/format-file.py

import sys
import json
import os

# Read tool output from stdin
tool_output = json.load(sys.stdin)

# Get file path from tool output
file_path = tool_output.get('tool_input', {}).get('file_path')

if file_path and file_path.endswith('.md'):
    # Format markdown file
    with open(file_path, 'r') as f:
        content = f.read()

    # Simple formatting example
    formatted = content.replace('\t', '    ')

    with open(file_path, 'w') as f:
        f.write(formatted)
```

**Usage:**
```json
{
  "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/format-file.py"
}
```

## Environment Variables

Available in all hook scripts:

- `$CLAUDE_PROJECT_DIR` - Absolute path to project root
- Additional variables may be available depending on hook type

## Hook Input/Output

### PreToolUse Hooks

**Input (via stdin):**
```json
{
  "tool_name": "Bash",
  "tool_input": {
    "command": "ls -la",
    "description": "List files"
  },
  "timestamp": "2025-11-15T17:00:00Z"
}
```

**Output:**
- Exit code 0: Continue execution
- Exit code non-zero: Block execution

### PostToolUse Hooks

**Input (via stdin):**
```json
{
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "/path/to/file.js",
    "old_string": "...",
    "new_string": "..."
  },
  "tool_output": {
    "success": true
  },
  "timestamp": "2025-11-15T17:00:00Z"
}
```

## Best Practices

### 1. Always Quote Paths

```json
✅ "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/script.js"
❌ "command": "node $CLAUDE_PROJECT_DIR/.claude/script.js"
```

### 2. Make Scripts Executable

```bash
chmod +x .claude/scripts/*.sh
chmod +x .claude/hooks/*.py
```

### 3. Handle Errors Gracefully

```bash
#!/bin/bash
# Don't fail the entire session for non-critical hooks
do_something || true
```

### 4. Keep Hooks Fast

Hooks run synchronously and block execution:
- Aim for < 1 second execution time
- Avoid network calls
- Cache when possible

### 5. Log Appropriately

```bash
# Log to project directory, not global
echo "Hook executed" >> "$CLAUDE_PROJECT_DIR/.claude/hook-log.txt"
```

### 6. Test Hooks Independently

```bash
# Test your hook script
cat test-input.json | bash .claude/scripts/validate-bash.sh
echo $?  # Should be 0 for success
```

## Common Patterns

### Command Logging

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "jq -r '\"[\\(.timestamp)] \\(.tool_input.command)\"' >> \"$CLAUDE_PROJECT_DIR\"/.claude/command-log.txt"
        }
      ]
    }
  ]
}
```

### File Change Tracking

```json
{
  "PostToolUse": [
    {
      "matcher": "Edit|Write",
      "hooks": [
        {
          "type": "command",
          "command": "jq -r '.tool_input.file_path' >> \"$CLAUDE_PROJECT_DIR\"/.claude/modified-files.txt"
        }
      ]
    }
  ]
}
```

### Validation

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "bash \"$CLAUDE_PROJECT_DIR\"/.claude/scripts/validate-command.sh"
        }
      ]
    }
  ]
}
```

## Troubleshooting

### Hook Not Running

**Check:**
1. Is `.claude-settings.json` in project root?
2. Is JSON valid? Run `jq . .claude-settings.json`
3. Is script executable? Run `chmod +x .claude/scripts/script.sh`
4. Are paths using `$CLAUDE_PROJECT_DIR`?
5. Are paths quoted?

### Hook Fails

**Debug:**
```bash
# Test hook manually
echo '{"tool_name":"Bash","tool_input":{"command":"ls"}}' | \
  bash "$CLAUDE_PROJECT_DIR/.claude/scripts/your-hook.sh"
echo $?
```

**Check logs:**
```bash
# Check Claude Code logs
tail -f ~/.claude/logs/claude-code.log
```

### Path Issues

**Verify environment:**
```bash
# In your hook script
echo "Project dir: $CLAUDE_PROJECT_DIR" >&2
```

## Migration from Relative Paths

If you have existing hooks using relative paths:

**Before:**
```json
{
  "command": "node .claude/hooks/script.js"
}
```

**After:**
```json
{
  "command": "node \"$CLAUDE_PROJECT_DIR\"/.claude/hooks/script.js"
}
```

**Find and replace:**
```bash
# Find all relative .claude paths
grep -r '\.claude/' .claude-settings.json

# Update manually or use sed (carefully!)
```

## Example: Complete Settings File

See [`.claude-settings.example.json`](../.claude-settings.example.json) for a complete example with all hook types.

## Security Considerations

1. **Validate Input**: Always validate hook input
2. **Limit Permissions**: Run hooks with minimum required permissions
3. **No Secrets**: Don't put secrets in hook scripts
4. **Code Review**: Review all hook scripts before using
5. **Sandbox**: Consider sandboxing hook execution

## Resources

- Claude Code Documentation: https://docs.claude.com/claude-code
- Example Hooks: See `.claude/` directory in this project
- Hook Schema: Check `.claude-settings.example.json`

---

**Remember: Always use `"$CLAUDE_PROJECT_DIR"` for project file paths!**

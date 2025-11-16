---
description: Initialize workflow directory structure for a new or existing project
model: haiku
---

# Init Project

You are tasked with setting up the recommended directory structure for workflow commands in a project.

## When to Use

- Setting up a new project
- Adding Claude workflow to an existing project
- Re-initializing project structure after changes
- First-time setup in a repository

## Process

### Step 1: Verify Project Context

```bash
# Check if in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "⚠️  Not in a git repository. Initializing anyway..."
fi

# Get project root (or current directory if not git)
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$PROJECT_ROOT"
```

### Step 2: Detect Existing Structure

Check what already exists:

```bash
# Check for existing docs structure
EXISTING_DOCS=false
if [ -d "docs" ]; then
  EXISTING_DOCS=true
  echo "Found existing docs/ directory"
fi

# Check for existing config
EXISTING_CONFIG=false
if [ -f ".claude-plugin-config.json" ]; then
  EXISTING_CONFIG=true
  echo "Found existing .claude-plugin-config.json"
elif [ -f ".claude/config.json" ]; then
  EXISTING_CONFIG=true
  echo "Found existing .claude/config.json"
fi
```

### Step 3: Create Recommended Directory Structure

Create the standard directory structure (idempotent - safe to run multiple times):

```bash
# Core documentation directories
mkdir -p docs/research
mkdir -p docs/implementation-plans
mkdir -p docs/sessions
mkdir -p docs/prs

# Create .gitkeep files to preserve empty directories (if git repo)
if git rev-parse --git-dir > /dev/null 2>&1; then
  touch docs/research/.gitkeep
  touch docs/implementation-plans/.gitkeep
  touch docs/sessions/.gitkeep
  touch docs/prs/.gitkeep
fi
```

### Step 4: Create Optional Config File

If config doesn't exist, create a template at `.claude-plugin-config.json`:

```json
{
  "$schema": "https://json.schemastore.org/claude-plugin-config.json",
  "paths": {
    "research": "docs/research",
    "plans": "docs/implementation-plans",
    "sessions": "docs/sessions",
    "prs": "docs/prs",
    "root": "docs"
  },
  "workflow": {
    "baseBranch": "main",
    "branchPrefix": "feature/",
    "commitFormat": "conventional"
  },
  "features": {
    "tdd": {
      "enabled": true,
      "reminders": true
    },
    "github": {
      "enabled": true,
      "autoLinkIssues": true
    }
  },
  "hooks": {
    "enabled": true,
    "runtime": "auto"
  },
  "_comment": "This file is optional. Commands will auto-detect paths if this file doesn't exist."
}
```

**Note**: Only create if no config file exists. Don't overwrite existing config.

### Step 5: Detect Project Type and Provide Recommendations

```bash
# Check if GitHub project
if command -v gh > /dev/null 2>&1 && gh auth status > /dev/null 2>&1 && gh repo view > /dev/null 2>&1; then
  echo "✅ GitHub repository detected"
  GITHUB_DETECTED=true
else
  GITHUB_DETECTED=false
fi

# Check for package.json (Node.js project)
if [ -f "package.json" ]; then
  echo "✅ Node.js project detected"
fi

# Check for other project types
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
  echo "✅ Python project detected"
fi

if [ -f "go.mod" ]; then
  echo "✅ Go project detected"
fi

if [ -f "Cargo.toml" ]; then
  echo "✅ Rust project detected"
fi
```

### Step 6: Report What Was Created

Present a clear summary:

```markdown
## ✅ Project Structure Initialized

### Directories Created:
- `docs/research/` - For research documents and investigations
- `docs/implementation-plans/` - For implementation plans
- `docs/sessions/` - For session checkpoints and progress tracking
- `docs/prs/` - For PR descriptions and documentation

### Configuration:
- `.claude-plugin-config.json` - Project configuration (customize as needed)

### Next Steps:

1. **Customize config** (optional):
   - Edit `.claude-plugin-config.json` to match your project structure
   - Configure features you want to enable/disable
   - Set your preferred workflow settings

2. **Set up GitHub Issues** (if using GitHub):
   ```
   /setup-github-issues
   ```
   This creates issue templates, labels, and documentation.

3. **Start using workflow commands**:
   - `/create-plan` - Create implementation plans
   - `/implement-plan` - Execute plans with TDD
   - `/checkpoint` - Save progress before context clearing
   - `/resume-work` - Resume from saved checkpoints

4. **Learn about available commands**:
   - `/help` - See all available commands
   - Check plugin documentation for detailed guides

### Directory Structure:
```
project-root/
├── .claude-plugin-config.json (optional)
├── docs/
│   ├── research/
│   ├── implementation-plans/
│   ├── sessions/
│   └── prs/
└── ...
```

### Notes:
- All commands will automatically detect and use this structure
- Commands will create missing directories when needed
- You can customize paths via `.claude-plugin-config.json`
- Config file is optional - commands will use sensible defaults
```

## Error Handling

- **Permission errors**: Report clearly and suggest fix
- **Existing directories**: Skip creation (idempotent)
- **Non-git projects**: Still create structure, just skip .gitkeep files
- **Config file exists**: Don't overwrite, just report it exists

## Important Guidelines

1. **Idempotent**: Safe to run multiple times
2. **Non-destructive**: Never overwrites existing files
3. **Clear feedback**: Report what was created vs what already existed
4. **Optional config**: Config file is a convenience, not required
5. **Git-aware**: Creates .gitkeep files only in git repositories

## Example Output

```bash
✅ Project structure initialized!

Created directories:
  - docs/research/
  - docs/implementation-plans/
  - docs/sessions/
  - docs/prs/

Created configuration:
  - .claude-plugin-config.json (customize as needed)

✅ GitHub repository detected
✅ Node.js project detected

Next steps:
  1. Review and customize .claude-plugin-config.json if needed
  2. Run /setup-github-issues to set up GitHub workflow (optional)
  3. Start using workflow commands!

Note: All commands will automatically detect and use this structure.
```

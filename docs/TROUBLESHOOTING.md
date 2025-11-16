# Troubleshooting Guide

This guide helps you diagnose and fix common issues with Claude Workflow Pro. Issues are organized by category with step-by-step solutions.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Command Not Found](#command-not-found)
- [GitHub Integration Problems](#github-integration-problems)
- [Workflow Issues](#workflow-issues)
- [Agent Problems](#agent-problems)
- [Performance Issues](#performance-issues)
- [Git and Version Control](#git-and-version-control)
- [Configuration Problems](#configuration-problems)
- [Error Messages](#error-messages)
- [Getting Help](#getting-help)

---

## Installation Issues

### Plugin not loading in Claude Code

**Symptoms:**
- Commands don't appear
- `/workflow/init` shows "command not found"
- No plugin-related output

**Solutions:**

1. **Check installation location:**
   ```bash
   ls -la ~/.config/claude-code/plugins/claude-workflow-pro
   ```

   Should show the plugin files. If not:
   ```bash
   # Re-install
   git clone https://github.com/yourusername/claude-workflow-pro.git
   cp -r claude-workflow-pro ~/.config/claude-code/plugins/
   ```

2. **Verify file permissions:**
   ```bash
   chmod -R 755 ~/.config/claude-code/plugins/claude-workflow-pro
   ```

3. **Restart Claude Code:**
   - Exit completely
   - Start a fresh session
   - Try `/workflow/init` again

4. **Check for conflicts:**
   ```bash
   # Look for duplicate installations
   find ~/.config/claude-code -name "*workflow*" -type d
   ```

### Permission denied errors

**Symptoms:**
- "Permission denied" when running commands
- Cannot write to plugin directory

**Solutions:**

1. **Fix directory permissions:**
   ```bash
   sudo chown -R $USER:$USER ~/.config/claude-code
   chmod -R 755 ~/.config/claude-code/plugins
   ```

2. **Check file ownership:**
   ```bash
   ls -la ~/.config/claude-code/plugins/claude-workflow-pro
   ```

   All files should be owned by your user.

3. **Reinstall without sudo:**
   ```bash
   # Never use sudo to install
   # Remove and reinstall as your user
   rm -rf ~/.config/claude-code/plugins/claude-workflow-pro
   cp -r claude-workflow-pro ~/.config/claude-code/plugins/
   ```

### Dependencies missing

**Symptoms:**
- Test failures
- Commands fail with "command not found"
- GitHub features don't work

**Solutions:**

1. **Install required tools:**
   ```bash
   # macOS
   brew install git gh node

   # Linux (Ubuntu/Debian)
   sudo apt update
   sudo apt install git gh nodejs npm

   # Linux (Fedora)
   sudo dnf install git gh nodejs npm
   ```

2. **Verify installations:**
   ```bash
   git --version      # Should show 2.0+
   gh --version       # Should show GitHub CLI
   node --version     # Should show 16+
   npm --version      # Should show 8+
   ```

3. **Configure Git:**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

---

## Command Not Found

### Commands not recognized

**Symptoms:**
- `/workflow/create-plan` shows "Unknown command"
- Commands worked before but don't now

**Diagnostic steps:**

1. **Check if plugin is loaded:**
   ```bash
   # In Claude Code, type:
   /help

   # Look for workflow, github, development, research commands
   ```

2. **Verify command files exist:**
   ```bash
   ls ~/.config/claude-code/plugins/claude-workflow-pro/commands/
   ```

   Should show: `workflow/`, `github/`, `development/`, `research/`

3. **Check for typos:**
   ```bash
   # Correct:
   /workflow/create-plan

   # Incorrect:
   /workflow/createplan
   /workflow/create_plan
   ```

**Solutions:**

1. **Reinstall plugin:**
   ```bash
   cd ~/.config/claude-code/plugins
   rm -rf claude-workflow-pro
   git clone https://github.com/yourusername/claude-workflow-pro.git
   ```

2. **Check command file format:**
   ```bash
   # Command files should be .md files
   file ~/.config/claude-code/plugins/claude-workflow-pro/commands/workflow/create-plan.md

   # Should output: "ASCII text" or "UTF-8 Unicode text"
   ```

3. **Clear Claude Code cache:**
   ```bash
   rm -rf ~/.config/claude-code/cache
   # Restart Claude Code
   ```

---

## GitHub Integration Problems

### GitHub authentication failing

**Symptoms:**
- "Not authenticated" errors
- PR reviews fail
- Cannot create issues

**Solutions:**

1. **Login to GitHub CLI:**
   ```bash
   gh auth login
   ```

   Follow the prompts:
   - Choose GitHub.com
   - HTTPS or SSH (HTTPS recommended)
   - Authenticate via browser

2. **Verify authentication:**
   ```bash
   gh auth status
   ```

   Should show: "Logged in to github.com as [username]"

3. **Check token scopes:**
   ```bash
   gh auth refresh -s repo,workflow,write:discussion
   ```

   Ensures you have necessary permissions.

4. **Re-authenticate if needed:**
   ```bash
   gh auth logout
   gh auth login
   ```

### PR review fails

**Symptoms:**
- "PR not found"
- "Permission denied"
- "Invalid PR number"

**Solutions:**

1. **Verify PR exists:**
   ```bash
   gh pr view 123
   ```

   Should show PR details. If not, check the PR number.

2. **Check repository access:**
   ```bash
   gh repo view
   ```

   Should show current repository info.

3. **Ensure you're in a git repository:**
   ```bash
   git status
   ```

   If not in a repo:
   ```bash
   git init
   git remote add origin https://github.com/user/repo.git
   ```

4. **Verify remote is correct:**
   ```bash
   git remote -v
   ```

   Should point to the correct GitHub repository.

### Cannot create PRs

**Symptoms:**
- "No commits to create PR"
- "Branch not found"
- "Already exists"

**Solutions:**

1. **Ensure you have commits:**
   ```bash
   git log
   ```

   Should show at least one commit.

2. **Check current branch:**
   ```bash
   git branch
   ```

   Should not be on main/master.

3. **Create a feature branch:**
   ```bash
   git checkout -b feature/my-feature
   git add .
   git commit -m "Add feature"
   ```

4. **Push to remote:**
   ```bash
   git push -u origin feature/my-feature
   ```

5. **Then create PR:**
   ```bash
   /github/create-pr "My feature description"
   ```

---

## Workflow Issues

### Plans fail validation

**Symptoms:**
- "Plan is too vague"
- "Missing required information"
- "Invalid plan format"

**Solutions:**

1. **Add more detail to plan:**
   ```bash
   # Edit the plan file
   vim docs/plans/your-plan.md
   ```

   Ensure it includes:
   - Specific files to modify
   - Clear steps
   - Expected outcomes
   - Technical details

2. **Check plan structure:**
   ```markdown
   # Plan Title

   ## Objective
   Clear goal statement

   ## Files to Modify
   - src/file1.ts - What changes
   - src/file2.ts - What changes

   ## Implementation Steps
   1. Step 1 with details
   2. Step 2 with details

   ## Testing
   How to verify

   ## Considerations
   Things to watch out for
   ```

3. **Use an agent to improve the plan:**
   ```bash
   /research/architecture "Review and improve this plan: [paste plan]"
   ```

### Implementation fails midway

**Symptoms:**
- Code partially created
- Errors during implementation
- Stuck in middle of workflow

**Solutions:**

1. **Check what was created:**
   ```bash
   git status
   git diff
   ```

2. **Review error messages:**
   - Read the full error output
   - Identify which step failed
   - Check file paths and syntax

3. **Create checkpoint of current state:**
   ```bash
   /workflow/checkpoint "partial-implementation-before-fix"
   ```

4. **Fix the issue manually if needed:**
   ```bash
   # Edit problematic files
   vim src/problematic-file.ts
   ```

5. **Continue or restart:**
   ```bash
   # Try continuing
   /workflow/implement-plan

   # Or start fresh with revised plan
   /workflow/create-plan "Revised approach"
   ```

### Cannot resume from checkpoint

**Symptoms:**
- "Checkpoint not found"
- "Cannot load checkpoint"
- "Invalid checkpoint format"

**Solutions:**

1. **Verify checkpoint file exists:**
   ```bash
   ls -la docs/sessions/
   ```

2. **Check file path:**
   ```bash
   # Correct:
   /workflow/resume-work @docs/sessions/2025-01-15-checkpoint.md

   # Also works:
   /workflow/resume-work @checkpoint-file.md
   ```

3. **Verify file format:**
   ```bash
   # Should be markdown with proper structure
   head -20 docs/sessions/checkpoint-file.md
   ```

4. **Try absolute path:**
   ```bash
   /workflow/resume-work @/full/path/to/checkpoint.md
   ```

### Checkpoints not being created

**Symptoms:**
- `/workflow/checkpoint` completes but no file appears
- Empty checkpoint files

**Solutions:**

1. **Check docs/sessions/ exists:**
   ```bash
   mkdir -p docs/sessions
   ```

2. **Verify write permissions:**
   ```bash
   ls -la docs/
   chmod 755 docs/sessions
   ```

3. **Use descriptive names:**
   ```bash
   # Good:
   /workflow/checkpoint "phase1-complete"

   # Avoid special characters:
   # Not: "phase#1@complete!"
   ```

---

## Agent Problems

### Agents timing out

**Symptoms:**
- "Request timed out"
- Agent stops responding
- Incomplete analysis

**Solutions:**

1. **Increase timeout in config:**
   ```json
   {
     "agentSettings": {
       "timeout": 600
     }
   }
   ```

2. **Scope the request:**
   ```bash
   # Too broad:
   /research/security "Check everything"

   # Better:
   /research/security "Review src/auth/*.ts for vulnerabilities"
   ```

3. **Break into smaller requests:**
   ```bash
   # Instead of analyzing entire codebase:
   /research/security "Review authentication system"
   /research/security "Review API endpoints"
   /research/security "Review data validation"
   ```

4. **Check network connection:**
   ```bash
   ping 8.8.8.8
   # Ensure internet connectivity
   ```

### Agent output unclear or not helpful

**Symptoms:**
- Vague recommendations
- Generic advice
- Doesn't address the issue

**Solutions:**

1. **Be more specific:**
   ```bash
   # Vague:
   /research/performance "Make it faster"

   # Specific:
   /research/performance "Optimize database queries in UserService.ts - current response time is 2s, target is <500ms"
   ```

2. **Provide context:**
   ```bash
   /research/architecture "Design caching layer for our Node.js API that handles 10k req/min, using Redis, need to cache user data and session info"
   ```

3. **Include code snippets:**
   ```bash
   /research/security "Review this auth function: [paste code] - concerned about SQL injection"
   ```

4. **Ask follow-up questions:**
   ```bash
   # After initial response:
   /research/security "Can you elaborate on the SQL injection risk you mentioned?"
   ```

### Wrong agent used

**Symptoms:**
- Agent doesn't understand the question
- Inappropriate analysis
- Missing domain expertise

**Solutions:**

1. **Use the right agent:**
   ```bash
   # For system design:
   /research/architecture

   # For security:
   /research/security

   # For slow code:
   /research/performance

   # For tests:
   /research/testing
   ```

2. **Check available agents:**
   ```bash
   /research/explore-agents
   ```

3. **Chain multiple agents:**
   ```bash
   # Design then review
   /research/architecture "Design system"
   # Review the design
   /research/security "Review above design for security"
   ```

---

## Performance Issues

### Commands running slowly

**Symptoms:**
- Long wait times
- Commands that used to be fast are now slow
- Timeout errors

**Diagnostic steps:**

1. **Check context usage:**
   ```bash
   # In Claude Code:
   /context
   ```

   If near 100%, you need to compact or restart.

2. **Check system resources:**
   ```bash
   # CPU and memory
   top
   # or
   htop
   ```

3. **Check network:**
   ```bash
   # Test API connectivity
   curl -I https://api.anthropic.com
   ```

**Solutions:**

1. **Restart Claude Code session:**
   - Save checkpoint first
   - Exit and restart
   - Resume from checkpoint

2. **Reduce scope:**
   ```bash
   # Analyze specific files instead of all
   /research/security "Review src/auth/login.ts"
   ```

3. **Clear old checkpoints:**
   ```bash
   # Archive old sessions
   mkdir -p docs/sessions/archive
   mv docs/sessions/old-*.md docs/sessions/archive/
   ```

### Large file operations slow

**Symptoms:**
- Reading/writing large files takes forever
- Memory issues
- Crashes

**Solutions:**

1. **Process files in chunks:**
   ```bash
   # Instead of entire file:
   head -100 large-file.ts > temp-chunk.ts
   # Analyze chunk
   ```

2. **Use specific line ranges:**
   ```bash
   # Read specific sections
   sed -n '100,200p' large-file.ts
   ```

3. **Exclude large files:**
   ```bash
   # Add to .gitignore
   echo "*.log" >> .gitignore
   echo "dist/" >> .gitignore
   ```

---

## Git and Version Control

### Changes not being committed

**Symptoms:**
- Files modified but not in git
- Commits don't include changes
- "Nothing to commit"

**Solutions:**

1. **Stage files:**
   ```bash
   git status
   git add .
   # or specific files:
   git add src/modified-file.ts
   ```

2. **Check .gitignore:**
   ```bash
   cat .gitignore
   # Ensure your files aren't ignored
   ```

3. **Verify file is tracked:**
   ```bash
   git ls-files | grep your-file.ts
   ```

4. **Force add if needed:**
   ```bash
   git add -f file.ts
   ```

### Merge conflicts

**Symptoms:**
- "Conflict" messages
- Cannot commit
- Files have `<<<<<<` markers

**Solutions:**

1. **Identify conflicts:**
   ```bash
   git status
   # Shows conflicting files
   ```

2. **Resolve conflicts manually:**
   ```bash
   # Edit files, remove markers:
   # <<<<<<< HEAD
   # =======
   # >>>>>>>

   vim conflicted-file.ts
   ```

3. **Mark as resolved:**
   ```bash
   git add conflicted-file.ts
   ```

4. **Complete merge:**
   ```bash
   git commit -m "Resolve merge conflicts"
   ```

5. **Use an agent for help:**
   ```bash
   /research/refactoring "Help resolve merge conflict in: [paste conflicting code]"
   ```

### Branch issues

**Symptoms:**
- "Branch already exists"
- "Cannot checkout"
- "Branch not found"

**Solutions:**

1. **List all branches:**
   ```bash
   git branch -a
   ```

2. **Switch to existing branch:**
   ```bash
   git checkout existing-branch
   ```

3. **Create new branch:**
   ```bash
   git checkout -b new-feature
   ```

4. **Delete old branch:**
   ```bash
   # Local
   git branch -d old-branch

   # Remote
   git push origin --delete old-branch
   ```

5. **Force checkout if needed:**
   ```bash
   git checkout -f branch-name
   # Warning: Loses uncommitted changes
   ```

---

## Configuration Problems

### Configuration not being loaded

**Symptoms:**
- Settings don't take effect
- Plugin uses defaults
- Custom agents not found

**Solutions:**

1. **Verify config file location:**
   ```bash
   # Global
   ls ~/.config/claude-code/plugins/claude-workflow-pro/.claude-plugin-config.json

   # Project-specific
   ls .claude-settings.json
   ```

2. **Check JSON syntax:**
   ```bash
   # Validate JSON
   cat .claude-plugin-config.json | jq .
   # Should output formatted JSON
   # If error: fix syntax
   ```

3. **Verify permissions:**
   ```bash
   chmod 644 .claude-plugin-config.json
   ```

4. **Use example as template:**
   ```bash
   cp .claude-plugin-config.example.json .claude-plugin-config.json
   ```

### Custom agents not loading

**Symptoms:**
- Custom agent not in list
- "Agent not found"
- Using default agents only

**Solutions:**

1. **Check agent file location:**
   ```bash
   ls ~/.config/claude-code/plugins/claude-workflow-pro/agents/
   ```

2. **Verify file naming:**
   ```bash
   # Should be: agent-name.md
   # Example: custom-agent.md
   ```

3. **Check agent file format:**
   ```bash
   # Should start with markdown header
   head agents/custom-agent.md
   # Should show: # Agent Name
   ```

4. **Create command file:**
   ```bash
   # agents/custom-agent.md (agent definition)
   # commands/research/custom.md (command to invoke it)
   ```

---

## Error Messages

### "Out of context" or "Token limit"

**Problem:** Conversation too long

**Solutions:**

1. **Create checkpoint and restart:**
   ```bash
   /workflow/checkpoint "before-restart"
   # Exit Claude Code
   # Start fresh session
   /workflow/resume-work @checkpoint-file.md
   ```

2. **Use more focused requests:**
   ```bash
   # Instead of analyzing everything
   # Analyze specific areas
   ```

3. **Clear unnecessary context:**
   - Start new sessions more frequently
   - Don't keep long histories

### "File not found"

**Problem:** Path incorrect or file doesn't exist

**Solutions:**

1. **Use absolute paths:**
   ```bash
   /full/path/to/file.md
   ```

2. **Check current directory:**
   ```bash
   pwd
   ls
   ```

3. **Create missing directories:**
   ```bash
   mkdir -p docs/plans docs/sessions
   ```

### "Permission denied"

**Problem:** Cannot read/write files

**Solutions:**

1. **Check permissions:**
   ```bash
   ls -la file.md
   ```

2. **Fix permissions:**
   ```bash
   chmod 644 file.md  # For files
   chmod 755 directory/  # For directories
   ```

3. **Check ownership:**
   ```bash
   chown $USER:$USER file.md
   ```

---

## Getting Help

### Before asking for help

**Gather information:**

1. **What were you trying to do?**
   - Exact command run
   - Expected result
   - What happened instead

2. **What's your environment?**
   ```bash
   # OS and version
   uname -a

   # Claude Code version
   claude --version

   # Plugin version
   cat ~/.config/claude-code/plugins/claude-workflow-pro/package.json

   # Git version
   git --version
   ```

3. **Error messages:**
   - Full error text
   - Stack traces
   - Logs

4. **Steps to reproduce:**
   - Minimal steps that cause the issue
   - Any workarounds found

### Where to get help

**GitHub Discussions (Q&A):**
- Questions about usage
- "How do I...?" questions
- Clarifications

**GitHub Issues:**
- Bugs
- Feature requests
- Technical problems

**Example help request:**

```markdown
**Problem:** Cannot create checkpoints

**Environment:**
- OS: macOS 14.1
- Claude Code: v1.2.3
- Plugin: v1.0.0
- Git: 2.39.0

**Steps to reproduce:**
1. Run `/workflow/init`
2. Run `/workflow/checkpoint "test"`
3. Get error: "Cannot write to docs/sessions"

**Error message:**
```
Error: EACCES: permission denied, open 'docs/sessions/checkpoint.md'
```

**What I've tried:**
- Created docs/sessions directory manually
- Checked permissions (755)
- Restarted Claude Code

**Expected:** Checkpoint file created
**Actual:** Permission denied error
```

### Emergency debugging

**Plugin completely broken:**

1. **Remove and reinstall:**
   ```bash
   rm -rf ~/.config/claude-code/plugins/claude-workflow-pro
   git clone https://github.com/yourusername/claude-workflow-pro.git
   cp -r claude-workflow-pro ~/.config/claude-code/plugins/
   ```

2. **Reset configuration:**
   ```bash
   rm ~/.config/claude-code/plugins/claude-workflow-pro/.claude-plugin-config.json
   cp .claude-plugin-config.example.json .claude-plugin-config.json
   ```

3. **Check for conflicts:**
   ```bash
   # Look for duplicate plugins
   ls ~/.config/claude-code/plugins/
   ```

4. **Fresh start:**
   ```bash
   # Backup first
   mv ~/.config/claude-code ~/.config/claude-code.backup
   # Reinstall Claude Code
   # Reinstall plugin
   ```

---

## Common Patterns and Solutions

### Quick Fixes Reference

| Problem | Quick Fix |
|---------|-----------|
| Command not found | Restart Claude Code |
| Permission denied | `chmod 755 directory/` |
| GitHub auth failed | `gh auth login` |
| Plan validation fails | Add more detail to plan |
| Agent timeout | Scope request smaller |
| Slow performance | Restart session |
| Cannot commit | `git add .` then commit |
| Checkpoint fails | `mkdir -p docs/sessions` |
| Config not loaded | Check JSON syntax |
| Out of context | Save checkpoint, restart |

### Preventive Measures

**To avoid issues:**

1. **Regular checkpoints:**
   - Save progress frequently
   - Use descriptive names
   - Don't lose work

2. **Keep sessions short:**
   - Restart periodically
   - Clear context
   - Maintain performance

3. **Scope requests:**
   - Be specific
   - One task at a time
   - Avoid "analyze everything"

4. **Maintain Git hygiene:**
   - Commit frequently
   - Use feature branches
   - Keep working directory clean

5. **Update regularly:**
   ```bash
   cd ~/.config/claude-code/plugins/claude-workflow-pro
   git pull origin main
   ```

---

**Still stuck?** Open an issue on GitHub with:
- Detailed description
- Environment info
- Steps to reproduce
- Error messages

We're here to help! 🚀

---

**Last updated:** 2025-01-15
**Version:** 1.0.0
**Maintained by:** Claude Workflow Pro Team

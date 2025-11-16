---
description: Set up a local review environment for a colleague's branch using git worktrees
model: haiku
---

# Local Review

You are tasked with setting up a local review environment for a colleague's branch. This involves creating a worktree, setting up dependencies, and optionally launching a new editor session.

## Process

When invoked with a parameter like `gh_username:branchName`:

1. **Parse the input**:
   - Extract GitHub username and branch name from the format `username:branchname`
   - If no parameter provided, ask for it in the format: `gh_username:branchName`

2. **Extract ticket information**:
   - Look for ticket numbers in the branch name (e.g., `eng-1696`, `ENG-1696`, `123`)
   - Use this to create a short worktree directory name
   - If no ticket found, use a sanitized version of the branch name

3. **Detect project information**:
   ```bash
   # Get repository name
   REPO_NAME=$(basename $(git rev-parse --show-toplevel))

   # Or use gh if available
   REPO_INFO=$(gh repo view --json name -q .name 2>/dev/null || basename $(git rev-parse --show-toplevel))
   ```

4. **Set up the remote and worktree**:
   - Check if the remote already exists using `git remote -v`
   - If not, add it: `git remote add USERNAME git@github.com:USERNAME/REPO_NAME`
   - Fetch from the remote: `git fetch USERNAME`
   - Create worktree: `git worktree add -b BRANCHNAME ~/wt/REPO_NAME/SHORT_NAME USERNAME/BRANCHNAME`

5. **Configure the worktree**:
   - Detect setup command based on project type:
     - Node.js: `npm install` or `yarn install`
     - Python: `pip install -r requirements.txt` or `poetry install`
     - Go: `go mod download`
     - Rust: `cargo build`
   - Run the detected setup command in the worktree directory

6. **Report completion**:
   ```bash
   ✅ Review environment ready!

   Location: ~/wt/REPO_NAME/SHORT_NAME
   Branch: USERNAME/BRANCHNAME

   Setup completed:
   - Worktree created
   - Dependencies installed

   To start reviewing:
   cd ~/wt/REPO_NAME/SHORT_NAME
   code .  # or your preferred editor
   ```

## Error Handling

### Common Issues and Solutions

**Issue: Worktree already exists**

```bash
# Error: fatal: '~/wt/repo/branch' already exists

# Solution 1: Remove existing worktree
git worktree remove ~/wt/REPO_NAME/SHORT_NAME

# Solution 2: If remove fails (has uncommitted changes)
git worktree remove --force ~/wt/REPO_NAME/SHORT_NAME

# Solution 3: Use different worktree path
# Ask user: "Worktree exists. Should I:
# 1. Remove existing worktree and create fresh one
# 2. Use existing worktree
# 3. Create worktree with different name (add -v2 suffix)"
```

**Issue: Remote already exists**

```bash
# Error: fatal: remote 'username' already exists

# Check if it points to correct repository
EXISTING_URL=$(git remote get-url username 2>/dev/null)

# If URL matches what we need: Use existing remote
# If URL differs:
# Ask user: "Remote 'username' exists but points to different repository.
# Current: $EXISTING_URL
# Needed: github.com:username/repo.git
# Should I update it? (yes/no)"

# Update remote:
git remote set-url username git@github.com:username/repo.git
```

**Issue: Cannot fetch remote branch**

```bash
# Error: fatal: couldn't find remote ref refs/heads/feature/branch

# Possible causes:
# 1. Branch name typo
# 2. Branch doesn't exist on remote
# 3. Permission issues

# Solutions:
# List available branches:
git ls-remote --heads username

# Ask user:
# "Branch 'feature/branch' not found on remote 'username'.
# Available branches:
# - main
# - develop
# - feature/other
# Which branch should I use?"
```

**Issue: Setup command fails**

```bash
# Error: npm install failed with exit code 1

# Report to user with full error:
# "Setup command failed: npm install
# Error: [error message]
#
# Worktree created at: ~/wt/repo/branch
# You can:
# 1. Manually fix the issue and run setup
# 2. Skip setup and review code without running it
# 3. Remove worktree: git worktree remove ~/wt/repo/branch"

# Don't fail the entire command - worktree is still usable
```

**Issue: Insufficient disk space**

```bash
# Check disk space before creating worktree
AVAILABLE=$(df -h . | awk 'NR==2 {print $4}')

# If worktree creation fails:
# Report: "Insufficient disk space. Available: $AVAILABLE
# Worktree creation requires cloning repository files.
# Free up space and try again."
```

**Issue: Invalid username/repo format**

```bash
# Expected format: username:branch or username/repo:branch

# If format is wrong:
# Report: "Invalid format. Expected:
# - username:branch (for current repo)
# - username/repo:branch (for different fork)
#
# Example: /local-review colleague:feature/add-api"
```

**Issue: Git worktree not available**

```bash
# Check git version
GIT_VERSION=$(git --version | grep -oE '[0-9]+\.[0-9]+')

# Worktrees require git 2.5+
if [[ $(echo "$GIT_VERSION < 2.5" | bc) -eq 1 ]]; then
  # Report: "Git worktrees require git 2.5 or higher.
  # Current version: $GIT_VERSION
  # Please upgrade git: brew upgrade git (macOS) or apt-get upgrade git (Linux)"
fi
```

**Issue: Branch has uncommitted changes**

```bash
# When removing worktree with uncommitted changes:
# Error: fatal: 'path' contains modified or untracked files

# Solutions:
# 1. Force remove (loses changes):
git worktree remove --force ~/wt/repo/branch

# 2. Stash changes first:
cd ~/wt/repo/branch
git stash
cd -
git worktree remove ~/wt/repo/branch

# Ask user which approach they prefer
```

### Verification Steps

After setting up worktree:

```bash
# Verify worktree was created
git worktree list | grep "SHORT_NAME"

# Verify branch is checked out
cd ~/wt/REPO/SHORT_NAME && git branch --show-current

# Verify dependencies installed (if setup command ran)
# Node.js:
test -d ~/wt/REPO/SHORT_NAME/node_modules && echo "Dependencies OK"

# Python:
test -f ~/wt/REPO/SHORT_NAME/venv/bin/activate && echo "Virtualenv OK"
```

## Troubleshooting

**Worktree not showing up in git worktree list:**
- Verify git command succeeded (check exit code)
- Check ~/.gitconfig for worktree settings
- Ensure .git directory is valid
- Try running manually: `git worktree list`

**Cannot cd into worktree directory:**
- Verify directory exists: `ls ~/wt/REPO/`
- Check path expansion: `echo ~/wt/REPO/BRANCH`
- Verify permissions: `ls -ld ~/wt/REPO/BRANCH`

**Setup command times out:**
- Set longer timeout for setup commands
- Run setup manually after worktree creation
- Skip setup and install dependencies later

**Multiple git remotes causing confusion:**
- List all remotes: `git remote -v`
- Remove unnecessary remotes: `git remote remove <name>`
- Use explicit remote names for clarity

## Example Usage

```
/local-review colleague_username:feature/add-new-api
```

This will:

- Add 'colleague_username' as a remote
- Create worktree at `~/wt/PROJECT_NAME/add-new-api` (or ticket number if found)
- Set up the environment with dependencies
- Report the location for opening in an editor

## Customization

Users can customize via config:

```json
{
  "localReview": {
    "worktreeLocation": "~/wt",
    "setupCommand": "npm install && npm run build",
    "autoLaunch": false
  }
}
```

Read from `.claude-plugin-config.json` or `.claude/config.json`:

```bash
if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
  WORKTREE_LOC=$(jq -r '.localReview.worktreeLocation // "~/wt"' .claude-plugin-config.json)
  SETUP_CMD=$(jq -r '.localReview.setupCommand // ""' .claude-plugin-config.json)
elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
  WORKTREE_LOC=$(jq -r '.localReview.worktreeLocation // "~/wt"' .claude/config.json)
  SETUP_CMD=$(jq -r '.localReview.setupCommand // ""' .claude/config.json)
else
  WORKTREE_LOC="~/wt"
  SETUP_CMD=""
fi
```

## Notes

- Worktrees share the same git repository, saving disk space
- Perfect for reviewing PRs without affecting your working branch
- Each worktree can have its own dependencies installed
- Clean up worktrees when done: `git worktree remove PATH`

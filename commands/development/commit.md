---
description: Create git commits for changes made during this session
model: sonnet
---

# Commit Changes

You are tasked with creating git commits for the changes made during this session.

## Process

1. **Check for Related GitHub Issue:**
   - Check if current branch name includes issue number (e.g., `feature/123-description`)
   - Check if there's a plan file being worked on that references an issue
   - Check recent conversation for issue mentions
   - If issue found, include "Closes #123" or "Fixes #123" in commit message body

2. **Think about what changed:**
   - Review the conversation history and understand what was accomplished
   - Run `git status` to see current changes
   - Run `git diff` to understand the modifications
   - Consider whether changes should be one commit or multiple logical commits

3. **Plan your commit(s):**
   - Identify which files belong together
   - Draft clear, descriptive commit messages
   - Use imperative mood in commit messages
   - Focus on why the changes were made, not just what
   - If issue number is known, format commit message:

     ```
     <type>: <subject>

     Closes #<issue-number>

     <detailed description>
     ```

4. **Present your plan to the user:**
   - List the files you plan to add for each commit
   - Show the commit message(s) you'll use (including issue references if applicable)
   - Ask: "I plan to create [N] commit(s) with these changes. Shall I proceed?"

5. **Execute upon confirmation:**
   - Use `git add` with specific files (never use `-A` or `.`)
   - Create commits with your planned messages
   - Show the result with `git log --oneline -n [number]`

## Commit Message Format

Follow conventional commit format if configured:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

## Important

- **NEVER add co-author information or Claude attribution**
- Commits should be authored solely by the user
- Do not include any "Generated with Claude" messages
- Do not add "Co-Authored-By" lines
- Write commit messages as if the user wrote them

## Remember

- You have the full context of what was done in this session
- Group related changes together
- Keep commits focused and atomic when possible
- The user trusts your judgment - they asked you to commit

## Best Practices

### Atomic Commits

**What is an Atomic Commit?**
A commit that contains changes for a single logical purpose. Each commit should:
- Build and pass tests independently
- Be easily understood in isolation
- Be safe to revert without breaking unrelated functionality

**When to split into multiple commits:**
- Feature implementation + test updates → 2 commits
- Database schema changes + application code → 2 commits
- Refactoring + bug fix → 2 commits
- Multiple unrelated bug fixes → separate commits

**When to keep as single commit:**
- Feature implementation that requires several files to work together
- Renaming a function across multiple files
- Adding a new component with its tests and styles

### Commit Message Quality

**Good commit messages:**
```
feat: add user authentication middleware

Implements JWT-based authentication for protected routes.
Includes token validation and refresh logic.

Closes #42
```

**Poor commit messages:**
```
update stuff
fix bug
WIP
changes
```

**Message Structure:**
1. **Subject line (50 chars or less):**
   - Use imperative mood ("add" not "added" or "adds")
   - Don't end with a period
   - Capitalize first word
   - Be specific but concise

2. **Body (wrap at 72 chars):**
   - Explain WHAT and WHY, not HOW (code shows how)
   - Include context that reviewers need
   - Reference related issues, tickets, or discussions

3. **Footer:**
   - Issue references (Closes #123, Fixes #456)
   - Breaking change notices
   - Co-authors (if pair programming)

### Multi-Commit Workflows

**Example: Feature Development**
```bash
# 1. Add core functionality
git add src/features/auth/
git commit -m "feat: implement JWT authentication service"

# 2. Add tests
git add tests/features/auth/
git commit -m "test: add authentication service tests"

# 3. Update documentation
git add docs/authentication.md
git commit -m "docs: document authentication setup"
```

**Example: Bug Fix with Test**
```bash
# 1. Add failing test
git add tests/bug-reproduction.test.js
git commit -m "test: add failing test for issue #123"

# 2. Fix the bug
git add src/buggy-file.js
git commit -m "fix: resolve null pointer in user lookup

Adds proper null checking before accessing user properties.

Fixes #123"
```

## Error Handling

### Common Issues and Solutions

**Issue: Merge conflicts**
```bash
# If git add fails due to conflicts
git status  # Show conflicted files
# Report to user: "Merge conflicts detected in [files]. Please resolve conflicts first."
```

**Issue: No changes to commit**
```bash
# Check if there are actually changes
if git diff --quiet && git diff --cached --quiet; then
  # Report: "No changes detected. Nothing to commit."
fi
```

**Issue: Large uncommitted changes**
```bash
# If there are >50 changed files, ask user:
# "There are [N] changed files. This seems large. Would you like me to:
# 1. Review changes first and create logical groupings
# 2. Commit everything as one commit
# 3. Let you review with 'git status' first"
```

**Issue: Unstaged changes mixed with staged changes**
```bash
# Check for mixed state
git diff --quiet  # Check unstaged
git diff --cached --quiet  # Check staged

# If both have changes:
# Ask: "You have both staged and unstaged changes. Should I:
# 1. Commit only staged changes
# 2. Include all changes
# 3. Review changes first"
```

### Pre-commit Checks

Before committing, verify:

```bash
# Check for common issues
git diff --check  # Check for whitespace errors
git status --porcelain  # Machine-readable status

# If project has pre-commit hooks, they'll run automatically
# If hooks fail, report the failure and ask for guidance
```

## Integration with Other Commands

### Workflow Integration

**After implementation:**
```
/implement-plan → Changes made → /commit → /validate-plan
```

**Before PR creation:**
```
/commit → git push → /describe-pr → Create PR
```

**With GitHub issues:**
```
/start-from-issue #123 → Work → /commit (includes "Fixes #123")
```

### Command Chaining

This command works well with:
- `/validate-plan` - Commit before validating implementation
- `/describe-pr` - Commit before generating PR description
- `/debug` - Commit working state before debugging
- `/checkpoint` - Commit before creating checkpoint

## Advanced Scenarios

### Amending Commits

**When appropriate:**
- Fixing typo in commit message
- Adding forgotten file to last commit
- Updating commit after pre-commit hook modifications

**Never amend if:**
- Commit has been pushed to shared branch
- Other developers have based work on this commit

### Interactive Staging

**For complex changes:**
```bash
# Stage parts of a file
git add -p file.js  # Interactive patch mode

# Stage specific hunks
# Useful when file has multiple unrelated changes
```

### Commit Message Templates

**Feature with issue reference:**
```
feat(<scope>): <brief description>

<detailed explanation of the feature>

Implements functionality described in #<issue-number>.

Closes #<issue-number>
```

**Bug fix with root cause:**
```
fix(<scope>): <brief description>

Root cause: <what was causing the bug>
Solution: <how this fixes it>

Fixes #<issue-number>
```

**Breaking change:**
```
feat!(<scope>): <breaking change description>

BREAKING CHANGE: <detailed explanation>

Migration guide:
- <step 1>
- <step 2>

Closes #<issue-number>
```

## Tips for Quality Commits

1. **Test before committing** - Ensure code works and tests pass
2. **Review your diff** - Always check `git diff` before committing
3. **One purpose per commit** - Each commit should do one thing well
4. **Write for future developers** - Including future you in 6 months
5. **Link to context** - Reference issues, PRs, or design docs
6. **Avoid mixing concerns** - Don't combine refactoring with features
7. **Keep history clean** - Use meaningful commits, not "WIP" or "fix fix fix"

## Troubleshooting

**"Nothing added to commit"**
- Run `git status` to see if files are tracked
- Untracked files need explicit `git add`
- Check if changes are in gitignored directories

**"Commit message too long"**
- Subject should be ≤50 chars
- Body lines should be ≤72 chars
- Use commit body for detailed explanations

**"Pre-commit hook failed"**
- Review hook output for specific errors
- Fix issues (usually linting or formatting)
- Re-run commit after fixes
- Never use `--no-verify` without user approval

## Related Commands

- `/validate-plan` - Validate before committing
- `/describe-pr` - Create PR after committing
- `/debug` - Debug issues before committing
- `/local-review` - Review changes in worktree before committing

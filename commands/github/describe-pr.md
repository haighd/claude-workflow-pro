---
description: Generate a comprehensive pull request description following the repository's template
model: sonnet
---

# Generate PR Description

You are tasked with generating a comprehensive pull request description following the repository's standard template.

## Steps to follow:

1. **Read the PR description template (if available):**
   - Check if a template exists at `.github/pull_request_template.md`
   - If a template exists, read it carefully to understand all sections and requirements
   - If no template exists, use a standard PR description format (see below)

2. **Identify the PR to describe:**
   - Check if the current branch has an associated PR: `gh pr view --json url,number,title,state 2>/dev/null`
   - If no PR exists for the current branch, or if on main/master, list open PRs: `gh pr list --limit 10 --json number,title,headRefName,author`
   - Ask the user which PR they want to describe

3. **Check for existing description:**
   - Check if a description file already exists at `docs/prs/{number}_description.md`
   - If it exists, read it and inform the user you'll be updating it
   - Consider what has changed since the last description was written

4. **Gather comprehensive PR information:**
   - Get the full PR diff: `gh pr diff {number}`
   - If you get an error about no default remote repository, instruct the user to run `gh repo set-default` and select the appropriate repository
   - Get commit history: `gh pr view {number} --json commits`
   - Review the base branch: `gh pr view {number} --json baseRefName`
   - Get PR metadata: `gh pr view {number} --json url,title,number,state`

5. **Analyze the changes thoroughly:** (ultrathink about the code changes, their architectural implications, and potential impacts)
   - Read through the entire diff carefully
   - For context, read any files that are referenced but not shown in the diff
   - Understand the purpose and impact of each change
   - Identify user-facing changes vs internal implementation details
   - Look for breaking changes or migration requirements

6. **Handle verification requirements:**
   - Look for any checklist items in the "How to verify it" section of the template
   - For each verification step:
     - If it's a command you can run (like `{{TEST_COMMAND}}`, linting, build, etc.), run it
     - If it passes, mark the checkbox as checked: `- [x]`
     - If it fails, keep it unchecked and note what failed: `- [ ]` with explanation
     - If it requires manual testing (UI interactions, external services), leave unchecked and note for user
   - Document any verification steps you couldn't complete

7. **Generate the description:**
   - Fill out each section from the template thoroughly:
     - Answer each question/section based on your analysis
     - Be specific about problems solved and changes made
     - Focus on user impact where relevant
     - Include technical details in appropriate sections
     - Write a concise changelog entry
   - Ensure all checklist items are addressed (checked or explained)

   **Standard PR Description Format** (if no template exists):

   ```markdown
   ## What does this PR do?

   [Brief description of the changes]

   ## Why are we doing this?

   [Context and motivation]

   ## What changed?

   - [Key change 1]
   - [Key change 2]
   - [Key change 3]

   ## Breaking Changes

   [List any breaking changes, or "None"]

   ## How to verify it

   - [ ] Run tests: `{{TEST_COMMAND}}`
   - [ ] Run linter: `npm run lint` (or equivalent)
   - [ ] Build succeeds: `npm run build` (or equivalent)
   - [ ] Manual testing: [specific steps]

   ## Screenshots (if applicable)

   [Add screenshots for UI changes]

   ## Related Issues/PRs

   - Closes #[issue-number]
   - Related to #[issue-number]

   ## Checklist

   - [ ] Tests added/updated
   - [ ] Documentation updated
   - [ ] Changelog entry added (if needed)
   ```

8. **Save the description:**
   - Write the completed description to `docs/prs/{number}_description.md`
   - Show the user the generated description

9. **Update the PR:**
   - Update the PR description directly: `gh pr edit {number} --body-file docs/prs/{number}_description.md`
   - Confirm the update was successful
   - If any verification steps remain unchecked, remind the user to complete them before merging

## Important notes:

- This command works across different repositories - always read the local template
- Be thorough but concise - descriptions should be scannable
- Focus on the "why" as much as the "what"
- Include any breaking changes or migration notes prominently
- If the PR touches multiple components, organize the description accordingly
- Always attempt to run verification commands when possible
- Clearly communicate which verification steps need manual testing

## Template Detection and Handling

### Locating PR Templates

Check multiple locations in order:
1. `.github/pull_request_template.md` (most common)
2. `.github/PULL_REQUEST_TEMPLATE.md` (uppercase variant)
3. `.github/PULL_REQUEST_TEMPLATE/` directory (multiple templates)
4. `docs/pull_request_template.md` (alternative location)

### Template Parsing

**Common template patterns:**

**Markdown comments (instructions):**
```markdown
<!-- Please describe the purpose of this PR -->
## What does this PR do?
```
→ Preserve comments as guidance, fill in actual content below

**Placeholder text:**
```markdown
## Description
[Describe your changes here]
```
→ Replace placeholder with actual description

**Checklist items:**
```markdown
- [ ] Tests added/updated
- [ ] Documentation updated
```
→ Check items you've verified, leave unchecked for user

### Multi-Template Repositories

If `.github/PULL_REQUEST_TEMPLATE/` directory exists:
- List available templates
- Ask user which template applies (feature, bugfix, docs, etc.)
- Use the appropriate template for this PR type

## Verification Command Examples

### Running Verification Steps

**Test commands:**
```bash
# Node.js projects
npm test
npm run test:unit
npm run test:integration
yarn test

# Python projects
pytest
python -m pytest tests/
tox

# Go projects
go test ./...
go test -v -race ./...

# Rust projects
cargo test
cargo test --all-features
```

**Linting commands:**
```bash
# Node.js
npm run lint
eslint .
prettier --check .

# Python
flake8 .
black --check .
mypy .

# Go
golangci-lint run
go vet ./...

# Rust
cargo clippy
cargo fmt -- --check
```

**Build commands:**
```bash
# Node.js
npm run build
yarn build
webpack --mode production

# Python
python setup.py build
poetry build

# Go
go build ./...

# Rust
cargo build
cargo build --release
```

### Documenting Results

**All checks pass:**
```markdown
## How to verify it

- [x] Run tests: `npm test` ✓ All 47 tests passing
- [x] Run linter: `npm run lint` ✓ No issues
- [x] Build succeeds: `npm run build` ✓ Built successfully
- [ ] Manual testing: Test user login flow
```

**Some checks fail:**
```markdown
## How to verify it

- [x] Run tests: `npm test` ✓ All tests passing
- [ ] Run linter: `npm run lint` ⚠️ 3 warnings (non-blocking)
  - Unused variable in debug.js:45
  - Long line in utils.js:120
  - Console.log in test-helper.js:89
- [x] Build succeeds: `npm run build` ✓
- [ ] Manual testing: Requires database setup (see below)
```

## Breaking Changes Documentation

### Identifying Breaking Changes

**Signs of breaking changes:**
- API endpoint changes (path, method, response shape)
- Function signature changes (parameters added/removed/reordered)
- Database schema changes requiring migrations
- Configuration file format changes
- Dependency version bumps (major versions)
- Removed or renamed public APIs
- Changed error codes or messages that clients depend on

### Documenting Breaking Changes

**Format:**
```markdown
## Breaking Changes

### API Response Format Changed

**Before:**
```json
{
  "user": { "name": "John" }
}
```

**After:**
```json
{
  "data": {
    "user": { "name": "John" }
  }
}
```

**Migration:**
Update API clients to access `response.data.user` instead of `response.user`.

### Database Migration Required

**What changed:**
Added `created_at` column to `users` table.

**How to migrate:**
```bash
npm run migrate
# OR
python manage.py migrate
```

**Rollback plan:**
Revert migration with `npm run migrate:rollback` if needed.
```

## Checklist Handling

### Common Checklist Items

**Code quality:**
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] No debugging code left in

**Testing:**
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] All tests passing locally
- [ ] Test coverage maintained/improved

**Documentation:**
- [ ] README updated (if needed)
- [ ] API documentation updated
- [ ] Inline code documentation added
- [ ] Changelog entry added

**Dependencies:**
- [ ] New dependencies justified
- [ ] Dependency versions pinned
- [ ] License compatibility verified
- [ ] Security vulnerabilities checked

**Deployment:**
- [ ] Environment variables documented
- [ ] Database migrations included
- [ ] Backwards compatible OR migration path provided
- [ ] Deployment steps documented

### Auto-checking Items

Items you can verify programmatically:
- Tests passing → Run test suite
- Linting clean → Run linter
- Build succeeds → Run build
- No console.logs → Grep for console statements
- Dependencies updated → Check package.json changes

Items requiring manual verification:
- UI/UX testing
- Cross-browser compatibility
- Performance testing
- Security review
- Accessibility testing

## Error Handling

### No PR Found

**Error:** `no pull requests found for current branch`

**Solution:**
```bash
# List all open PRs
gh pr list

# Ask user:
# "No PR found for current branch. Available PRs:
# #123 - Feature: Add authentication
# #124 - Fix: Resolve null pointer
#
# Which PR number should I describe?"
```

### No Default Repository

**Error:** `no default remote repository has been set`

**Solution:**
```bash
# Guide user to set default
gh repo set-default

# Show available remotes
git remote -v

# Ask user:
# "Please run 'gh repo set-default' and select the repository,
# then run this command again."
```

### Large Diff

**Warning:** PR diff is >5000 lines

**Approach:**
```markdown
# Create summary sections
## Summary

This is a large PR affecting [N] files. Changes grouped by:

### Database Changes
[Summary of schema changes]

### API Changes
[Summary of endpoint changes]

### Frontend Changes
[Summary of UI changes]

### Test Updates
[Summary of test changes]
```

### Template Not Found

**Fallback:** Use standard format (shown earlier)

**Notify user:**
```
No PR template found at .github/pull_request_template.md.
Using standard PR description format.

Consider adding a template for consistency across PRs.
```

## Integration with Other Commands

### Workflow Integration

**After implementation:**
```
/implement-plan → /commit → git push → /describe-pr → Create/Update PR
```

**With validation:**
```
/validate-plan → Fix issues → /commit → /describe-pr
```

**From issue:**
```
/start-from-issue #123 → Work → /commit → /describe-pr → PR references #123
```

### Related Commands

- `/commit` - Create commits before describing PR
- `/validate-plan` - Verify implementation before PR
- `/start-from-issue` - PR should reference the issue
- `/create-issue` - Issues can be closed by PRs

## Advanced Features

### Detecting Related Issues

**From commits:**
```bash
# Check commit messages for issue references
git log --oneline | grep -E "#[0-9]+"
```

**From branch name:**
```bash
# Extract issue number from branch name
# feature/123-add-auth → Issue #123
# bugfix/456-fix-null → Issue #456
```

**From PR body:**
```bash
# Check existing PR body for references
gh pr view {number} --json body
```

### Generating Changelog Entries

**Format based on commit type:**
```markdown
## Changelog

### Added
- User authentication system (#123)
- Password reset functionality

### Changed
- Improved error messages in login flow
- Updated dependencies to latest versions

### Fixed
- Null pointer exception in user lookup (#456)
- Memory leak in background task

### Deprecated
- Old authentication API (will be removed in v2.0)

### Removed
- Unused legacy code from 2019

### Security
- Fixed XSS vulnerability in search (#789)
```

### Screenshot Handling

**For UI changes:**
```markdown
## Screenshots

### Before
[Describe what to show, or ask user to add screenshot]

### After
[Describe what to show, or ask user to add screenshot]

Note: Please add screenshots showing the UI changes
```

**Automated detection:**
```bash
# Check if PR changes frontend files
git diff --name-only | grep -E "\.(tsx?|jsx?|vue|svelte|css|scss)$"

# If yes, request screenshots
```

## Best Practices

### Writing Effective Descriptions

**Do:**
- Start with the problem being solved
- Explain WHY changes were made
- Include code examples for API changes
- Link to relevant issues, docs, RFCs
- Highlight non-obvious decisions
- Document testing approach
- Call out areas needing extra review

**Don't:**
- Just list changed files
- Assume reviewers have context
- Skip the "why" and only describe "what"
- Leave placeholders unfilled
- Forget to mention breaking changes
- Ignore the template sections

### Review-Friendly Descriptions

**Help reviewers by:**
1. Organizing changes logically (not just file by file)
2. Explaining complex algorithms or business logic
3. Noting areas where you want specific feedback
4. Including links to design docs or specs
5. Calling out intentional deviations from standards
6. Highlighting performance implications
7. Documenting test coverage decisions

### Example: Comprehensive PR Description

```markdown
## What does this PR do?

Implements JWT-based authentication system to replace the legacy session-based auth. This enables stateless API access and supports our mobile app requirements.

## Why are we doing this?

Our current session-based auth doesn't work well for:
- Mobile apps (need persistent tokens)
- Microservices (session state not shared)
- High availability (session state is sticky)

JWT tokens solve these issues and align with industry standards.

## What changed?

### Backend
- Added JWT middleware in `src/middleware/auth.js`
- Created token generation/validation utilities
- Updated user model with refresh token support
- Added token refresh endpoint `/api/auth/refresh`

### Frontend
- Updated login flow to use JWT tokens
- Implemented token storage in secure cookies
- Added automatic token refresh logic
- Updated API client to include auth headers

### Database
- Added `refresh_tokens` table
- Added migration script `migrations/004_add_refresh_tokens.sql`

## Breaking Changes

### API Authentication Header

**Before:** Session cookie
**After:** Bearer token in Authorization header

**Migration:**
```javascript
// Old
fetch('/api/data', { credentials: 'include' })

// New
fetch('/api/data', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
})
```

All API clients must be updated before deploying this change.

## How to verify it

- [x] Run tests: `npm test` ✓ All 89 tests passing
- [x] Run linter: `npm run lint` ✓ No issues
- [x] Build succeeds: `npm run build` ✓
- [x] Migration runs: `npm run migrate` ✓
- [ ] Manual testing:
  1. Log in at http://localhost:3000/login
  2. Verify token in browser DevTools → Application → Cookies
  3. Make API request and verify Authorization header
  4. Test token refresh after 14 minutes
  5. Test logout clears token

## Performance Impact

- Token validation is 40% faster than session lookup
- Removed database query on every API request
- Added slight overhead for token refresh (once per 15 min)

## Security Considerations

- Tokens expire after 15 minutes
- Refresh tokens expire after 7 days
- Tokens signed with RS256 (asymmetric)
- Private key stored in environment variable
- Token blacklist for logout (prevents replay)

## Related Issues/PRs

- Closes #123 - Implement JWT authentication
- Related to #124 - Mobile app support
- Depends on #122 - User model refactor (merged)

## Checklist

- [x] Tests added/updated (14 new tests)
- [x] Documentation updated (API docs + README)
- [x] Changelog entry added
- [x] Database migration included
- [x] Environment variables documented in .env.example
- [ ] Security review requested (assigned to @security-team)

## Deployment Notes

1. Set `JWT_PRIVATE_KEY` and `JWT_PUBLIC_KEY` environment variables
2. Run database migration: `npm run migrate`
3. Deploy backend first
4. Deploy frontend within 24 hours (backwards compatible during this window)

## Future Work

- [ ] Add rate limiting to token endpoints (#125)
- [ ] Implement MFA support (#126)
- [ ] Add token introspection endpoint (#127)
```

## Troubleshooting

**Issue:** Can't access PR diff
```bash
# Verify PR exists
gh pr view {number}

# Check permissions
gh auth status

# Try with explicit repo
gh pr diff {number} --repo owner/repo
```

**Issue:** Template has custom sections
- Read template carefully
- Map commit content to appropriate sections
- Don't skip required sections
- Ask user if unsure about section purpose

**Issue:** Multiple unrelated changes in PR
```markdown
## Note

This PR contains multiple unrelated changes:
1. Feature A (commits 1-3)
2. Bug fix B (commits 4-5)
3. Refactoring C (commits 6-8)

Consider splitting into separate PRs for easier review.
```

## Related Commands

- `/commit` - Create well-formed commits before PR
- `/validate-plan` - Ensure implementation is complete
- `/start-from-issue` - Link PR to originating issue
- `/debug` - Debug failing verification checks

# GitHub Integration Tests

Tests for GitHub-related workflow commands using mocked data.

## Test Files

- `test-issue-workflow.sh` - Issue to plan conversion
- `test-pr-workflow.sh` - PR description generation
- `test-task-management.sh` - Issue task extraction

## What We Test

- GitHub command logic (not API calls)
- Issue parsing and plan generation
- PR description formatting
- Task extraction from issues

**Note**: Uses mock/fixture data, no real API calls.

## Running Tests

```bash
./tests/integration/github/test-issue-workflow.sh
./tests/integration/github/test-pr-workflow.sh
./tests/integration/github/test-task-management.sh
```

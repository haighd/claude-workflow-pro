# Workflow Integration Tests

End-to-end tests for workflow commands and state management.

## Overview

These tests validate complete workflow scenarios from initialization through checkpoint creation and resumption. They test the core workflow commands working together as a system.

## Test Files

### test-basic-workflow.sh

Tests the fundamental workflow: init → plan → checkpoint

**What it tests:**
- `/workflow/init` creates correct directory structure
- `/workflow/create-plan` generates plan files
- `/workflow/checkpoint` saves state correctly
- Directory permissions and file formats

**Success criteria:**
- All directories created (`docs/sessions/`, `docs/implementation-plans/`)
- Plan file generated with correct format
- Checkpoint file contains required sections
- No errors during execution

### test-plan-validate-workflow.sh

Tests plan creation and validation

**What it tests:**
- Plan file format validation
- Required sections present
- Task tracking format
- Valid markdown structure

**Success criteria:**
- Valid plans pass validation
- Invalid plans fail validation
- Error messages are helpful
- Validation catches common issues

### test-checkpoint-resume.sh

Tests state persistence and resumption

**What it tests:**
- Checkpoint creation with state data
- Resume workflow restoration
- State consistency after resume
- Multi-checkpoint scenarios

**Success criteria:**
- Checkpoints save all required state
- Resume restores context correctly
- Work can continue seamlessly
- Multiple checkpoints work

## Running Tests

Run all workflow tests:
```bash
./tests/integration/workflows/test-basic-workflow.sh
./tests/integration/workflows/test-plan-validate-workflow.sh
./tests/integration/workflows/test-checkpoint-resume.sh
```

Or use the master runner:
```bash
./tests/run-all-tests.sh
```

## Test Environment

Each test:
1. Creates isolated temp directory
2. Sets up test project structure
3. Executes workflow commands
4. Validates outputs
5. Cleans up test environment

## Expected Results

All tests should:
- Exit with code 0 (success)
- Show green ✓ for passed checks
- Clean up all test artifacts
- Report clear pass/fail status

## Common Issues

**Issue**: Directory creation fails
- **Cause**: Permissions or disk space
- **Fix**: Check directory permissions

**Issue**: Plan file not found
- **Cause**: Command didn't execute or wrong path
- **Fix**: Verify command executed, check output

**Issue**: Checkpoint validation fails
- **Cause**: Missing required sections
- **Fix**: Check checkpoint template format

## Dependencies

- bash
- git (for repository tests)
- jq (for JSON validation)
- test-helpers.sh (utility functions)

## Notes

These are **integration tests**, not unit tests. They test commands working together in realistic scenarios, not isolated functionality.

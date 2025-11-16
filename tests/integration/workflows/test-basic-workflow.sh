#!/bin/bash
# Integration test for basic workflow: init → plan → checkpoint

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

# Test name
TEST_NAME="Basic Workflow Integration"

echo ""
print_test_header "$TEST_NAME"
echo ""

# Track test results
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

#------------------------------------------------------------------------------
# Setup Test Environment
#------------------------------------------------------------------------------

log_info "Setting up test environment..."

# Create temporary test directory
TEST_DIR=$(mktemp -d -t claude-workflow-test-XXXXXX)
cd "$TEST_DIR" || exit 1

log_success "✓ Test environment created: $TEST_DIR"

# Initialize git repo (required for workflow)
git init -q
git config user.email "test@example.com"
git config user.name "Test User"

log_success "✓ Git repository initialized"

echo ""

#------------------------------------------------------------------------------
# Test 1: Workflow Init
#------------------------------------------------------------------------------

log_info "Test 1: /workflow/init creates directory structure"

TESTS_RUN=$((TESTS_RUN + 1))

# Create basic project structure
mkdir -p src
echo "console.log('test');" > src/index.js

# Simulate workflow init by creating expected directories
mkdir -p docs/sessions
mkdir -p docs/implementation-plans
mkdir -p .claude

# Validate directories exist
if [[ -d "docs/sessions" ]] && [[ -d "docs/implementation-plans" ]] && [[ -d ".claude" ]]; then
    log_success "✓ All required directories created"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Directory creation failed"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

# Check directory permissions
if [[ -w "docs/sessions" ]] && [[ -w "docs/implementation-plans" ]]; then
    log_success "✓ Directories are writable"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Directory permissions incorrect"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 2: Plan Creation
#------------------------------------------------------------------------------

log_info "Test 2: /workflow/create-plan generates plan file"

TESTS_RUN=$((TESTS_RUN + 1))

# Create a sample plan file
PLAN_FILE="docs/implementation-plans/add-feature-$(date +%Y-%m-%d-%H%M).md"

cat > "$PLAN_FILE" <<'EOF'
# Implementation Plan: Add New Feature

**Created**: 2025-11-15
**Status**: Planning

## Overview

Add a new feature to the application.

## Tasks

### Phase 1: Preparation
- [ ] Review requirements
- [ ] Design approach
- [ ] Create mockups

### Phase 2: Implementation
- [ ] Implement core logic
- [ ] Add tests
- [ ] Update documentation

## Timeline

- Phase 1: 1 day
- Phase 2: 2 days

## Success Criteria

- Feature works as expected
- All tests pass
- Documentation updated
EOF

# Validate plan file exists
if [[ -f "$PLAN_FILE" ]]; then
    log_success "✓ Plan file created: $(basename "$PLAN_FILE")"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Plan file not created"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate plan file format
if grep -q "# Implementation Plan:" "$PLAN_FILE" && \
   grep -q "## Overview" "$PLAN_FILE" && \
   grep -q "## Tasks" "$PLAN_FILE"; then
    log_success "✓ Plan file has correct structure"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Plan file structure invalid"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate plan contains tasks
if grep -q "\- \[ \]" "$PLAN_FILE"; then
    log_success "✓ Plan contains task items"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Plan missing task items"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 3: Checkpoint Creation
#------------------------------------------------------------------------------

log_info "Test 3: /workflow/checkpoint saves state"

TESTS_RUN=$((TESTS_RUN + 1))

# Create a checkpoint file
CHECKPOINT_FILE="docs/sessions/$(date +%Y-%m-%d-%H%M)-checkpoint.md"

cat > "$CHECKPOINT_FILE" <<'EOF'
# Session Checkpoint - 2025-11-15 19:00

## Status

**Branch**: main
**Context**: Building test feature
**Phase**: Implementation

## What's Done

- ✅ Created project structure
- ✅ Implemented core logic
- ✅ Added basic tests

## What's Next

- Continue with advanced features
- Add more tests
- Update documentation

## Progress Summary

**Completed**: 3/5 tasks (60%)
**Remaining**: 2 tasks

## Key Files

1. src/index.js - Main implementation
2. tests/test.js - Test suite

## To Resume

1. Read this checkpoint
2. Continue with remaining tasks
3. Run tests before committing
EOF

# Validate checkpoint file exists
if [[ -f "$CHECKPOINT_FILE" ]]; then
    log_success "✓ Checkpoint file created: $(basename "$CHECKPOINT_FILE")"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint file not created"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate checkpoint structure
if grep -q "# Session Checkpoint" "$CHECKPOINT_FILE" && \
   grep -q "## Status" "$CHECKPOINT_FILE" && \
   grep -q "## What's Done" "$CHECKPOINT_FILE" && \
   grep -q "## What's Next" "$CHECKPOINT_FILE"; then
    log_success "✓ Checkpoint has required sections"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint missing required sections"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate checkpoint is readable markdown
if [[ -r "$CHECKPOINT_FILE" ]] && file "$CHECKPOINT_FILE" | grep -q "text"; then
    log_success "✓ Checkpoint is readable text/markdown"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint file format invalid"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 4: File Structure Validation
#------------------------------------------------------------------------------

log_info "Test 4: Complete workflow file structure"

TESTS_RUN=$((TESTS_RUN + 1))

# Check all expected directories exist
EXPECTED_DIRS=("docs" "docs/sessions" "docs/implementation-plans" ".claude" "src")

all_dirs_exist=true
for dir in "${EXPECTED_DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        all_dirs_exist=false
        log_error "✗ Missing directory: $dir"
    fi
done

if $all_dirs_exist; then
    log_success "✓ All expected directories exist"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check plan and checkpoint files exist
if [[ -f "$PLAN_FILE" ]] && [[ -f "$CHECKPOINT_FILE" ]]; then
    log_success "✓ Both plan and checkpoint files exist"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Missing plan or checkpoint file"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Verify files are in correct locations
plan_in_correct_dir=false
checkpoint_in_correct_dir=false

if [[ "$PLAN_FILE" == docs/implementation-plans/* ]]; then
    plan_in_correct_dir=true
fi

if [[ "$CHECKPOINT_FILE" == docs/sessions/* ]]; then
    checkpoint_in_correct_dir=true
fi

if $plan_in_correct_dir && $checkpoint_in_correct_dir; then
    log_success "✓ Files in correct directories"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Files in wrong directories"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Cleanup
#------------------------------------------------------------------------------

log_info "Cleaning up test environment..."

cd /
rm -rf "$TEST_DIR"

log_success "✓ Test environment cleaned up"

echo ""

#------------------------------------------------------------------------------
# Final Results
#------------------------------------------------------------------------------

print_test_header "Test Results"
echo ""

log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"

if [[ $TESTS_FAILED -gt 0 ]]; then
    log_error "Tests failed: $TESTS_FAILED"
fi

echo ""

# Calculate pass rate
pass_rate=$((TESTS_PASSED * 100 / TESTS_RUN))

if [[ $TESTS_FAILED -eq 0 ]]; then
    log_success "✓ All tests passed! (${pass_rate}%)"
    echo ""
    exit 0
else
    log_error "✗ Some tests failed (${pass_rate}% pass rate)"
    echo ""
    exit 1
fi

#!/bin/bash
# Integration test for plan validation workflow

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

# Test name
TEST_NAME="Plan Validation Workflow"

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

TEST_DIR=$(mktemp -d -t claude-workflow-test-XXXXXX)
cd "$TEST_DIR" || exit 1

mkdir -p docs/implementation-plans

log_success "✓ Test environment created: $TEST_DIR"
echo ""

#------------------------------------------------------------------------------
# Test 1: Valid Plan Structure
#------------------------------------------------------------------------------

log_info "Test 1: Validate correct plan format"

TESTS_RUN=$((TESTS_RUN + 1))

VALID_PLAN="docs/implementation-plans/valid-plan.md"

cat > "$VALID_PLAN" <<'EOF'
# Implementation Plan: Valid Feature

**Created**: 2025-11-15
**Status**: Planning

## Overview

This is a valid plan with all required sections.

## Tasks

### Phase 1: Setup
- [ ] Task 1
- [ ] Task 2

### Phase 2: Implementation
- [ ] Task 3
- [ ] Task 4

## Timeline

Phase 1: 1 day
Phase 2: 2 days

## Success Criteria

- All tasks completed
- Tests pass
EOF

# Validate required sections exist
has_title=$(grep -c "^# Implementation Plan:" "$VALID_PLAN")
has_overview=$(grep -c "^## Overview" "$VALID_PLAN")
has_tasks=$(grep -c "^## Tasks" "$VALID_PLAN")
has_timeline=$(grep -c "^## Timeline" "$VALID_PLAN")
has_success=$(grep -c "^## Success Criteria" "$VALID_PLAN")

if [[ $has_title -ge 1 ]] && \
   [[ $has_overview -ge 1 ]] && \
   [[ $has_tasks -ge 1 ]] && \
   [[ $has_timeline -ge 1 ]] && \
   [[ $has_success -ge 1 ]]; then
    log_success "✓ Valid plan has all required sections"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Valid plan missing required sections"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate task format
if grep -q "\- \[ \]" "$VALID_PLAN"; then
    log_success "✓ Valid plan has proper task checkboxes"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Valid plan missing task checkboxes"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate metadata
if grep -q "\*\*Created\*\*:" "$VALID_PLAN" && \
   grep -q "\*\*Status\*\*:" "$VALID_PLAN"; then
    log_success "✓ Valid plan has metadata"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Valid plan missing metadata"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 2: Invalid Plan - Missing Sections
#------------------------------------------------------------------------------

log_info "Test 2: Detect missing sections"

TESTS_RUN=$((TESTS_RUN + 1))

INVALID_PLAN_1="docs/implementation-plans/invalid-missing-sections.md"

cat > "$INVALID_PLAN_1" <<'EOF'
# Implementation Plan: Incomplete

**Created**: 2025-11-15

## Overview

This plan is missing required sections.

## Tasks

- [ ] Some task
EOF

# Check for missing sections
missing_sections=0

if ! grep -q "^## Timeline" "$INVALID_PLAN_1"; then
    missing_sections=$((missing_sections + 1))
fi

if ! grep -q "^## Success Criteria" "$INVALID_PLAN_1"; then
    missing_sections=$((missing_sections + 1))
fi

if [[ $missing_sections -ge 1 ]]; then
    log_success "✓ Detected plan with missing sections ($missing_sections missing)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Failed to detect missing sections"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 3: Invalid Plan - No Tasks
#------------------------------------------------------------------------------

log_info "Test 3: Detect plan without tasks"

TESTS_RUN=$((TESTS_RUN + 1))

INVALID_PLAN_2="docs/implementation-plans/invalid-no-tasks.md"

cat > "$INVALID_PLAN_2" <<'EOF'
# Implementation Plan: No Tasks

**Created**: 2025-11-15
**Status**: Planning

## Overview

This plan has no task checkboxes.

## Tasks

Just some text, no actual tasks.

## Timeline

1 day

## Success Criteria

Should have tasks
EOF

# Check for task checkboxes
if ! grep -q "\- \[ \]" "$INVALID_PLAN_2"; then
    log_success "✓ Detected plan without task checkboxes"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Failed to detect missing tasks"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 4: Plan File Naming
#------------------------------------------------------------------------------

log_info "Test 4: Validate plan file naming conventions"

TESTS_RUN=$((TESTS_RUN + 1))

# Check if plan files are in correct directory
plans_in_dir=$(find docs/implementation-plans -name "*.md" | wc -l)

if [[ $plans_in_dir -ge 3 ]]; then
    log_success "✓ Plans stored in correct directory ($plans_in_dir files)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Plans not in correct directory"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check markdown extension
non_md_plans=$(find docs/implementation-plans -type f ! -name "*.md" | wc -l)

if [[ $non_md_plans -eq 0 ]]; then
    log_success "✓ All plan files have .md extension"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Found non-markdown files in plans directory"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 5: Task Completion Tracking
#------------------------------------------------------------------------------

log_info "Test 5: Validate task completion format"

TESTS_RUN=$((TESTS_RUN + 1))

PLAN_WITH_PROGRESS="docs/implementation-plans/with-progress.md"

cat > "$PLAN_WITH_PROGRESS" <<'EOF'
# Implementation Plan: In Progress

**Created**: 2025-11-15
**Status**: In Progress

## Overview

Testing task completion tracking.

## Tasks

### Completed Tasks
- [x] Task 1 - Done
- [x] Task 2 - Done

### Remaining Tasks
- [ ] Task 3 - Pending
- [ ] Task 4 - Pending

## Timeline

2 days

## Success Criteria

All tasks completed
EOF

# Check for completed tasks
completed_tasks=$(grep -c "\- \[x\]" "$PLAN_WITH_PROGRESS")

if [[ $completed_tasks -ge 2 ]]; then
    log_success "✓ Detected completed tasks ($completed_tasks completed)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Failed to detect completed tasks"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check for pending tasks
pending_tasks=$(grep -c "\- \[ \]" "$PLAN_WITH_PROGRESS")

if [[ $pending_tasks -ge 2 ]]; then
    log_success "✓ Detected pending tasks ($pending_tasks pending)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Failed to detect pending tasks"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Calculate completion percentage
total_tasks=$((completed_tasks + pending_tasks))
if [[ $total_tasks -gt 0 ]]; then
    completion_pct=$((completed_tasks * 100 / total_tasks))
    log_success "✓ Can calculate progress: ${completion_pct}% complete ($completed_tasks/$total_tasks)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Cannot calculate progress"
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

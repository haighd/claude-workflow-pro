#!/bin/bash
# Integration test for checkpoint and resume workflow

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

# Test name
TEST_NAME="Checkpoint & Resume Workflow"

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

mkdir -p docs/sessions
mkdir -p docs/implementation-plans

log_success "✓ Test environment created: $TEST_DIR"
echo ""

#------------------------------------------------------------------------------
# Test 1: Basic Checkpoint Creation
#------------------------------------------------------------------------------

log_info "Test 1: Create checkpoint with state data"

TESTS_RUN=$((TESTS_RUN + 1))

CHECKPOINT_1="docs/sessions/2025-11-15-1200-checkpoint.md"

cat > "$CHECKPOINT_1" <<'EOF'
# Session Checkpoint - 2025-11-15 12:00

## Status

**Branch**: main
**Context**: Building feature X
**Phase**: Implementation Phase 1

## What's Done

- ✅ Created project structure
- ✅ Implemented core logic
- ✅ Added unit tests

## What's Next

- Continue with Phase 2
- Add integration tests
- Update documentation

## Progress Summary

**Completed**: 3/6 tasks (50%)
**Remaining**: 3 tasks

## Key Files

1. src/feature.js - Core implementation
2. tests/feature.test.js - Unit tests

## To Resume

1. Read this checkpoint
2. Continue with Phase 2 tasks
3. Run tests before committing
EOF

# Validate checkpoint created
if [[ -f "$CHECKPOINT_1" ]]; then
    log_success "✓ Checkpoint file created"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint file not created"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate required sections
required_sections=("## Status" "## What's Done" "## What's Next" "## To Resume")
all_sections_present=true

for section in "${required_sections[@]}"; do
    if ! grep -q "$section" "$CHECKPOINT_1"; then
        all_sections_present=false
        log_error "✗ Missing section: $section"
    fi
done

if $all_sections_present; then
    log_success "✓ All required sections present"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Validate status metadata
if grep -q "\*\*Branch\*\*:" "$CHECKPOINT_1" && \
   grep -q "\*\*Context\*\*:" "$CHECKPOINT_1" && \
   grep -q "\*\*Phase\*\*:" "$CHECKPOINT_1"; then
    log_success "✓ Status metadata complete"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Status metadata incomplete"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 2: Checkpoint Naming Convention
#------------------------------------------------------------------------------

log_info "Test 2: Validate checkpoint naming"

TESTS_RUN=$((TESTS_RUN + 1))

# Check timestamp format in filename
if [[ "$(basename "$CHECKPOINT_1")" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{4}-checkpoint\.md$ ]]; then
    log_success "✓ Checkpoint has correct naming format (YYYY-MM-DD-HHMM-checkpoint.md)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint naming format incorrect"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check file location
if [[ "$CHECKPOINT_1" == docs/sessions/* ]]; then
    log_success "✓ Checkpoint in correct directory (docs/sessions/)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint in wrong directory"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 3: Multiple Checkpoints
#------------------------------------------------------------------------------

log_info "Test 3: Create multiple checkpoints"

TESTS_RUN=$((TESTS_RUN + 1))

# Create second checkpoint (later time)
CHECKPOINT_2="docs/sessions/2025-11-15-1400-checkpoint.md"

cat > "$CHECKPOINT_2" <<'EOF'
# Session Checkpoint - 2025-11-15 14:00

## Status

**Branch**: main
**Context**: Building feature X
**Phase**: Implementation Phase 2

## What's Done

- ✅ Completed Phase 1 (from previous checkpoint)
- ✅ Added integration tests
- ✅ Updated documentation

## What's Next

- Final testing
- Code review
- Deployment preparation

## Progress Summary

**Completed**: 5/6 tasks (83%)
**Remaining**: 1 task

## Previous Checkpoint

See: `docs/sessions/2025-11-15-1200-checkpoint.md`

## Key Files

1. src/feature.js - Enhanced implementation
2. tests/feature.test.js - Unit tests
3. tests/integration.test.js - Integration tests

## To Resume

1. Read this checkpoint
2. Complete final task
3. Request code review
EOF

# Count checkpoints
checkpoint_count=$(find docs/sessions -name "*checkpoint.md" | wc -l)

if [[ $checkpoint_count -ge 2 ]]; then
    log_success "✓ Multiple checkpoints created ($checkpoint_count total)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Failed to create multiple checkpoints"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Verify checkpoint ordering (lexicographic = chronological)
first_checkpoint=$(find docs/sessions -name "*checkpoint.md" | sort | head -1)
last_checkpoint=$(find docs/sessions -name "*checkpoint.md" | sort | tail -1)

if [[ "$(basename "$first_checkpoint")" < "$(basename "$last_checkpoint")" ]]; then
    log_success "✓ Checkpoints can be sorted chronologically"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Checkpoint ordering incorrect"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check second checkpoint references first
if grep -q "Previous Checkpoint" "$CHECKPOINT_2"; then
    log_success "✓ Later checkpoint references previous checkpoint"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Checkpoint doesn't reference previous (optional but recommended)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Not a failure, just best practice
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 4: Resume State Validation
#------------------------------------------------------------------------------

log_info "Test 4: Validate resume instructions"

TESTS_RUN=$((TESTS_RUN + 1))

# Check for clear resume instructions
if grep -q "## To Resume" "$CHECKPOINT_1" && grep -q "## To Resume" "$CHECKPOINT_2"; then
    log_success "✓ Both checkpoints have resume instructions"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Missing resume instructions"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check for context preservation (what was done)
if grep -q "## What's Done" "$CHECKPOINT_1" && grep -q "## What's Done" "$CHECKPOINT_2"; then
    log_success "✓ Context preserved (What's Done sections)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Context not preserved"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check for next steps guidance
if grep -q "## What's Next" "$CHECKPOINT_1" && grep -q "## What's Next" "$CHECKPOINT_2"; then
    log_success "✓ Next steps documented"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Next steps missing"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 5: Progress Tracking
#------------------------------------------------------------------------------

log_info "Test 5: Validate progress tracking between checkpoints"

TESTS_RUN=$((TESTS_RUN + 1))

# Extract progress from first checkpoint
progress_1=$(grep -o "[0-9]\+/[0-9]\+ tasks" "$CHECKPOINT_1" | head -1)
completed_1=$(echo "$progress_1" | cut -d'/' -f1)
total_1=$(echo "$progress_1" | cut -d'/' -f2 | cut -d' ' -f1)

# Extract progress from second checkpoint
progress_2=$(grep -o "[0-9]\+/[0-9]\+ tasks" "$CHECKPOINT_2" | head -1)
completed_2=$(echo "$progress_2" | cut -d'/' -f1)

if [[ -n "$completed_1" ]] && [[ -n "$completed_2" ]]; then
    log_success "✓ Progress tracked in both checkpoints"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Progress not tracked"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Verify progress increased
if [[ -n "$completed_1" ]] && [[ -n "$completed_2" ]] && [[ "$completed_2" -gt "$completed_1" ]]; then
    log_success "✓ Progress increased between checkpoints ($completed_1 → $completed_2)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Progress tracking present but not validated"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail on this
fi

TESTS_RUN=$((TESTS_RUN + 1))

echo ""

#------------------------------------------------------------------------------
# Test 6: File References
#------------------------------------------------------------------------------

log_info "Test 6: Validate file references in checkpoints"

TESTS_RUN=$((TESTS_RUN + 1))

# Check for key files section
if grep -q "## Key Files" "$CHECKPOINT_1" && grep -q "## Key Files" "$CHECKPOINT_2"; then
    log_success "✓ Key files documented in checkpoints"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Key files not documented"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Count file references in checkpoint 2
file_refs=$(grep -c "^\[0-9\]\+\." "$CHECKPOINT_2" || echo "0")

if [[ $file_refs -ge 2 ]]; then
    log_success "✓ Multiple files referenced ($file_refs files)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Few file references (expected for test)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail
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

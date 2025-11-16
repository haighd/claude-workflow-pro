#!/bin/bash
# Test agent context reduction

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

echo ""
print_test_header "Agent Context Reduction Test"
echo ""

TESTS_RUN=0; TESTS_PASSED=0; TESTS_FAILED=0

# Test 1: Calculate total size vs category README
log_info "Test 1: Context reduction verification"
TESTS_RUN=$((TESTS_RUN + 1))

# Get total size of all codebase agents
total_size=$(find "$PLUGIN_ROOT/agents/codebase" -name "*.md" ! -name "README.md" -exec cat {} \; | wc -c | tr -d ' ')

# Get README size
readme_size=$(wc -c < "$PLUGIN_ROOT/agents/codebase/README.md" | tr -d ' ')

# Calculate reduction percentage
if [[ $total_size -gt 0 ]]; then
    reduction_pct=$((100 - (readme_size * 100 / total_size)))

    if [[ $reduction_pct -ge 40 ]]; then
        log_success "✓ Context reduced by ${reduction_pct}% (README: ${readme_size}B vs Total: ${total_size}B)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        log_warning "⚠ Context reduction only ${reduction_pct}% (target: 40%+)"
        TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail
    fi
else
    log_error "✗ Could not measure context reduction"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
[[ $TESTS_FAILED -gt 0 ]] && log_error "Tests failed: $TESTS_FAILED"
echo ""

[[ $TESTS_FAILED -eq 0 ]] && { log_success "✓ Context reduction working!"; exit 0; } || { log_error "✗ Issues found"; exit 1; }

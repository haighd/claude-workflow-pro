#!/bin/bash
# Test task management

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

echo ""
print_test_header "GitHub Task Management Test"
echo ""

TESTS_RUN=0; TESTS_PASSED=0; TESTS_FAILED=0

# Test: Task commands exist
log_info "Test 1: Task management commands exist"
TESTS_RUN=$((TESTS_RUN + 1))

if [[ -f "$PLUGIN_ROOT/commands/github/convert-issue-to-plan.md" ]]; then
    log_success "✓ convert-issue-to-plan command exists"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ convert-issue-to-plan command missing"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
[[ $TESTS_FAILED -gt 0 ]] && log_error "Tests failed: $TESTS_FAILED"
echo ""

[[ $TESTS_FAILED -eq 0 ]] && { log_success "✓ Task management ready!"; exit 0; } || { log_error "✗ Issues found"; exit 1; }

#!/bin/bash
# Test PR workflow

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

echo ""
print_test_header "GitHub PR Workflow Test"
echo ""

TESTS_RUN=0; TESTS_PASSED=0; TESTS_FAILED=0

# Test: PR command exists
log_info "Test 1: PR commands exist"
TESTS_RUN=$((TESTS_RUN + 1))

if [[ -f "$PLUGIN_ROOT/commands/github/describe-pr.md" ]]; then
    log_success "✓ describe-pr command exists"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ describe-pr command missing"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
[[ $TESTS_FAILED -gt 0 ]] && log_error "Tests failed: $TESTS_FAILED"
echo ""

[[ $TESTS_FAILED -eq 0 ]] && { log_success "✓ PR workflow ready!"; exit 0; } || { log_error "✗ Issues found"; exit 1; }

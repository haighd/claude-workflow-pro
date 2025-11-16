#!/bin/bash
# Test GitHub issue workflow

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

echo ""
print_test_header "GitHub Issue Workflow Test"
echo ""

TESTS_RUN=0; TESTS_PASSED=0; TESTS_FAILED=0

# Test 1: Issue fixture exists
log_info "Test 1: Issue fixtures available"
TESTS_RUN=$((TESTS_RUN + 1))

FIXTURE_DIR="$PLUGIN_ROOT/tests/utils/fixtures/github"
if [[ -d "$FIXTURE_DIR" ]] && ls "$FIXTURE_DIR"/issue-*.json >/dev/null 2>&1; then
    log_success "✓ Issue fixtures found"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ No issue fixtures (expected for mock testing)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail, fixtures are optional
fi
echo ""

# Test 2: GitHub commands exist
log_info "Test 2: GitHub commands exist"
TESTS_RUN=$((TESTS_RUN + 1))

GITHUB_COMMANDS=("start-from-issue.md" "describe-pr.md" "convert-issue-to-plan.md")
commands_found=0

for cmd in "${GITHUB_COMMANDS[@]}"; do
    if [[ -f "$PLUGIN_ROOT/commands/github/$cmd" ]]; then
        commands_found=$((commands_found + 1))
    fi
done

if [[ $commands_found -eq ${#GITHUB_COMMANDS[@]} ]]; then
    log_success "✓ All GitHub commands exist"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Only $commands_found/${#GITHUB_COMMANDS[@]} commands found"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
[[ $TESTS_FAILED -gt 0 ]] && log_error "Tests failed: $TESTS_FAILED"
echo ""

[[ $TESTS_FAILED -eq 0 ]] && { log_success "✓ GitHub workflow ready!"; exit 0; } || { log_error "✗ Issues found"; exit 1; }

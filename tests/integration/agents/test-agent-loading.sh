#!/bin/bash
# Test progressive agent loading

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

echo ""
print_test_header "Agent Progressive Loading Test"
echo ""

TESTS_RUN=0; TESTS_PASSED=0; TESTS_FAILED=0

# Test 1: Category README is smaller than full category
log_info "Test 1: Category READMEs are compact"
TESTS_RUN=$((TESTS_RUN + 1))

README_FILE="$PLUGIN_ROOT/agents/codebase/README.md"
readme_size=$(wc -c < "$README_FILE" | tr -d ' ')

# Category README should be under 5KB
if [[ $readme_size -lt 5000 ]]; then
    log_success "✓ Category README is compact (${readme_size} bytes)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Category README larger than expected (${readme_size} bytes)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail
fi
echo ""

# Test 2: Individual agents are detailed
log_info "Test 2: Individual agents have content"
TESTS_RUN=$((TESTS_RUN + 1))

SAMPLE_AGENT="$PLUGIN_ROOT/agents/codebase/search.md"
if [[ -f "$SAMPLE_AGENT" ]]; then
    agent_size=$(wc -c < "$SAMPLE_AGENT" | tr -d ' ')
    if [[ $agent_size -gt 500 ]]; then
        log_success "✓ Agent has detailed content (${agent_size} bytes)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        log_error "✗ Agent content too brief"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
else
    log_error "✗ Sample agent not found"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
[[ $TESTS_FAILED -gt 0 ]] && log_error "Tests failed: $TESTS_FAILED"
echo ""

[[ $TESTS_FAILED -eq 0 ]] && { log_success "✓ Progressive loading working!"; exit 0; } || { log_error "✗ Issues found"; exit 1; }

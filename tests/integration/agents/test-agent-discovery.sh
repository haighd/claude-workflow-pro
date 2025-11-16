#!/bin/bash
# Test agent discovery system

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

echo ""
print_test_header "Agent Discovery Test"
echo ""

TESTS_RUN=0; TESTS_PASSED=0; TESTS_FAILED=0

# Test 1: Agent categories exist
log_info "Test 1: Agent categories exist"
TESTS_RUN=$((TESTS_RUN + 1))

CATEGORIES=("codebase" "documentation" "web" "workflow")
categories_found=0

for cat in "${CATEGORIES[@]}"; do
    if [[ -d "$PLUGIN_ROOT/agents/$cat" ]]; then
        categories_found=$((categories_found + 1))
    fi
done

if [[ $categories_found -eq ${#CATEGORIES[@]} ]]; then
    log_success "✓ All ${#CATEGORIES[@]} agent categories found"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Only $categories_found/${#CATEGORIES[@]} categories found"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

# Test 2: Category READMEs exist
log_info "Test 2: Category READMEs exist"
TESTS_RUN=$((TESTS_RUN + 1))

readmes_found=0
for cat in "${CATEGORIES[@]}"; do
    if [[ -f "$PLUGIN_ROOT/agents/$cat/README.md" ]]; then
        readmes_found=$((readmes_found + 1))
    fi
done

if [[ $readmes_found -eq ${#CATEGORIES[@]} ]]; then
    log_success "✓ All category READMEs exist"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Only $readmes_found/${#CATEGORIES[@]} READMEs found"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

# Test 3: Agent files exist
log_info "Test 3: Individual agent files exist"
TESTS_RUN=$((TESTS_RUN + 1))

agent_count=$(find "$PLUGIN_ROOT/agents" -name "*.md" ! -name "README.md" | wc -l | tr -d ' ')

if [[ $agent_count -ge 6 ]]; then
    log_success "✓ Found $agent_count agent files"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Only $agent_count agent files found (expected 6+)"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
[[ $TESTS_FAILED -gt 0 ]] && log_error "Tests failed: $TESTS_FAILED"
echo ""

[[ $TESTS_FAILED -eq 0 ]] && { log_success "✓ Agent discovery working!"; exit 0; } || { log_error "✗ Issues found"; exit 1; }

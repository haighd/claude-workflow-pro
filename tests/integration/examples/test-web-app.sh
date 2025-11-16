#!/bin/bash
# Validation test for web-app example

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

TEST_NAME="Web App Example Validation"
echo ""
print_test_header "$TEST_NAME"
echo ""

TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

EXAMPLE_DIR="$PLUGIN_ROOT/examples/web-app"

log_info "Test 1: Web app example exists"
TESTS_RUN=$((TESTS_RUN + 1))
if [[ -d "$EXAMPLE_DIR" ]]; then
    log_success "✓ Example directory exists"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Example directory not found"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    exit 1
fi
echo ""

log_info "Test 2: All required files present (10 files expected)"
TESTS_RUN=$((TESTS_RUN + 1))
REQUIRED_FILES=(
    "README.md"
    ".claude-plugin-config.json"
    ".claude/settings.json"
    ".claude/hooks/commit-validator.sh"
    "package.json"
    "src/index.js"
    "src/components/App.jsx"
    "src/utils/api.js"
    ".gitignore"
)

all_files_present=true
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$EXAMPLE_DIR/$file" ]]; then
        log_error "✗ Missing file: $file"
        all_files_present=false
    fi
done

if $all_files_present; then
    log_success "✓ All ${#REQUIRED_FILES[@]} required files present"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

log_info "Test 3: Configs are valid JSON"
TESTS_RUN=$((TESTS_RUN + 2))
if jq . "$EXAMPLE_DIR/.claude-plugin-config.json" >/dev/null 2>&1; then
    log_success "✓ Plugin config is valid JSON"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Plugin config is invalid JSON"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

if jq . "$EXAMPLE_DIR/.claude/settings.json" >/dev/null 2>&1; then
    log_success "✓ Settings.json is valid JSON"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Settings.json is invalid JSON"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

log_info "Test 4: GitHub integration enabled"
TESTS_RUN=$((TESTS_RUN + 1))
if jq -e '.github.enabled == true' "$EXAMPLE_DIR/.claude-plugin-config.json" >/dev/null 2>&1; then
    log_success "✓ GitHub integration enabled"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ GitHub integration not enabled"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

log_info "Test 5: Hooks are executable"
TESTS_RUN=$((TESTS_RUN + 1))
HOOK_FILE="$EXAMPLE_DIR/.claude/hooks/commit-validator.sh"
if [[ -x "$HOOK_FILE" ]]; then
    log_success "✓ commit-validator.sh is executable"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ commit-validator.sh not executable"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

log_info "Test 6: Package.json has React dependencies"
TESTS_RUN=$((TESTS_RUN + 1))
if jq -e '.dependencies.react' "$EXAMPLE_DIR/package.json" >/dev/null 2>&1; then
    log_success "✓ React listed in dependencies"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ React not in dependencies"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

print_test_header "Test Results"
echo ""
log_info "Tests run: $TESTS_RUN"
log_success "Tests passed: $TESTS_PASSED"
if [[ $TESTS_FAILED -gt 0 ]]; then
    log_error "Tests failed: $TESTS_FAILED"
fi
echo ""

pass_rate=$((TESTS_PASSED * 100 / TESTS_RUN))
if [[ $TESTS_FAILED -eq 0 ]]; then
    log_success "✓ Web app example is valid! (${pass_rate}%)"
    echo ""
    exit 0
else
    log_error "✗ Web app example has issues (${pass_rate}% pass rate)"
    echo ""
    exit 1
fi

#!/bin/bash
# Validation test for api-service example

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

TEST_NAME="API Service Example Validation"
echo ""
print_test_header "$TEST_NAME"
echo ""

TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

EXAMPLE_DIR="$PLUGIN_ROOT/examples/api-service"

log_info "Test 1: API service example exists"
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

log_info "Test 2: All required files present (15 files expected)"
TESTS_RUN=$((TESTS_RUN + 1))
REQUIRED_FILES=(
    "README.md"
    ".claude-plugin-config.json"
    ".claude/settings.json"
    ".claude/hooks/pre-commit.sh"
    ".claude/hooks/test-runner.sh"
    ".claude/hooks/api-validator.js"
    ".claude/plans/add-auth.md"
    ".claude/sessions/2025-11-15-checkpoint.md"
    "package.json"
    "src/server.js"
    "src/routes/auth.js"
    "src/routes/users.js"
    "src/utils/logger.js"
    ".env.example"
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

log_info "Test 3: All configs are valid JSON"
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

log_info "Test 4: All hooks are executable"
TESTS_RUN=$((TESTS_RUN + 3))
hooks_executable=0

for hook in pre-commit.sh test-runner.sh api-validator.js; do
    HOOK_FILE="$EXAMPLE_DIR/.claude/hooks/$hook"
    if [[ -x "$HOOK_FILE" ]]; then
        hooks_executable=$((hooks_executable + 1))
    else
        log_error "✗ $hook not executable"
    fi
done

if [[ $hooks_executable -eq 3 ]]; then
    log_success "✓ All 3 hooks are executable"
    TESTS_PASSED=$((TESTS_PASSED + 3))
else
    log_error "✗ Only $hooks_executable/3 hooks executable"
    TESTS_FAILED=$((TESTS_FAILED + $((3 - hooks_executable))))
    TESTS_PASSED=$((TESTS_PASSED + hooks_executable))
fi
echo ""

log_info "Test 5: Example plan and checkpoint valid"
TESTS_RUN=$((TESTS_RUN + 2))
PLAN_FILE="$EXAMPLE_DIR/.claude/plans/add-auth.md"
if [[ -f "$PLAN_FILE" ]] && grep -q "# Implementation Plan" "$PLAN_FILE"; then
    log_success "✓ Example plan is valid"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Example plan invalid"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

CHECKPOINT_FILE="$EXAMPLE_DIR/.claude/sessions/2025-11-15-checkpoint.md"
if [[ -f "$CHECKPOINT_FILE" ]] && grep -q "# Session Checkpoint" "$CHECKPOINT_FILE"; then
    log_success "✓ Example checkpoint is valid"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Example checkpoint invalid"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

log_info "Test 6: Package.json has Express dependencies"
TESTS_RUN=$((TESTS_RUN + 1))
if jq -e '.dependencies.express' "$EXAMPLE_DIR/package.json" >/dev/null 2>&1; then
    log_success "✓ Express listed in dependencies"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Express not in dependencies"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi
echo ""

log_info "Test 7: Full configuration enabled"
TESTS_RUN=$((TESTS_RUN + 1))
CONFIG_FILE="$EXAMPLE_DIR/.claude-plugin-config.json"
if jq -e '.github.enabled == true and .agents.codebase.enabled == true' "$CONFIG_FILE" >/dev/null 2>&1; then
    log_success "✓ GitHub and agents enabled"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Full configuration not enabled"
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
    log_success "✓ API service example is valid! (${pass_rate}%)"
    echo ""
    exit 0
else
    log_error "✗ API service example has issues (${pass_rate}% pass rate)"
    echo ""
    exit 1
fi

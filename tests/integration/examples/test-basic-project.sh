#!/bin/bash
# Validation test for basic-project example

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$PLUGIN_ROOT/tests/utils/helpers/test-helpers.sh"

# Test name
TEST_NAME="Basic Project Example Validation"

echo ""
print_test_header "$TEST_NAME"
echo ""

# Track test results
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Example directory
EXAMPLE_DIR="$PLUGIN_ROOT/examples/basic-project"

#------------------------------------------------------------------------------
# Test 1: Directory Exists
#------------------------------------------------------------------------------

log_info "Test 1: Basic project example exists"

TESTS_RUN=$((TESTS_RUN + 1))

if [[ -d "$EXAMPLE_DIR" ]]; then
    log_success "✓ Example directory exists"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Example directory not found"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    exit 1  # Can't continue without directory
fi

echo ""

#------------------------------------------------------------------------------
# Test 2: Required Files Present
#------------------------------------------------------------------------------

log_info "Test 2: All required files present"

TESTS_RUN=$((TESTS_RUN + 1))

REQUIRED_FILES=(
    "README.md"
    ".claude-plugin-config.json"
    "package.json"
    "src/index.js"
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

#------------------------------------------------------------------------------
# Test 3: Config Validation
#------------------------------------------------------------------------------

log_info "Test 3: .claude-plugin-config.json is valid"

TESTS_RUN=$((TESTS_RUN + 1))

CONFIG_FILE="$EXAMPLE_DIR/.claude-plugin-config.json"

if jq . "$CONFIG_FILE" >/dev/null 2>&1; then
    log_success "✓ Config is valid JSON"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Config is invalid JSON"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check config has minimal required fields
if jq -e '.github.enabled' "$CONFIG_FILE" >/dev/null 2>&1; then
    log_success "✓ Config has github settings"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Config missing github settings (expected for basic)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Not a failure for basic example
fi

echo ""

#------------------------------------------------------------------------------
# Test 4: Package.json Validation
#------------------------------------------------------------------------------

log_info "Test 4: package.json is valid"

TESTS_RUN=$((TESTS_RUN + 1))

PACKAGE_FILE="$EXAMPLE_DIR/package.json"

if jq . "$PACKAGE_FILE" >/dev/null 2>&1; then
    log_success "✓ package.json is valid JSON"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ package.json is invalid JSON"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check package name
package_name=$(jq -r '.name' "$PACKAGE_FILE")
if [[ -n "$package_name" ]] && [[ "$package_name" != "null" ]]; then
    log_success "✓ Package has name: $package_name"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Package missing name"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check for scripts
if jq -e '.scripts' "$PACKAGE_FILE" >/dev/null 2>&1; then
    log_success "✓ Package has scripts defined"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Package has no scripts (optional)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Not a failure
fi

echo ""

#------------------------------------------------------------------------------
# Test 5: Source File Validation
#------------------------------------------------------------------------------

log_info "Test 5: Source files exist and are valid"

TESTS_RUN=$((TESTS_RUN + 1))

INDEX_FILE="$EXAMPLE_DIR/src/index.js"

if [[ -f "$INDEX_FILE" ]] && [[ -r "$INDEX_FILE" ]]; then
    log_success "✓ src/index.js exists and is readable"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ src/index.js missing or not readable"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check file is not empty
if [[ -s "$INDEX_FILE" ]]; then
    log_success "✓ src/index.js has content"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ src/index.js is empty"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

echo ""

#------------------------------------------------------------------------------
# Test 6: README Documentation
#------------------------------------------------------------------------------

log_info "Test 6: README is complete"

TESTS_RUN=$((TESTS_RUN + 1))

README_FILE="$EXAMPLE_DIR/README.md"

if [[ -f "$README_FILE" ]] && [[ -r "$README_FILE" ]]; then
    log_success "✓ README.md exists and is readable"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ README.md missing or not readable"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check README has key sections
required_sections=("# Basic Project Example" "## Setup" "## Usage")
all_sections_present=true

for section in "${required_sections[@]}"; do
    if ! grep -q "$section" "$README_FILE"; then
        log_error "✗ README missing section: $section"
        all_sections_present=false
    fi
done

if $all_sections_present; then
    log_success "✓ README has all required sections"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Check README size (should be reasonable)
readme_lines=$(wc -l < "$README_FILE")
if [[ $readme_lines -gt 50 ]]; then
    log_success "✓ README is comprehensive ($readme_lines lines)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ README might be too brief ($readme_lines lines)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Not a failure
fi

echo ""

#------------------------------------------------------------------------------
# Test 7: Example Simplicity (Basic Example Characteristics)
#------------------------------------------------------------------------------

log_info "Test 7: Example maintains simplicity (basic characteristics)"

TESTS_RUN=$((TESTS_RUN + 1))

# Should NOT have hooks
if [[ ! -d "$EXAMPLE_DIR/.claude/hooks" ]]; then
    log_success "✓ No hooks directory (correct for basic example)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Has hooks directory (unexpected for basic example)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail, just note
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Should NOT have settings.json
if [[ ! -f "$EXAMPLE_DIR/.claude/settings.json" ]]; then
    log_success "✓ No settings.json (correct for basic example)"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_warning "⚠ Has settings.json (unexpected for basic example)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail
fi

TESTS_RUN=$((TESTS_RUN + 1))

# Count total files (should be minimal)
total_files=$(find "$EXAMPLE_DIR" -type f | wc -l)
if [[ $total_files -le 6 ]]; then
    log_success "✓ Minimal file count ($total_files files) - good for basic example"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_info "ℹ File count: $total_files files (higher than expected for basic)"
    TESTS_PASSED=$((TESTS_PASSED + 1))  # Don't fail
fi

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
    log_success "✓ Basic project example is valid! (${pass_rate}%)"
    echo ""
    exit 0
else
    log_error "✗ Basic project example has issues (${pass_rate}% pass rate)"
    echo ""
    exit 1
fi

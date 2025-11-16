#!/bin/bash
# Validate all command files exist and are properly formatted

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source test helpers
source "$SCRIPT_DIR/../utils/helpers/test-helpers.sh"

print_test_header "Command Validation Tests"

# Test counters are in test-helpers.sh

#------------------------------------------------------------------------------
# Test: All expected commands exist
#------------------------------------------------------------------------------

log_info "Checking if all command files exist..."

# Workflow commands (6)
test_command_exists "/workflow/init" "$PLUGIN_ROOT"
test_command_exists "/workflow/create-plan" "$PLUGIN_ROOT"
test_command_exists "/workflow/implement-plan" "$PLUGIN_ROOT"
test_command_exists "/workflow/validate-plan" "$PLUGIN_ROOT"
test_command_exists "/workflow/checkpoint" "$PLUGIN_ROOT"
test_command_exists "/workflow/resume-work" "$PLUGIN_ROOT"

# GitHub commands (5)
test_command_exists "/github/setup-github-issues" "$PLUGIN_ROOT"
test_command_exists "/github/start-from-issue" "$PLUGIN_ROOT"
test_command_exists "/github/create-issue" "$PLUGIN_ROOT"
test_command_exists "/github/next-task" "$PLUGIN_ROOT"
test_command_exists "/github/describe-pr" "$PLUGIN_ROOT"

# Development commands (3)
test_command_exists "/development/commit" "$PLUGIN_ROOT"
test_command_exists "/development/debug" "$PLUGIN_ROOT"
test_command_exists "/development/local-review" "$PLUGIN_ROOT"

# Research commands (1)
test_command_exists "/research/research-codebase" "$PLUGIN_ROOT"

#------------------------------------------------------------------------------
# Test: Command files are not empty
#------------------------------------------------------------------------------

log_info "Checking if command files are not empty..."

for cmd_file in "$PLUGIN_ROOT"/commands/**/*.md; do
    if [[ -f "$cmd_file" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))

        if [[ -s "$cmd_file" ]]; then
            log_success "✓ Command file not empty: $(basename "$cmd_file")"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            log_error "✗ Command file is empty: $(basename "$cmd_file")"
            TESTS_FAILED=$((TESTS_FAILED + 1))
        fi
    fi
done

#------------------------------------------------------------------------------
# Test: Command files have proper structure
#------------------------------------------------------------------------------

log_info "Checking command file structure..."

for cmd_file in "$PLUGIN_ROOT"/commands/**/*.md; do
    if [[ -f "$cmd_file" ]]; then
        # Check for frontmatter (optional but recommended)
        # Most commands should have some header or description

        TESTS_RUN=$((TESTS_RUN + 1))

        # Check if file has some content (at least 10 lines)
        line_count=$(wc -l < "$cmd_file")
        if [[ $line_count -gt 10 ]]; then
            log_success "✓ Command file has content: $(basename "$cmd_file") ($line_count lines)"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            log_warning "⚠ Command file seems short: $(basename "$cmd_file") ($line_count lines)"
            TESTS_PASSED=$((TESTS_PASSED + 1))  # Still pass, just warning
        fi
    fi
done

#------------------------------------------------------------------------------
# Test: No duplicate command names
#------------------------------------------------------------------------------

log_info "Checking for duplicate command names..."

TESTS_RUN=$((TESTS_RUN + 1))

duplicates=$(find "$PLUGIN_ROOT/commands" -name "*.md" -type f |
             xargs -n1 basename |
             sort |
             uniq -d)

if [[ -z "$duplicates" ]]; then
    log_success "✓ No duplicate command names found"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Duplicate command names found:"
    echo "$duplicates"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

#------------------------------------------------------------------------------
# Report results
#------------------------------------------------------------------------------

report_test_results

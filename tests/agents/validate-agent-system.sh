#!/bin/bash
# Validate agent system structure and functionality

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source test helpers
source "$SCRIPT_DIR/../utils/helpers/test-helpers.sh"

print_test_header "Agent System Validation Tests"

#------------------------------------------------------------------------------
# Test: Main agent README exists
#------------------------------------------------------------------------------

log_info "Checking main agent README..."

assert_file_exists "$PLUGIN_ROOT/agents/README.md" "Main agent README exists"

#------------------------------------------------------------------------------
# Test: All agent categories have READMEs
#------------------------------------------------------------------------------

log_info "Checking category READMEs..."

assert_file_exists "$PLUGIN_ROOT/agents/codebase/README.md" "Codebase category README exists"
assert_file_exists "$PLUGIN_ROOT/agents/documentation/README.md" "Documentation category README exists"
assert_file_exists "$PLUGIN_ROOT/agents/web/README.md" "Web category README exists"
assert_file_exists "$PLUGIN_ROOT/agents/workflow/README.md" "Workflow category README exists"

#------------------------------------------------------------------------------
# Test: Expected agents exist
#------------------------------------------------------------------------------

log_info "Checking codebase agents..."

assert_file_exists "$PLUGIN_ROOT/agents/codebase/codebase-locator.md" "Codebase locator agent exists"
assert_file_exists "$PLUGIN_ROOT/agents/codebase/codebase-analyzer.md" "Codebase analyzer agent exists"
assert_file_exists "$PLUGIN_ROOT/agents/codebase/codebase-pattern-finder.md" "Codebase pattern finder exists"

log_info "Checking documentation agents..."

assert_file_exists "$PLUGIN_ROOT/agents/documentation/thoughts-locator.md" "Thoughts locator agent exists"
assert_file_exists "$PLUGIN_ROOT/agents/documentation/thoughts-analyzer.md" "Thoughts analyzer agent exists"

log_info "Checking web agents..."

assert_file_exists "$PLUGIN_ROOT/agents/web/web-search-researcher.md" "Web search researcher exists"

#------------------------------------------------------------------------------
# Test: Agent files are not empty
#------------------------------------------------------------------------------

log_info "Checking agent files are not empty..."

for agent_file in "$PLUGIN_ROOT"/agents/**/*.md; do
    # Skip README files
    if [[ "$(basename "$agent_file")" == "README.md" ]]; then
        continue
    fi

    if [[ -f "$agent_file" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))

        if [[ -s "$agent_file" ]]; then
            log_success "✓ Agent file not empty: $(basename "$agent_file")"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            log_error "✗ Agent file is empty: $(basename "$agent_file")"
            TESTS_FAILED=$((TESTS_FAILED + 1))
        fi
    fi
done

#------------------------------------------------------------------------------
# Test: Agent files have reasonable size
#------------------------------------------------------------------------------

log_info "Checking agent file sizes..."

for agent_file in "$PLUGIN_ROOT"/agents/**/*.md; do
    # Skip README files
    if [[ "$(basename "$agent_file")" == "README.md" ]]; then
        continue
    fi

    if [[ -f "$agent_file" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))

        # Agent files should be at least 500 bytes
        size=$(wc -c < "$agent_file")
        if [[ $size -gt 500 ]]; then
            log_success "✓ Agent file has content: $(basename "$agent_file") ($size bytes)"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            log_warning "⚠ Agent file seems small: $(basename "$agent_file") ($size bytes)"
            TESTS_PASSED=$((TESTS_PASSED + 1))  # Still pass, just warning
        fi
    fi
done

#------------------------------------------------------------------------------
# Test: Category READMEs describe progressive loading
#------------------------------------------------------------------------------

log_info "Checking category READMEs describe available agents..."

for category_readme in "$PLUGIN_ROOT"/agents/*/README.md; do
    if [[ -f "$category_readme" ]]; then
        category_name=$(basename "$(dirname "$category_readme")")

        TESTS_RUN=$((TESTS_RUN + 1))

        # Check if README is not too short (should describe agents)
        line_count=$(wc -l < "$category_readme")
        if [[ $line_count -gt 10 ]]; then
            log_success "✓ Category README has content: $category_name ($line_count lines)"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            log_warning "⚠ Category README seems short: $category_name ($line_count lines)"
            TESTS_PASSED=$((TESTS_PASSED + 1))  # Still pass
        fi
    fi
done

#------------------------------------------------------------------------------
# Test: No duplicate agent names
#------------------------------------------------------------------------------

log_info "Checking for duplicate agent names..."

TESTS_RUN=$((TESTS_RUN + 1))

# Find all agent files (excluding READMEs)
duplicates=$(find "$PLUGIN_ROOT/agents" -name "*.md" -type f ! -name "README.md" |
             xargs -n1 basename |
             sort |
             uniq -d)

if [[ -z "$duplicates" ]]; then
    log_success "✓ No duplicate agent names found"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Duplicate agent names found:"
    echo "$duplicates"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

#------------------------------------------------------------------------------
# Test: Agent directory structure is correct
#------------------------------------------------------------------------------

log_info "Checking agent directory structure..."

TESTS_RUN=$((TESTS_RUN + 1))

expected_categories=("codebase" "documentation" "web" "workflow")
missing_categories=()

for category in "${expected_categories[@]}"; do
    if [[ ! -d "$PLUGIN_ROOT/agents/$category" ]]; then
        missing_categories+=("$category")
    fi
done

if [[ ${#missing_categories[@]} -eq 0 ]]; then
    log_success "✓ All expected agent categories exist"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    log_error "✗ Missing agent categories: ${missing_categories[*]}"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

#------------------------------------------------------------------------------
# Report results
#------------------------------------------------------------------------------

report_test_results

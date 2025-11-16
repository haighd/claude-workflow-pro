#!/bin/bash
# Master test runner for Claude Workflow Pro

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source test helpers for colors
source "$SCRIPT_DIR/utils/helpers/test-helpers.sh"

echo ""
echo "=========================================="
echo "Claude Workflow Pro - Test Suite"
echo "=========================================="
echo ""

# Track overall results
TOTAL_TESTS=0
TOTAL_PASSED=0
TOTAL_FAILED=0

#------------------------------------------------------------------------------
# Run Command Validation Tests
#------------------------------------------------------------------------------

print_test_header "Command Validation Tests"

if [[ -x "$SCRIPT_DIR/commands/validate-all-commands.sh" ]]; then
    "$SCRIPT_DIR/commands/validate-all-commands.sh"
    command_result=$?

    # TODO: Parse output to get actual counts
    # For now, just track success/failure
    if [[ $command_result -eq 0 ]]; then
        log_success "Command validation passed"
    else
        log_error "Command validation failed"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
else
    log_warning "Command validation script not found or not executable"
fi

echo ""

#------------------------------------------------------------------------------
# Run Agent System Tests
#------------------------------------------------------------------------------

print_test_header "Agent System Validation Tests"

if [[ -x "$SCRIPT_DIR/agents/validate-agent-system.sh" ]]; then
    "$SCRIPT_DIR/agents/validate-agent-system.sh"
    agent_result=$?

    if [[ $agent_result -eq 0 ]]; then
        log_success "Agent validation passed"
    else
        log_error "Agent validation failed"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
else
    log_warning "Agent validation script not found or not executable"
fi

echo ""

#------------------------------------------------------------------------------
# Run Configuration Tests
#------------------------------------------------------------------------------

print_test_header "Configuration Tests"

log_info "Validating configuration schema..."

# Check if example config is valid JSON
if [[ -f "$PLUGIN_ROOT/.claude-plugin-config.example.json" ]]; then
    if jq . "$PLUGIN_ROOT/.claude-plugin-config.example.json" >/dev/null 2>&1; then
        log_success "✓ Example configuration is valid JSON"
    else
        log_error "✗ Example configuration is invalid JSON"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
else
    log_warning "⚠ Example configuration file not found"
fi

# Check if plugin manifest is valid JSON
if [[ -f "$PLUGIN_ROOT/.claude-plugin/plugin.json" ]]; then
    if jq . "$PLUGIN_ROOT/.claude-plugin/plugin.json" >/dev/null 2>&1; then
        log_success "✓ Plugin manifest is valid JSON"
    else
        log_error "✗ Plugin manifest is invalid JSON"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
else
    log_error "✗ Plugin manifest not found"
    TOTAL_FAILED=$((TOTAL_FAILED + 1))
fi

echo ""

#------------------------------------------------------------------------------
# Run Documentation Tests
#------------------------------------------------------------------------------

print_test_header "Documentation Tests"

log_info "Checking documentation files..."

required_docs=("README.md" "USAGE.md" "CONFIGURATION.md" "CHANGELOG.md" "LICENSE")

for doc in "${required_docs[@]}"; do
    if [[ -f "$PLUGIN_ROOT/$doc" ]]; then
        log_success "✓ $doc exists"
    else
        log_error "✗ $doc missing"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
done

echo ""

#------------------------------------------------------------------------------
# Run File Structure Tests
#------------------------------------------------------------------------------

print_test_header "File Structure Tests"

log_info "Validating plugin structure..."

required_dirs=(
    "commands"
    "commands/workflow"
    "commands/github"
    "commands/development"
    "commands/research"
    "agents"
    "agents/codebase"
    "agents/documentation"
    "agents/web"
    "agents/workflow"
    "tests"
    "docs"
    ".claude-plugin"
)

for dir in "${required_dirs[@]}"; do
    if [[ -d "$PLUGIN_ROOT/$dir" ]]; then
        log_success "✓ Directory exists: $dir"
    else
        log_error "✗ Directory missing: $dir"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
done

echo ""

#------------------------------------------------------------------------------
# Run Integration Tests
#------------------------------------------------------------------------------

print_test_header "Integration Tests"

# Workflow Integration Tests
if [[ -d "$SCRIPT_DIR/integration/workflows" ]]; then
    log_info "Running workflow integration tests..."
    for test_file in "$SCRIPT_DIR/integration/workflows"/test-*.sh; do
        if [[ -x "$test_file" ]]; then
            "$test_file"
            if [[ $? -eq 0 ]]; then
                log_success "✓ $(basename "$test_file") passed"
            else
                log_error "✗ $(basename "$test_file") failed"
                TOTAL_FAILED=$((TOTAL_FAILED + 1))
            fi
        fi
    done
fi

# Agent Integration Tests
if [[ -d "$SCRIPT_DIR/integration/agents" ]]; then
    log_info "Running agent integration tests..."
    for test_file in "$SCRIPT_DIR/integration/agents"/test-*.sh; do
        if [[ -x "$test_file" ]]; then
            "$test_file"
            if [[ $? -eq 0 ]]; then
                log_success "✓ $(basename "$test_file") passed"
            else
                log_error "✗ $(basename "$test_file") failed"
                TOTAL_FAILED=$((TOTAL_FAILED + 1))
            fi
        fi
    done
fi

# Example Validation Tests
if [[ -d "$SCRIPT_DIR/integration/examples" ]]; then
    log_info "Running example validation tests..."
    for test_file in "$SCRIPT_DIR/integration/examples"/test-*.sh; do
        if [[ -x "$test_file" ]]; then
            "$test_file"
            if [[ $? -eq 0 ]]; then
                log_success "✓ $(basename "$test_file") passed"
            else
                log_error "✗ $(basename "$test_file") failed"
                TOTAL_FAILED=$((TOTAL_FAILED + 1))
            fi
        fi
    done
fi

# GitHub Integration Tests
if [[ -d "$SCRIPT_DIR/integration/github" ]]; then
    log_info "Running GitHub integration tests..."
    for test_file in "$SCRIPT_DIR/integration/github"/test-*.sh; do
        if [[ -x "$test_file" ]]; then
            "$test_file"
            if [[ $? -eq 0 ]]; then
                log_success "✓ $(basename "$test_file") passed"
            else
                log_error "✗ $(basename "$test_file") failed"
                TOTAL_FAILED=$((TOTAL_FAILED + 1))
            fi
        fi
    done
fi

echo ""

#------------------------------------------------------------------------------
# Final Summary
#------------------------------------------------------------------------------

echo ""
echo "=========================================="
echo "Test Suite Complete"
echo "=========================================="
echo ""

if [[ $TOTAL_FAILED -eq 0 ]]; then
    log_success "All test suites passed! ✓"
    echo ""
    exit 0
else
    log_error "Some tests failed. Please review output above."
    echo ""
    exit 1
fi

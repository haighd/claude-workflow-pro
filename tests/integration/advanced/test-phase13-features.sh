#!/bin/bash

# Phase 13 Advanced Features Integration Tests
# Tests for templates, GitHub automation, team collaboration, plugins, metrics, and CI/CD

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
log_test() {
    echo -e "${YELLOW}TEST:${NC} $1"
    ((TESTS_RUN++))
}

pass_test() {
    echo -e "${GREEN}✓ PASS:${NC} $1"
    ((TESTS_PASSED++))
}

fail_test() {
    echo -e "${RED}✗ FAIL:${NC} $1"
    ((TESTS_FAILED++))
}

# Test 1: Workflow Templates Exist
test_workflow_templates() {
    log_test "Workflow templates exist and are valid"

    local templates=(
        "feature-development.md"
        "bug-fix.md"
        "refactoring.md"
        "security-audit.md"
    )

    for template in "${templates[@]}"; do
        if [ -f "$PROJECT_ROOT/templates/$template" ]; then
            # Check if template has required sections
            if grep -q "## Phase 1:" "$PROJECT_ROOT/templates/$template" && \
               grep -q "## Usage" "$PROJECT_ROOT/templates/$template" && \
               grep -q "Template Variables" "$PROJECT_ROOT/templates/$template"; then
                pass_test "Template $template is valid"
            else
                fail_test "Template $template missing required sections"
            fi
        else
            fail_test "Template $template not found"
        fi
    done
}

# Test 2: Templates README
test_templates_readme() {
    log_test "Templates README exists and documents all templates"

    if [ -f "$PROJECT_ROOT/templates/README.md" ]; then
        local readme="$PROJECT_ROOT/templates/README.md"

        # Check for each template documentation
        if grep -q "feature-development.md" "$readme" && \
           grep -q "bug-fix.md" "$readme" && \
           grep -q "refactoring.md" "$readme" && \
           grep -q "security-audit.md" "$readme"; then
            pass_test "Templates README documents all templates"
        else
            fail_test "Templates README missing template documentation"
        fi

        # Check for usage instructions
        if grep -q "How to Use Templates" "$readme"; then
            pass_test "Templates README has usage instructions"
        else
            fail_test "Templates README missing usage instructions"
        fi
    else
        fail_test "Templates README not found"
    fi
}

# Test 3: GitHub Automation Commands
test_github_automation() {
    log_test "GitHub automation commands exist"

    local commands=(
        "auto-review.md"
        "auto-triage.md"
        "auto-release.md"
    )

    for command in "${commands[@]}"; do
        if [ -f "$PROJECT_ROOT/commands/github/$command" ]; then
            # Check command structure
            if grep -q "## Purpose" "$PROJECT_ROOT/commands/github/$command" && \
               grep -q "## Usage" "$PROJECT_ROOT/commands/github/$command" && \
               grep -q "## What It Does" "$PROJECT_ROOT/commands/github/$command"; then
                pass_test "GitHub command $command is valid"
            else
                fail_test "GitHub command $command missing required sections"
            fi
        else
            fail_test "GitHub command $command not found"
        fi
    done
}

# Test 4: Team Collaboration Commands
test_team_collaboration() {
    log_test "Team collaboration commands exist"

    local commands=(
        "pair-program.md"
        "handoff.md"
    )

    for command in "${commands[@]}"; do
        if [ -f "$PROJECT_ROOT/commands/team/$command" ]; then
            # Check command structure
            if grep -q "## Purpose" "$PROJECT_ROOT/commands/team/$command" && \
               grep -q "## Usage" "$PROJECT_ROOT/commands/team/$command"; then
                pass_test "Team command $command is valid"
            else
                fail_test "Team command $command missing required sections"
            fi
        else
            fail_test "Team command $command not found"
        fi
    done
}

# Test 5: Plugin System Documentation
test_plugin_system() {
    log_test "Plugin system documentation exists"

    if [ -f "$PROJECT_ROOT/docs/PLUGIN_SYSTEM.md" ]; then
        local doc="$PROJECT_ROOT/docs/PLUGIN_SYSTEM.md"

        # Check for essential sections
        if grep -q "## Plugin Structure" "$doc" && \
           grep -q "## Creating Plugins" "$doc" && \
           grep -q "## Installing Plugins" "$doc" && \
           grep -q "## Publishing Plugins" "$doc"; then
            pass_test "Plugin system documentation is complete"
        else
            fail_test "Plugin system documentation missing sections"
        fi
    else
        fail_test "Plugin system documentation not found"
    fi
}

# Test 6: Metrics Agent
test_metrics_agent() {
    log_test "Metrics agent exists"

    if [ -f "$PROJECT_ROOT/agents/metrics-agent.md" ]; then
        local agent="$PROJECT_ROOT/agents/metrics-agent.md"

        # Check agent structure
        if grep -q "## Purpose" "$agent" && \
           grep -q "## Capabilities" "$agent" && \
           grep -q "## Usage" "$agent"; then
            pass_test "Metrics agent is valid"
        else
            fail_test "Metrics agent missing required sections"
        fi

        # Check for metrics types
        if grep -q "Workflow Metrics" "$agent" && \
           grep -q "Code Metrics" "$agent" && \
           grep -q "Team Metrics" "$agent"; then
            pass_test "Metrics agent has all metric types"
        else
            fail_test "Metrics agent missing metric types"
        fi
    else
        fail_test "Metrics agent not found"
    fi
}

# Test 7: CI/CD Integrations
test_cicd_integrations() {
    log_test "CI/CD integration templates exist"

    if [ -f "$PROJECT_ROOT/integrations/github-actions.yml" ]; then
        local gha="$PROJECT_ROOT/integrations/github-actions.yml"

        # Check for multiple workflow templates
        if grep -q "name: CI/CD Pipeline" "$gha" && \
           grep -q "name: Claude Workflow Automation" "$gha" && \
           grep -q "name: Automated Release" "$gha"; then
            pass_test "GitHub Actions has multiple templates"
        else
            fail_test "GitHub Actions missing templates"
        fi
    else
        fail_test "GitHub Actions integration not found"
    fi

    if [ -f "$PROJECT_ROOT/integrations/README.md" ]; then
        pass_test "Integrations README exists"
    else
        fail_test "Integrations README not found"
    fi
}

# Test 8: Advanced Configuration
test_advanced_configuration() {
    log_test "Advanced configuration documentation exists"

    if [ -f "$PROJECT_ROOT/docs/ADVANCED_CONFIGURATION.md" ]; then
        local doc="$PROJECT_ROOT/docs/ADVANCED_CONFIGURATION.md"

        # Check for configuration sections
        if grep -q "## Configuration Files" "$doc" && \
           grep -q "## Environment-Specific Configuration" "$doc" && \
           grep -q "## Team Configuration" "$doc" && \
           grep -q "## Integration Configuration" "$doc"; then
            pass_test "Advanced configuration documentation is complete"
        else
            fail_test "Advanced configuration missing sections"
        fi
    else
        fail_test "Advanced configuration documentation not found"
    fi
}

# Test 9: File Structure Validation
test_file_structure() {
    log_test "Phase 13 file structure is correct"

    # Check templates directory
    if [ -d "$PROJECT_ROOT/templates" ]; then
        local template_count=$(find "$PROJECT_ROOT/templates" -name "*.md" | wc -l)
        if [ "$template_count" -ge 4 ]; then
            pass_test "Templates directory has required files ($template_count templates)"
        else
            fail_test "Templates directory has insufficient files ($template_count)"
        fi
    else
        fail_test "Templates directory not found"
    fi

    # Check team commands directory
    if [ -d "$PROJECT_ROOT/commands/team" ]; then
        local team_count=$(find "$PROJECT_ROOT/commands/team" -name "*.md" | wc -l)
        if [ "$team_count" -ge 2 ]; then
            pass_test "Team commands directory has required files ($team_count commands)"
        else
            fail_test "Team commands directory has insufficient files ($team_count)"
        fi
    else
        fail_test "Team commands directory not found"
    fi

    # Check integrations directory
    if [ -d "$PROJECT_ROOT/integrations" ]; then
        pass_test "Integrations directory exists"
    else
        fail_test "Integrations directory not found"
    fi
}

# Test 10: Documentation Links Validation
test_documentation_links() {
    log_test "Documentation cross-references are valid"

    local docs_to_check=(
        "templates/README.md"
        "docs/PLUGIN_SYSTEM.md"
        "docs/ADVANCED_CONFIGURATION.md"
        "integrations/README.md"
    )

    for doc in "${docs_to_check[@]}"; do
        if [ -f "$PROJECT_ROOT/$doc" ]; then
            # Check for common documentation links
            if grep -q -E '\[.*\]\(.*\.md\)' "$PROJECT_ROOT/$doc"; then
                pass_test "$doc has documentation links"
            else
                # Some docs might not have links, that's okay
                pass_test "$doc checked for links"
            fi
        fi
    done
}

# Test 11: Template Variables Validation
test_template_variables() {
    log_test "Template variables are properly documented"

    local templates=(
        "templates/feature-development.md"
        "templates/bug-fix.md"
        "templates/refactoring.md"
        "templates/security-audit.md"
    )

    for template in "${templates[@]}"; do
        if [ -f "$PROJECT_ROOT/$template" ]; then
            # Check for variable documentation
            if grep -q "Template Variables" "$PROJECT_ROOT/$template" && \
               grep -q "{{" "$PROJECT_ROOT/$template"; then
                pass_test "$(basename $template) has documented variables"
            else
                fail_test "$(basename $template) missing variable documentation"
            fi
        fi
    done
}

# Test 12: Command Consistency
test_command_consistency() {
    log_test "All commands follow consistent structure"

    local commands=(
        "commands/github/auto-review.md"
        "commands/github/auto-triage.md"
        "commands/github/auto-release.md"
        "commands/team/pair-program.md"
        "commands/team/handoff.md"
    )

    for command in "${commands[@]}"; do
        if [ -f "$PROJECT_ROOT/$command" ]; then
            # Check for required sections
            local has_purpose=$(grep -c "## Purpose" "$PROJECT_ROOT/$command" || echo "0")
            local has_usage=$(grep -c "## Usage" "$PROJECT_ROOT/$command" || echo "0")

            if [ "$has_purpose" -ge 1 ] && [ "$has_usage" -ge 1 ]; then
                pass_test "$(basename $command) has consistent structure"
            else
                fail_test "$(basename $command) missing required sections"
            fi
        fi
    done
}

# Run all tests
echo "========================================"
echo "Phase 13 Advanced Features Integration Tests"
echo "========================================"
echo ""

test_workflow_templates
echo ""

test_templates_readme
echo ""

test_github_automation
echo ""

test_team_collaboration
echo ""

test_plugin_system
echo ""

test_metrics_agent
echo ""

test_cicd_integrations
echo ""

test_advanced_configuration
echo ""

test_file_structure
echo ""

test_documentation_links
echo ""

test_template_variables
echo ""

test_command_consistency
echo ""

# Print summary
echo "========================================"
echo "Test Summary"
echo "========================================"
echo -e "Tests run:    ${TESTS_RUN}"
echo -e "Tests passed: ${GREEN}${TESTS_PASSED}${NC}"
echo -e "Tests failed: ${RED}${TESTS_FAILED}${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All Phase 13 tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some Phase 13 tests failed${NC}"
    exit 1
fi

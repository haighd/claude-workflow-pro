#!/bin/bash
# Test helper functions for Claude Workflow Pro test suite

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test environment
TEST_ENV_DIR=""
KEEP_TEST_ENV=${KEEP_TEST_ENV:-0}
DEBUG=${DEBUG:-0}

#------------------------------------------------------------------------------
# Logging and Output
#------------------------------------------------------------------------------

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_debug() {
    if [[ "$DEBUG" == "1" ]]; then
        echo -e "${YELLOW}[DEBUG]${NC} $1"
    fi
}

#------------------------------------------------------------------------------
# Test Environment Setup/Teardown
#------------------------------------------------------------------------------

setup_test_environment() {
    log_info "Setting up test environment..."

    # Create temporary test directory
    TEST_ENV_DIR=$(mktemp -d /tmp/claude-workflow-test-XXXXXX)
    log_debug "Test environment: $TEST_ENV_DIR"

    # Change to test directory
    cd "$TEST_ENV_DIR" || exit 1

    log_success "Test environment ready: $TEST_ENV_DIR"
}

cleanup_test_environment() {
    if [[ "$KEEP_TEST_ENV" == "1" ]]; then
        log_warning "Keeping test environment: $TEST_ENV_DIR"
        return
    fi

    if [[ -n "$TEST_ENV_DIR" && -d "$TEST_ENV_DIR" ]]; then
        log_info "Cleaning up test environment..."
        rm -rf "$TEST_ENV_DIR"
        log_success "Test environment cleaned"
    fi
}

#------------------------------------------------------------------------------
# Project Setup
#------------------------------------------------------------------------------

create_test_project() {
    local project_type=${1:-"minimal"}

    log_info "Creating test project: $project_type"

    case "$project_type" in
        minimal)
            mkdir -p src tests
            echo "# Test Project" > README.md
            ;;
        standard)
            mkdir -p src tests docs docs/thoughts docs/sessions docs/implementation-plans
            echo "# Test Project" > README.md
            ;;
        monorepo)
            mkdir -p packages/frontend packages/backend docs tests
            echo "# Monorepo Test Project" > README.md
            ;;
        with-config)
            create_test_project "standard"
            create_test_config
            ;;
        *)
            log_error "Unknown project type: $project_type"
            return 1
            ;;
    esac

    log_success "Test project created: $project_type"
}

create_test_git_repo() {
    log_info "Initializing git repository..."

    git init -q
    git config user.name "Test User"
    git config user.email "test@example.com"
    git add .
    git commit -q -m "Initial commit"
    git branch -M main

    log_success "Git repository initialized"
}

create_test_config() {
    local config_type=${1:-"standard"}

    log_info "Creating test configuration: $config_type"

    case "$config_type" in
        minimal)
            cat > .claude-plugin-config.json <<EOF
{
  "directories": {
    "docs": "docs"
  }
}
EOF
            ;;
        standard)
            cat > .claude-plugin-config.json <<EOF
{
  "directories": {
    "docs": "docs",
    "thoughts": "docs/thoughts",
    "sessions": "docs/sessions",
    "plans": "docs/implementation-plans",
    "tests": "tests",
    "src": "src"
  },
  "github": {
    "issueLabels": ["bug", "feature", "enhancement"],
    "defaultBranch": "main"
  },
  "workflow": {
    "autoCheckpoint": true,
    "checkpointInterval": "30min"
  }
}
EOF
            ;;
        custom)
            cat > .claude-plugin-config.json <<EOF
{
  "directories": {
    "docs": "documentation",
    "thoughts": "documentation/notes",
    "sessions": "documentation/sessions",
    "plans": "documentation/plans",
    "tests": "__tests__",
    "src": "lib"
  }
}
EOF
            ;;
        *)
            log_error "Unknown config type: $config_type"
            return 1
            ;;
    esac

    log_success "Test configuration created: $config_type"
}

#------------------------------------------------------------------------------
# Assertions
#------------------------------------------------------------------------------

assert_file_exists() {
    local file=$1
    local message=${2:-"File should exist: $file"}

    TESTS_RUN=$((TESTS_RUN + 1))

    if [[ -f "$file" ]]; then
        log_success "✓ $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_directory_exists() {
    local dir=$1
    local message=${2:-"Directory should exist: $dir"}

    TESTS_RUN=$((TESTS_RUN + 1))

    if [[ -d "$dir" ]]; then
        log_success "✓ $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_file_contains() {
    local file=$1
    local text=$2
    local message=${3:-"File should contain '$text': $file"}

    TESTS_RUN=$((TESTS_RUN + 1))

    if [[ ! -f "$file" ]]; then
        log_error "✗ File not found: $file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi

    if grep -q "$text" "$file"; then
        log_success "✓ $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_command_succeeds() {
    local cmd=$1
    local message=${2:-"Command should succeed: $cmd"}

    TESTS_RUN=$((TESTS_RUN + 1))

    log_debug "Running: $cmd"

    if eval "$cmd" &>/dev/null; then
        log_success "✓ $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_command_fails() {
    local cmd=$1
    local message=${2:-"Command should fail: $cmd"}

    TESTS_RUN=$((TESTS_RUN + 1))

    log_debug "Running: $cmd"

    if ! eval "$cmd" &>/dev/null; then
        log_success "✓ $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_equals() {
    local expected=$1
    local actual=$2
    local message=${3:-"Values should be equal"}

    TESTS_RUN=$((TESTS_RUN + 1))

    if [[ "$expected" == "$actual" ]]; then
        log_success "✓ $message (expected=$expected, actual=$actual)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message (expected=$expected, actual=$actual)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_not_empty() {
    local value=$1
    local message=${2:-"Value should not be empty"}

    TESTS_RUN=$((TESTS_RUN + 1))

    if [[ -n "$value" ]]; then
        log_success "✓ $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ $message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

#------------------------------------------------------------------------------
# Command Testing
#------------------------------------------------------------------------------

test_command_exists() {
    local command_path=$1
    local plugin_root=${2:-"$HOME/.claude-plugins/claude-workflow-pro"}

    # Convert /category/command to commands/category/command.md
    local file_path=$(echo "$command_path" | sed 's|^/||' | sed 's|/|/|g')
    local full_path="$plugin_root/commands/${file_path}.md"

    assert_file_exists "$full_path" "Command file exists: $command_path"
}

test_command_has_frontmatter() {
    local command_file=$1

    TESTS_RUN=$((TESTS_RUN + 1))

    if head -1 "$command_file" | grep -q "^---$"; then
        log_success "✓ Command has frontmatter: $command_file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ Command missing frontmatter: $command_file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

#------------------------------------------------------------------------------
# Mock Utilities
#------------------------------------------------------------------------------

mock_github_issue() {
    local issue_number=$1
    local issue_type=${2:-"feature"}

    mkdir -p .mock/github/issues

    cat > ".mock/github/issues/${issue_number}.json" <<EOF
{
  "number": $issue_number,
  "title": "Test Issue $issue_number",
  "body": "This is a test issue for testing purposes.",
  "labels": ["$issue_type"],
  "state": "open"
}
EOF

    log_debug "Created mock issue: $issue_number"
}

mock_gh_command() {
    # Create a mock gh command for testing
    mkdir -p .mock/bin

    cat > .mock/bin/gh <<'EOF'
#!/bin/bash
# Mock gh command for testing

case "$1" in
    issue)
        case "$2" in
            view)
                issue_num=$3
                if [[ -f ".mock/github/issues/${issue_num}.json" ]]; then
                    cat ".mock/github/issues/${issue_num}.json"
                else
                    echo "Issue not found: $issue_num" >&2
                    exit 1
                fi
                ;;
            list)
                find .mock/github/issues -name "*.json" -exec cat {} \;
                ;;
        esac
        ;;
    repo)
        echo '{"owner":"test","name":"test-repo"}'
        ;;
esac
EOF

    chmod +x .mock/bin/gh
    export PATH=".mock/bin:$PATH"

    log_debug "Mock gh command created"
}

#------------------------------------------------------------------------------
# Workflow Testing
#------------------------------------------------------------------------------

run_workflow_step() {
    local command=$1

    log_info "Running workflow step: $command"
    # Note: In real usage, this would invoke Claude Code command
    # For testing, we simulate the expected behavior
}

validate_workflow_state() {
    log_info "Validating workflow state..."

    # Check basic workflow structure
    assert_directory_exists "docs"
    assert_directory_exists "docs/sessions"
    assert_directory_exists "docs/implementation-plans"
}

#------------------------------------------------------------------------------
# Reporting
#------------------------------------------------------------------------------

report_test_results() {
    echo ""
    echo "=========================================="
    echo "Test Results"
    echo "=========================================="
    echo -e "Tests run:    ${BLUE}$TESTS_RUN${NC}"
    echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
    echo "=========================================="

    if [[ $TESTS_FAILED -eq 0 ]]; then
        log_success "All tests passed!"
        return 0
    else
        log_error "$TESTS_FAILED test(s) failed"
        return 1
    fi
}

print_test_header() {
    local test_name=$1

    echo ""
    echo "=========================================="
    echo "$test_name"
    echo "=========================================="
}

#------------------------------------------------------------------------------
# Fixture Loading
#------------------------------------------------------------------------------

load_fixture() {
    local fixture_name=$1
    local plugin_root=${2:-"$(dirname "$0")/../../.."}
    local fixture_path="$plugin_root/tests/utils/fixtures/$fixture_name"

    if [[ ! -f "$fixture_path" && ! -d "$fixture_path" ]]; then
        log_error "Fixture not found: $fixture_name"
        return 1
    fi

    if [[ -d "$fixture_path" ]]; then
        cp -r "$fixture_path"/* .
    else
        cat "$fixture_path"
    fi

    log_debug "Loaded fixture: $fixture_name"
}

#------------------------------------------------------------------------------
# Utility Functions
#------------------------------------------------------------------------------

get_plugin_root() {
    # Try to find plugin root
    if [[ -n "$CLAUDE_WORKFLOW_PRO_ROOT" ]]; then
        echo "$CLAUDE_WORKFLOW_PRO_ROOT"
    elif [[ -d "$HOME/.claude-plugins/claude-workflow-pro" ]]; then
        echo "$HOME/.claude-plugins/claude-workflow-pro"
    else
        # Assume we're in the plugin directory
        local current_dir=$(pwd)
        while [[ "$current_dir" != "/" ]]; do
            if [[ -f "$current_dir/.claude-plugin/plugin.json" ]]; then
                echo "$current_dir"
                return
            fi
            current_dir=$(dirname "$current_dir")
        done

        log_error "Could not find plugin root"
        return 1
    fi
}

wait_for_file() {
    local file=$1
    local timeout=${2:-10}
    local elapsed=0

    while [[ ! -f "$file" && $elapsed -lt $timeout ]]; do
        sleep 1
        elapsed=$((elapsed + 1))
    done

    [[ -f "$file" ]]
}

#------------------------------------------------------------------------------
# Export functions for use in tests
#------------------------------------------------------------------------------

export -f log_info log_success log_warning log_error log_debug
export -f setup_test_environment cleanup_test_environment
export -f create_test_project create_test_git_repo create_test_config
export -f assert_file_exists assert_directory_exists assert_file_contains
export -f assert_command_succeeds assert_command_fails assert_equals assert_not_empty
export -f test_command_exists test_command_has_frontmatter
export -f mock_github_issue mock_gh_command
export -f run_workflow_step validate_workflow_state
export -f report_test_results print_test_header
export -f load_fixture get_plugin_root wait_for_file

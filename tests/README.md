# Test Suite for Claude Workflow Pro

Comprehensive testing infrastructure for the Claude Workflow Pro plugin.

## Overview

This test suite validates all plugin functionality including commands, agents, configuration, and workflows.

## Test Structure

```
tests/
├── README.md           # This file
├── commands/           # Command tests
│   ├── workflow/       # Workflow command tests
│   ├── github/         # GitHub command tests
│   ├── development/    # Development command tests
│   └── research/       # Research command tests
├── agents/             # Agent system tests
│   ├── codebase/       # Codebase agent tests
│   ├── documentation/  # Documentation agent tests
│   └── web/            # Web agent tests
├── integration/        # Integration tests
│   ├── workflows/      # End-to-end workflow tests
│   └── scenarios/      # Real-world scenario tests
└── utils/              # Test utilities and helpers
    ├── fixtures/       # Test fixtures and data
    ├── helpers/        # Test helper functions
    └── mocks/          # Mock implementations
```

## Test Categories

### 1. Command Tests (`tests/commands/`)

Tests for individual slash commands:

- **Workflow Commands**: `/workflow/init`, `/workflow/create-plan`, etc.
- **GitHub Commands**: `/github/start-from-issue`, `/github/create-issue`, etc.
- **Development Commands**: `/development/commit`, `/development/debug`, etc.
- **Research Commands**: `/research/research-codebase`

**What we test:**
- Command parsing and validation
- Configuration loading
- Directory auto-detection
- Error handling
- Output format

### 2. Agent Tests (`tests/agents/`)

Tests for the progressive agent system:

- **Agent Discovery**: Category README loading
- **Agent Loading**: Progressive loading mechanism
- **Result Filtering**: Max results and relevance
- **Context Reduction**: Verify 40-60% reduction

**What we test:**
- Agent discovery system
- Progressive loading
- Result filtering
- Context efficiency
- Error handling

### 3. Integration Tests (`tests/integration/`)

End-to-end workflow tests:

- **Complete Workflows**: Full workflow from init to checkpoint
- **GitHub Integration**: Issue → Plan → Implementation → PR
- **Research Workflows**: Research → Plan → Implementation
- **Resume Workflows**: Checkpoint → Resume → Continue

**What we test:**
- Multi-step workflows
- State persistence
- Error recovery
- Real-world scenarios

### 4. Test Utilities (`tests/utils/`)

Shared testing infrastructure:

- **Fixtures**: Sample projects, configs, git repos
- **Helpers**: Common test functions
- **Mocks**: Simulated GitHub, git, file system

## Running Tests

### Prerequisites

Since Claude Code commands run within Claude, traditional unit tests are limited. Instead, we use:

1. **Manual Test Scripts**: Bash scripts that exercise commands
2. **Validation Scripts**: Verify command outputs
3. **Integration Scenarios**: Real-world test cases

### Manual Testing

```bash
# Run all tests
./tests/run-all-tests.sh

# Run specific category
./tests/run-command-tests.sh
./tests/run-agent-tests.sh
./tests/run-integration-tests.sh

# Run specific test
./tests/commands/workflow/test-init.sh
```

### Validation

```bash
# Validate all commands exist and are loadable
./tests/validate-commands.sh

# Validate configuration system
./tests/validate-config.sh

# Validate agent system
./tests/validate-agents.sh
```

## Test Scenarios

### Scenario 1: New Feature Workflow

**Test**: Complete feature development from start to PR

```bash
./tests/integration/workflows/test-new-feature.sh
```

**Steps:**
1. `/workflow/init`
2. `/workflow/create-plan`
3. `/workflow/validate-plan`
4. `/workflow/implement-plan`
5. `/workflow/checkpoint`
6. `/development/commit`

**Expected:**
- All directories created
- Plan file generated
- Implementation tracked
- Checkpoint saved
- Commit created

### Scenario 2: GitHub Issue Workflow

**Test**: Start from issue, implement, create PR

```bash
./tests/integration/workflows/test-github-issue.sh
```

**Steps:**
1. `/github/start-from-issue 1`
2. Complete implementation
3. `/github/describe-pr`

**Expected:**
- Issue fetched correctly
- Plan created from issue
- Implementation completes
- PR description generated

### Scenario 3: Checkpoint & Resume

**Test**: Save state and resume work

```bash
./tests/integration/workflows/test-checkpoint-resume.sh
```

**Steps:**
1. `/workflow/init`
2. `/workflow/create-plan`
3. Start implementation
4. `/workflow/checkpoint`
5. `/workflow/resume-work <checkpoint>`

**Expected:**
- Checkpoint file created
- State saved correctly
- Resume restores context
- Work continues seamlessly

### Scenario 4: Configuration Loading

**Test**: Configuration precedence and auto-detection

```bash
./tests/utils/test-config-loading.sh
```

**Cases:**
1. No config (auto-detection)
2. Project config (`.claude-plugin-config.json`)
3. Legacy config (`.claude/config.json`)
4. Custom directories

**Expected:**
- Correct precedence order
- Auto-detection works
- Custom configs override
- Fallbacks work

### Scenario 5: Agent System

**Test**: Progressive agent loading and context reduction

```bash
./tests/agents/test-progressive-loading.sh
```

**Steps:**
1. Load category README
2. Select agent
3. Load agent prompt
4. Verify context usage

**Expected:**
- Category README loads first (small)
- Agent loads on demand
- Results filtered
- Context reduced by 40-60%

## Writing Tests

### Command Test Template

Create `tests/commands/<category>/test-<command>.sh`:

```bash
#!/bin/bash
# Test for /category/command

source "$(dirname "$0")/../../utils/helpers/test-helpers.sh"

# Setup
setup_test_environment
create_test_project

# Test
test_command_exists "/category/command"
test_command_runs "/category/command"
test_expected_output "/category/command" "expected output"

# Cleanup
cleanup_test_environment

# Report
report_test_results
```

### Integration Test Template

Create `tests/integration/workflows/test-<workflow>.sh`:

```bash
#!/bin/bash
# Integration test for <workflow>

source "$(dirname "$0")/../../utils/helpers/test-helpers.sh"

# Setup
setup_test_environment
create_test_git_repo

# Execute workflow
run_workflow_step "/workflow/init"
assert_directory_exists "docs/sessions"

run_workflow_step "/workflow/create-plan"
assert_file_exists "docs/implementation-plans/*.md"

# Validate
validate_workflow_state

# Cleanup
cleanup_test_environment

# Report
report_test_results
```

## Test Helpers

### Available Helpers

**Setup/Teardown:**
- `setup_test_environment` - Create isolated test env
- `cleanup_test_environment` - Remove test artifacts
- `create_test_project` - Generate sample project
- `create_test_git_repo` - Initialize git repository

**Assertions:**
- `assert_file_exists <path>` - File must exist
- `assert_directory_exists <path>` - Directory must exist
- `assert_contains <file> <text>` - File contains text
- `assert_command_succeeds <cmd>` - Command exits 0
- `assert_command_fails <cmd>` - Command exits non-zero

**Utilities:**
- `run_workflow_step <command>` - Execute command
- `validate_workflow_state` - Check state consistency
- `mock_github_issue <number>` - Create mock issue
- `mock_git_repo` - Create mock repository

## Test Fixtures

### Available Fixtures

**Projects:**
- `fixtures/projects/minimal` - Minimal project structure
- `fixtures/projects/standard` - Standard project
- `fixtures/projects/monorepo` - Monorepo example
- `fixtures/projects/with-config` - Has `.claude-plugin-config.json`

**Configs:**
- `fixtures/configs/minimal.json` - Minimal config
- `fixtures/configs/full.json` - Full config
- `fixtures/configs/custom-dirs.json` - Custom directories

**Plans:**
- `fixtures/plans/simple-feature.md` - Simple feature plan
- `fixtures/plans/complex-refactor.md` - Complex refactor
- `fixtures/plans/bug-fix.md` - Bug fix plan

**Issues:**
- `fixtures/github/issues/bug-001.json` - Bug issue
- `fixtures/github/issues/feature-001.json` - Feature issue
- `fixtures/github/issues/enhancement-001.json` - Enhancement

## Continuous Testing

### Pre-commit Hooks

Test critical functionality before commits:

```bash
# .git/hooks/pre-commit
./tests/validate-commands.sh
./tests/validate-config.sh
```

### GitHub Actions (Future)

When repository is public:

```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: ./tests/run-all-tests.sh
```

## Test Coverage Goals

**Phase 6 (Current):**
- [x] Test infrastructure setup
- [x] Test utilities and helpers
- [ ] Basic command tests
- [ ] Basic agent tests
- [ ] Test documentation

**Phase 8 (Integration Tests):**
- [ ] Complete workflow tests
- [ ] GitHub integration tests
- [ ] Configuration tests
- [ ] Error handling tests
- [ ] Edge case coverage

**Future:**
- [ ] Performance benchmarks
- [ ] Stress testing
- [ ] Compatibility testing
- [ ] Security testing

## Known Limitations

**Claude Code Environment:**
- Commands run within Claude, not as standalone scripts
- Testing requires Claude Code to be running
- Some tests must be manual/interactive

**Workarounds:**
1. Extract testable logic to separate scripts
2. Use manual test scenarios
3. Validate outputs rather than execution
4. Integration tests in real projects

## Contributing Tests

When adding features:

1. **Add command tests**: Create `tests/commands/<category>/test-<name>.sh`
2. **Add fixtures**: If needed, add to `tests/utils/fixtures/`
3. **Update integration tests**: Add scenarios to `tests/integration/`
4. **Document tests**: Update this README
5. **Run all tests**: Ensure nothing breaks

## Debugging Tests

### Verbose Mode

```bash
# Run tests with debug output
DEBUG=1 ./tests/run-all-tests.sh

# Run specific test with trace
set -x
./tests/commands/workflow/test-init.sh
```

### Test Isolation

```bash
# Keep test artifacts for inspection
KEEP_TEST_ENV=1 ./tests/run-all-tests.sh

# Inspect test environment
ls -la /tmp/claude-workflow-test-*
```

### Manual Verification

```bash
# Run command manually in test environment
cd /tmp/claude-workflow-test-12345
# Then use Claude Code to run commands
```

## Test Metrics

Track test health:

- **Coverage**: Which commands/agents are tested
- **Pass Rate**: Percentage of passing tests
- **Execution Time**: How long tests take
- **Flakiness**: Tests that intermittently fail

## Resources

- Test helpers: `tests/utils/helpers/`
- Test fixtures: `tests/utils/fixtures/`
- Example tests: `tests/commands/workflow/`
- Integration examples: `tests/integration/workflows/`

---

**Testing is critical for plugin reliability. All contributions should include tests!**

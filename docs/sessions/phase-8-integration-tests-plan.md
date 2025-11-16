# Phase 8: Integration Tests - Detailed Plan

**Created**: 2025-11-15
**Status**: Ready to implement
**Prerequisite**: Phase 7 (Examples) Complete ✅

## Overview

Create comprehensive integration tests that validate end-to-end workflows, GitHub integration, agent system functionality, and example projects. These tests will ensure all plugin components work together seamlessly.

## Current State Analysis

### What We Have ✅

1. **Test Infrastructure** (Phase 6):
   - `tests/README.md` (11.7 KB) - Comprehensive test documentation
   - `tests/run-all-tests.sh` - Master test runner
   - `tests/utils/helpers/test-helpers.sh` - Test utilities (10.2 KB)
   - `tests/commands/validate-all-commands.sh` - 46 tests ✓
   - `tests/agents/validate-agent-system.sh` - 29 tests ✓
   - `tests/utils/fixtures/` - 7 test fixtures

2. **Example Projects** (Phase 7):
   - `examples/basic-project/` - Minimal example (4 files)
   - `examples/web-app/` - Standard example (10 files)
   - `examples/api-service/` - Complete example (15 files)

3. **Current Test Coverage**:
   - ✅ Command syntax validation (46 tests)
   - ✅ Agent system validation (29 tests)
   - ✅ Configuration schema validation
   - ✅ Documentation presence checks
   - ✅ File structure validation
   - **Total: 75+ tests passing**

### What We Need ❌

1. **Integration Tests** - NOT YET CREATED:
   - `tests/integration/` directory exists but is **empty**
   - No end-to-end workflow tests
   - No GitHub integration tests
   - No agent execution tests
   - No example project validation tests

2. **Test Scenarios** - Outlined in README but not implemented:
   - Scenario 1: New Feature Workflow
   - Scenario 2: GitHub Issue Workflow
   - Scenario 3: Checkpoint & Resume
   - Scenario 4: Configuration Loading
   - Scenario 5: Agent System

## Phase 8 Objectives

Create 4 categories of integration tests:

1. **End-to-End Workflow Tests** - Test complete workflows
2. **GitHub Integration Tests** - Test GitHub commands and flows
3. **Agent System Integration Tests** - Test agent loading and execution
4. **Example Project Validation** - Ensure examples work correctly

## Detailed Implementation Plan

### Task 1: End-to-End Workflow Integration Tests

**Goal**: Validate complete workflows from initialization to completion

**Files to Create**:

```
tests/integration/workflows/
├── test-basic-workflow.sh          # Basic: init → plan → checkpoint
├── test-plan-validate-workflow.sh  # Plan creation and validation
├── test-checkpoint-resume.sh       # Save state and resume
└── README.md                       # Workflow test documentation
```

**Test Coverage**:

#### 1.1 Basic Workflow (`test-basic-workflow.sh`)
- Initialize workflow with `/workflow/init`
- Verify directory structure created
- Create plan with `/workflow/create-plan`
- Verify plan file exists
- Create checkpoint with `/workflow/checkpoint`
- Verify checkpoint saved
- **Expected**: All directories and files created correctly

#### 1.2 Plan Validation Workflow (`test-plan-validate-workflow.sh`)
- Create a sample plan file
- Validate with `/workflow/validate-plan`
- Check validation output
- Test with invalid plan
- Verify error handling
- **Expected**: Validation catches issues

#### 1.3 Checkpoint & Resume (`test-checkpoint-resume.sh`)
- Create checkpoint with state data
- Resume with `/workflow/resume-work`
- Verify state restored
- Continue workflow
- Create second checkpoint
- **Expected**: State persistence works

**Success Criteria**:
- ✅ All workflow commands execute successfully
- ✅ Directories and files created as expected
- ✅ State persists across sessions
- ✅ Error handling works correctly

---

### Task 2: GitHub Integration Tests

**Goal**: Validate GitHub-related commands and workflows

**Files to Create**:

```
tests/integration/github/
├── test-issue-workflow.sh          # Start from issue → plan
├── test-pr-workflow.sh             # Describe PR generation
├── test-task-management.sh         # Issue task tracking
└── README.md                       # GitHub test documentation
```

**Test Coverage**:

#### 2.1 Issue Workflow (`test-issue-workflow.sh`)
- Mock GitHub issue (use fixture)
- Run `/github/start-from-issue <number>`
- Verify plan created from issue
- Check issue details in plan
- **Expected**: Issue → Plan conversion works
- **Note**: Uses mocked data (no real API calls)

#### 2.2 PR Workflow (`test-pr-workflow.sh`)
- Create sample git commits
- Run `/github/describe-pr`
- Verify PR description generated
- Check description format
- **Expected**: PR description accurate

#### 2.3 Task Management (`test-task-management.sh`)
- Create mock issue with tasks
- Convert to plan with `/github/convert-issue-to-plan`
- Verify task extraction
- Check task format
- **Expected**: Tasks properly extracted

**Success Criteria**:
- ✅ GitHub commands parse fixtures correctly
- ✅ Issue → Plan conversion accurate
- ✅ PR descriptions well-formatted
- ✅ Task management works

**Important Notes**:
- Uses **mocked GitHub data** (fixtures)
- No real API calls (stays offline)
- Tests command logic, not API integration

---

### Task 3: Agent System Integration Tests

**Goal**: Validate agent discovery, loading, and execution

**Files to Create**:

```
tests/integration/agents/
├── test-agent-discovery.sh         # Agent discovery system
├── test-agent-loading.sh           # Progressive loading
├── test-agent-context.sh           # Context reduction
└── README.md                       # Agent test documentation
```

**Test Coverage**:

#### 3.1 Agent Discovery (`test-agent-discovery.sh`)
- Load category README files
- Verify all categories discovered
- Check category descriptions
- Test agent listing
- **Expected**: All agent categories found

#### 3.2 Agent Loading (`test-agent-loading.sh`)
- Request specific agent
- Verify progressive loading
- Check agent prompt loaded
- Test multiple agents
- **Expected**: On-demand loading works

#### 3.3 Context Reduction (`test-agent-context.sh`)
- Compare category README vs full agent
- Measure size difference
- Verify 40-60% reduction
- Test result filtering
- **Expected**: Context efficiently managed

**Success Criteria**:
- ✅ Agent discovery finds all agents
- ✅ Progressive loading reduces context
- ✅ Agents load correctly on demand
- ✅ Context reduction measurable

---

### Task 4: Example Project Validation

**Goal**: Ensure all example projects are valid and functional

**Files to Create**:

```
tests/integration/examples/
├── test-basic-project.sh           # Validate basic example
├── test-web-app.sh                 # Validate web app example
├── test-api-service.sh             # Validate API service example
└── README.md                       # Example test documentation
```

**Test Coverage**:

#### 4.1 Basic Project (`test-basic-project.sh`)
- Validate directory structure
- Check `.claude-plugin-config.json` valid
- Verify `package.json` valid
- Check source files exist
- Test workflow commands work
- **Expected**: Basic example fully functional

#### 4.2 Web App (`test-web-app.sh`)
- Validate all files present (10 files)
- Check config includes GitHub
- Verify hooks are executable
- Test `.claude/settings.json` valid
- Validate React dependencies
- **Expected**: Web app example complete

#### 4.3 API Service (`test-api-service.sh`)
- Validate all files present (15 files)
- Check comprehensive config
- Verify all hooks executable
- Test example plan/checkpoint valid
- Validate Express dependencies
- **Expected**: API service example production-ready

**Success Criteria**:
- ✅ All example configs valid JSON
- ✅ All hooks executable (chmod +x)
- ✅ All dependencies valid
- ✅ No broken links in READMEs
- ✅ Examples match documentation

---

## File Structure

After Phase 8, test structure will be:

```
tests/
├── README.md                                    # ✅ Exists (11.7 KB)
├── run-all-tests.sh                             # ✅ Exists - UPDATE to include integration
├── commands/                                    # ✅ Exists
│   ├── validate-all-commands.sh                 # ✅ Exists (46 tests)
│   └── ...
├── agents/                                      # ✅ Exists
│   ├── validate-agent-system.sh                 # ✅ Exists (29 tests)
│   └── ...
├── integration/                                 # ❌ Empty - CREATE TESTS
│   ├── workflows/                               # ❌ CREATE
│   │   ├── README.md                            # ❌ CREATE
│   │   ├── test-basic-workflow.sh               # ❌ CREATE
│   │   ├── test-plan-validate-workflow.sh       # ❌ CREATE
│   │   └── test-checkpoint-resume.sh            # ❌ CREATE
│   ├── github/                                  # ❌ CREATE
│   │   ├── README.md                            # ❌ CREATE
│   │   ├── test-issue-workflow.sh               # ❌ CREATE
│   │   ├── test-pr-workflow.sh                  # ❌ CREATE
│   │   └── test-task-management.sh              # ❌ CREATE
│   ├── agents/                                  # ❌ CREATE
│   │   ├── README.md                            # ❌ CREATE
│   │   ├── test-agent-discovery.sh              # ❌ CREATE
│   │   ├── test-agent-loading.sh                # ❌ CREATE
│   │   └── test-agent-context.sh                # ❌ CREATE
│   └── examples/                                # ❌ CREATE
│       ├── README.md                            # ❌ CREATE
│       ├── test-basic-project.sh                # ❌ CREATE
│       ├── test-web-app.sh                      # ❌ CREATE
│       └── test-api-service.sh                  # ❌ CREATE
└── utils/                                       # ✅ Exists
    ├── fixtures/                                # ✅ Exists
    └── helpers/                                 # ✅ Exists
        └── test-helpers.sh                      # ✅ Exists (10.2 KB)
```

**Total New Files**: 16 files
- 3 workflow tests + README
- 3 GitHub tests + README
- 3 agent tests + README
- 3 example tests + README

---

## Implementation Strategy

### Approach

1. **Iterative Development**:
   - Build one test category at a time
   - Test each script immediately
   - Fix issues before moving on

2. **Use Existing Infrastructure**:
   - Leverage `test-helpers.sh` functions
   - Use existing fixtures where possible
   - Follow established patterns

3. **Realistic Testing**:
   - Test with actual example projects
   - Use real command files
   - Mock only external services (GitHub API)

4. **Progressive Enhancement**:
   - Start with simple positive cases
   - Add edge cases
   - Add error handling tests
   - Add performance checks

### Order of Implementation

**Day 1: Workflow Tests** (Easiest, foundational)
1. Create `tests/integration/workflows/README.md`
2. Create `test-basic-workflow.sh`
3. Create `test-plan-validate-workflow.sh`
4. Create `test-checkpoint-resume.sh`
5. Test and validate

**Day 2: Example Validation** (Leverages existing examples)
1. Create `tests/integration/examples/README.md`
2. Create `test-basic-project.sh`
3. Create `test-web-app.sh`
4. Create `test-api-service.sh`
5. Test and validate

**Day 3: Agent Tests** (More complex)
1. Create `tests/integration/agents/README.md`
2. Create `test-agent-discovery.sh`
3. Create `test-agent-loading.sh`
4. Create `test-agent-context.sh`
5. Test and validate

**Day 4: GitHub Tests** (Requires mocking)
1. Create GitHub fixtures (if needed)
2. Create `tests/integration/github/README.md`
3. Create `test-issue-workflow.sh`
4. Create `test-pr-workflow.sh`
5. Create `test-task-management.sh`
6. Test and validate

---

## Testing Strategy

### How to Test Integration Tests

Since these are **bash scripts that validate behavior**, we test by:

1. **Running the test scripts**:
   ```bash
   ./tests/integration/workflows/test-basic-workflow.sh
   ```

2. **Checking exit codes**:
   - Exit 0 = All tests passed
   - Exit 1 = Some tests failed

3. **Reviewing output**:
   - Uses colors (green ✓, red ✗, yellow ⚠)
   - Shows what was tested
   - Reports failures clearly

4. **Manual verification**:
   - Inspect created files
   - Check directory structure
   - Validate command outputs

### Test Execution Flow

```
Run test script
  ↓
Setup test environment (tmp directory)
  ↓
Execute commands/workflows
  ↓
Validate outputs/results
  ↓
Cleanup test environment
  ↓
Report results (pass/fail)
```

---

## Success Metrics

### Phase 8 Complete When:

1. **All Test Files Created**: 16 new test files
2. **All Tests Pass**: 100% pass rate
3. **Master Runner Updated**: `run-all-tests.sh` includes integration tests
4. **Documentation Updated**: All READMEs complete
5. **Examples Validated**: All 3 examples pass validation

### Test Count Goals

**Current**: 75+ tests (commands + agents + config)
**After Phase 8**: 100+ tests total

**New Tests**:
- Workflow tests: ~15 tests
- GitHub tests: ~10 tests
- Agent tests: ~10 tests
- Example tests: ~15 tests
- **Total new**: ~50 tests

### Quality Standards

Each test must:
- ✅ Use test-helpers.sh functions
- ✅ Clean up after itself
- ✅ Report clear pass/fail
- ✅ Include error handling
- ✅ Be documented in README

---

## Risks and Mitigations

### Risk 1: Test Environment Setup
**Issue**: Tests might interfere with real workspace
**Mitigation**: Use `/tmp/` for all test artifacts, strict cleanup

### Risk 2: Command Execution
**Issue**: Commands run in Claude, not standalone
**Mitigation**: Test command **outputs** and **file creation**, not execution

### Risk 3: GitHub API Mocking
**Issue**: Can't actually call GitHub API
**Mitigation**: Use fixtures, test command logic only

### Risk 4: Test Flakiness
**Issue**: Tests might intermittently fail
**Mitigation**: Use deterministic fixtures, avoid timing issues

### Risk 5: Example Validity
**Issue**: Examples might have broken configs
**Mitigation**: JSON validation, schema checks, manual review

---

## Dependencies

### Required Tools (Already Available)
- ✅ bash (for test scripts)
- ✅ jq (for JSON validation)
- ✅ git (for workflow tests)
- ✅ Test helpers (test-helpers.sh)

### Required Fixtures (Mostly Available)
- ✅ configs (7 existing fixtures)
- ✅ plans (in fixtures/)
- ⚠️ GitHub issues (may need more)
- ✅ Example projects (3 complete)

### Required Documentation
- ✅ tests/README.md (overview)
- ❌ Integration test READMEs (need to create)

---

## Future Enhancements (Post-Phase 8)

**Not in scope for Phase 8, but noted for future**:

1. **Performance Testing**:
   - Measure command execution time
   - Track context usage
   - Benchmark agent loading

2. **Stress Testing**:
   - Large projects
   - Many agents
   - Deep directory structures

3. **Compatibility Testing**:
   - Different OS (macOS, Linux)
   - Different shells (bash, zsh)
   - Different git versions

4. **CI/CD Integration**:
   - GitHub Actions workflow
   - Automated test runs
   - Coverage reporting

---

## Deliverables

### Files to Create (16 total)

**Workflows** (4 files):
1. `tests/integration/workflows/README.md`
2. `tests/integration/workflows/test-basic-workflow.sh`
3. `tests/integration/workflows/test-plan-validate-workflow.sh`
4. `tests/integration/workflows/test-checkpoint-resume.sh`

**GitHub** (4 files):
5. `tests/integration/github/README.md`
6. `tests/integration/github/test-issue-workflow.sh`
7. `tests/integration/github/test-pr-workflow.sh`
8. `tests/integration/github/test-task-management.sh`

**Agents** (4 files):
9. `tests/integration/agents/README.md`
10. `tests/integration/agents/test-agent-discovery.sh`
11. `tests/integration/agents/test-agent-loading.sh`
12. `tests/integration/agents/test-agent-context.sh`

**Examples** (4 files):
13. `tests/integration/examples/README.md`
14. `tests/integration/examples/test-basic-project.sh`
15. `tests/integration/examples/test-web-app.sh`
16. `tests/integration/examples/test-api-service.sh`

### Files to Update (1 file)

1. `tests/run-all-tests.sh` - Add integration test execution

### Documentation to Create

- 4 README files (one per integration category)
- Each README explains tests in that category

---

## Timeline Estimate

**Conservative Estimate**: 4-6 hours

- Workflow tests: 1-1.5 hours
- Example validation: 1-1.5 hours
- Agent tests: 1-1.5 hours
- GitHub tests: 1-1.5 hours
- Testing and fixes: 1 hour

**Aggressive Estimate**: 2-3 hours
- If everything goes smoothly
- Minimal debugging needed

**Realistic**: Plan for 4 hours of focused work

---

## Review Criteria

Before marking Phase 8 complete:

### Code Quality
- [ ] All scripts executable (chmod +x)
- [ ] All scripts use test-helpers.sh
- [ ] All scripts have proper error handling
- [ ] All scripts clean up after themselves

### Test Coverage
- [ ] Workflows tested end-to-end
- [ ] GitHub commands validated
- [ ] Agent system tested
- [ ] All examples validated

### Documentation
- [ ] All READMEs complete
- [ ] Tests clearly explained
- [ ] Examples documented
- [ ] Master README updated

### Execution
- [ ] All tests run successfully
- [ ] `run-all-tests.sh` executes all tests
- [ ] Pass rate 100%
- [ ] No false positives

### Integration
- [ ] Tests work with real example projects
- [ ] Tests use real command files
- [ ] Tests create realistic scenarios
- [ ] Tests validate actual behavior

---

## Next Steps After Phase 8

Once Phase 8 is complete, we move to:

**Phase 9: Polish & Refinement** (5 tasks)
- Code cleanup
- Documentation polish
- Configuration optimization
- Performance improvements
- User experience enhancements

---

## Notes

### Key Design Decisions

1. **Use Bash for Tests**: Simple, portable, integrates well with command structure
2. **Mock External Services**: No real API calls, all tests offline
3. **Test Real Examples**: Use actual example projects for realistic validation
4. **Progressive Loading**: Test agent discovery system thoroughly
5. **Clear Reporting**: Use colors and clear pass/fail indicators

### Important Considerations

- Tests must work **offline** (no GitHub API)
- Tests must be **deterministic** (same result every time)
- Tests must **clean up** (no artifacts left behind)
- Tests must **report clearly** (easy to see what failed)
- Tests must be **fast** (seconds, not minutes)

---

**Plan Status**: Ready to implement ✅
**Next Action**: Begin implementation with Task 1 (Workflow Tests)
**Estimated Completion**: End of Phase 8

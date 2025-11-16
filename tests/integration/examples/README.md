# Example Project Validation Tests

Tests to validate all example projects are complete, functional, and match documentation.

## Overview

These tests ensure the three example projects (basic-project, web-app, api-service) are valid references for users. They validate configurations, file structure, dependencies, and documentation.

## Test Files

### test-basic-project.sh

Validates the basic-project example

**What it tests:**
- Directory structure complete
- `.claude-plugin-config.json` valid
- `package.json` valid
- Source files exist
- README documentation accurate

**Success criteria:**
- All 4 required files present
- JSON configs valid
- No broken file references
- Minimal setup as documented

### test-web-app.sh

Validates the web-app example

**What it tests:**
- All 10 files present
- GitHub integration configured
- Hooks are executable
- Settings.json valid
- React dependencies correct

**Success criteria:**
- All files present and valid
- Hooks have execute permission
- Configurations complete
- README matches actual setup

### test-api-service.sh

Validates the api-service example

**What it tests:**
- All 15 files present
- Full configuration enabled
- All hooks executable
- Example plan/checkpoint valid
- Express dependencies correct

**Success criteria:**
- Complete file set present
- All configs valid
- Hooks executable
- Production-ready structure
- Documentation comprehensive

## Running Tests

Run all example validation tests:
```bash
./tests/integration/examples/test-basic-project.sh
./tests/integration/examples/test-web-app.sh
./tests/integration/examples/test-api-service.sh
```

Or use the master runner:
```bash
./tests/run-all-tests.sh
```

## Test Scope

Each test validates:

1. **File Presence**: All documented files exist
2. **JSON Validity**: Configs parse correctly
3. **Permissions**: Scripts/hooks executable
4. **Dependencies**: package.json has valid dependencies
5. **Documentation**: READMEs accurate and complete

## Why These Tests Matter

Example projects are critical for user onboarding:
- First impression of the plugin
- Learning resources
- Copy-paste starting points
- Best practice demonstrations

Invalid examples = frustrated users!

## Common Issues

**Issue**: JSON parse errors
- **Cause**: Invalid JSON syntax in configs
- **Fix**: Validate with jq

**Issue**: Missing executable permissions
- **Cause**: Hooks not chmod +x
- **Fix**: chmod +x .claude/hooks/*

**Issue**: File count mismatch
- **Cause**: Files not matching documentation
- **Fix**: Update example or docs

## Dependencies

- bash
- jq (for JSON validation)
- find (for file counting)
- test-helpers.sh (utility functions)

## Notes

These tests validate the **structure and validity** of examples, not their runtime functionality. We don't actually run npm install or execute code.

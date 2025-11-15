# Task Context - Claude Workflow Plugin

**Created**: 2025-11-15
**Related Plan**: docs/implementation-plans/2025-11-15-claude-workflow-plugin.md
**Related Issue**: N/A

## Overview

Create a generalized, reusable Claude Code plugin from the Golden Paws Photography `.claude/` workflow system, distributable via the Claude Code plugin marketplace. This plugin will provide comprehensive development workflow automation including TDD, debugging, git workflows, research-to-implementation pipelines, and context management tools.

## Key Files

### Core Implementation Files

(To be created in new repository - tracked here for reference)

- `claude-workflow-pro/.claude-plugin/plugin.json` - Plugin manifest
- `claude-workflow-pro/.claude-plugin/marketplace.json` - Marketplace catalog
- `claude-workflow-pro/hooks/hooks.json` - Hook configuration

### Source Files to Generalize

- `.claude/commands/*.md` - 33 command files to generalize
- `.claude/agents/**/*.md` - 10 agent files to copy/adapt
- `.claude/references/*.md` - 7 reference docs to migrate
- `.claude/hooks/*.js` - 4 hook files to migrate/port
- `.claude/templates/*.md` - 2 template files to copy
- `.claude/scripts/*.sh` - 2 script files to generalize

### Documentation Files to Create

- `claude-workflow-pro/README.md` - Main plugin README
- `claude-workflow-pro/docs/SETUP.md` - Setup guide
- `claude-workflow-pro/docs/MIGRATION.md` - Migration guide
- `claude-workflow-pro/docs/ARCHITECTURE.md` - System design
- `claude-workflow-pro/docs/COMMANDS.md` - Command reference
- `claude-workflow-pro/docs/CONFIGURATION.md` - Config options
- `claude-workflow-pro/docs/EXAMPLES.md` - Usage examples
- `claude-workflow-pro/CHANGELOG.md` - Version history

## Key Decisions

### Decision 1: Plugin Marketplace Distribution

- **What**: Use Claude Code's plugin marketplace as primary distribution method
- **Why**: Official distribution channel, easy installation (`/plugin install`), built-in versioning, update mechanism
- **Alternatives considered**: NPM package, standalone git repository, manual copying
- **Date**: 2025-11-15

### Decision 2: Multi-Runtime Hook Support

- **What**: Provide hooks in Node.js, Python, and Bash
- **Why**: Maximizes compatibility across different development environments; not all users have Node.js installed
- **Alternatives considered**: Node.js only, Python only, or configuration-based selection
- **Date**: 2025-11-15

### Decision 3: Dual Distribution Strategy

- **What**: Provide both marketplace plugin and standalone "starter kit" repository
- **Why**: Marketplace is ideal for most users, but starter kit allows full customization and fallback for edge cases
- **Alternatives considered**: Marketplace only, starter kit only
- **Date**: 2025-11-15

### Decision 4: Configuration via JSON File

- **What**: Use `.claude-plugin-config.json` for user customization with JSON schema validation
- **Why**: Persistent settings, version controllable, simpler than command-line flags, familiar pattern for developers
- **Alternatives considered**: Environment variables, command flags, interactive wizard
- **Date**: 2025-11-15

### Decision 5: Separate Repository Approach

- **What**: Create new repository `claude-workflow-pro` rather than in-place generalization
- **Why**: Keeps Golden Paws project clean, allows independent versioning, follows plugin distribution conventions, enables marketplace submission
- **Alternatives considered**: Generalize in-place, create branch in current repo
- **Date**: 2025-11-15

## Patterns to Follow

### Pattern 1: Path Detection with Config Override

- **Where**: All commands that work with file paths (create-plan, implement-plan, etc.)
- **Example**: `.claude/commands/start-from-issue.md` lines 30-59
- **Why**: Consistent path resolution across all commands, respects user config, provides sensible defaults
- **Implementation**:
  ```bash
  # Check for config first, then auto-detect, then use default
  if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
    PLANS_PATH=$(jq -r '.paths.plans // "docs/implementation-plans"' .claude-plugin-config.json)
  else
    # Auto-detect or use default
  fi
  ```

### Pattern 2: Progressive Agent Loading

- **Where**: `.claude/agents/README.md`
- **Example**: Category-based agent organization with on-demand loading
- **Why**: Reduces context usage by loading only needed agents, keeps initial footprint small
- **Implementation**: Organize agents by category, document when to use each category, load README first then specific agents

### Pattern 3: Graceful Degradation for Optional Dependencies

- **Where**: GitHub integration commands
- **Example**: Commands detect `gh` CLI availability and provide helpful errors if missing
- **Why**: Plugin works in more environments, clear error messages guide users to solutions
- **Implementation**:
  ```bash
  if ! command -v gh > /dev/null 2>&1; then
    echo "GitHub CLI (gh) is required for this command. Install: https://cli.github.com"
    exit 1
  fi
  ```

### Pattern 4: Template Variable Substitution

- **Where**: All documentation and command files
- **Example**: Use `${PROJECT_NAME}`, `${BASE_BRANCH}`, `${PLANS_PATH}` instead of hardcoded values
- **Why**: Enables generalization while maintaining readability, easy to document and customize
- **Implementation**: Define standard template variables in documentation, use consistently across all files

### Pattern 5: Hook Runtime Detection

- **Where**: `hooks/hooks.json`
- **Example**: Conditional hook execution based on runtime availability
- **Why**: Hooks work in multiple environments, users aren't forced to install specific runtime
- **Implementation**: Use matchers in hooks.json to detect runtime, fallback gracefully if preferred runtime unavailable

## Failed Approaches

(To be documented as implementation progresses)

## Dependencies

### External Dependencies

- **Claude Code** - Plugin system must be available (current stable version)
- **Git** - Required for GitHub integration commands (optional for non-GitHub workflows)
- **GitHub CLI (gh)** - Required for GitHub commands (optional, commands degrade gracefully)
- **Node.js** (14+) - Required for Node.js hooks (optional if using Python/Bash)
- **Python** (3.7+) - Required for Python hooks (optional if using Node.js/Bash)
- **jq** - Required for JSON config parsing in bash scripts

### Internal Dependencies

- Phase 9 (Configuration System) must complete before Phase 7 (Hook Alternatives) to enable config-based activation
- Phase 1 (Repository Setup) is prerequisite for all phases
- Phases 2-6 (Content Migration) should complete before Phase 13 (Testing)
- Phase 10 (Documentation) should complete before Phase 14 (Release)

### Blockers

- [ ] None currently identified

## Testing Strategy

### Unit Tests

Not applicable - this is primarily documentation and configuration files. Validation is done through:
- JSON schema validation for config files
- Link checking for documentation
- Syntax validation for scripts

### Integration Tests

- **Installation Testing**: Test marketplace installation and manual installation
- **Command Testing**: Test each command works in isolation and in workflow sequences
- **Hook Testing**: Verify hooks activate correctly in Node.js, Python, and Bash environments
- **Agent Testing**: Verify progressive loading and result filtering
- **Configuration Testing**: Test default config, custom config, invalid config scenarios

### E2E Tests

- **Full Workflow Tests**:
  - Install plugin → configure → run `/create-plan` → run `/implement-plan`
  - Install plugin → run `/start-from-issue` workflow
  - Test in clean environment (no existing .claude directory)
  - Test with existing .claude directory (migration scenario)

### Manual Testing

- [ ] Install via marketplace on macOS
- [ ] Install via marketplace on Linux
- [ ] Manual installation via starter kit
- [ ] Test all 30+ commands
- [ ] Test hooks in each runtime (Node.js, Python, Bash)
- [ ] Test with GitHub integration
- [ ] Test without GitHub (graceful degradation)
- [ ] Test configuration overrides
- [ ] Test invalid configuration error messages
- [ ] Verify all documentation examples work
- [ ] Check all documentation links

## Notes

### Generalization Strategy

When generalizing files, follow this checklist:
1. ✅ Remove all "Golden Paws" references
2. ✅ Remove all "PR #7" references
3. ✅ Replace `feature/booking-flow` with `${BASE_BRANCH}`
4. ✅ Replace hardcoded paths with config variables
5. ✅ Replace project-specific examples with generic ones
6. ✅ Update skill activation keywords to be configurable
7. ✅ Remove founder-mode or make it optional example
8. ✅ Verify no hardcoded repository/organization names remain

### File Organization

**New Repository Structure**:
```text
claude-workflow-pro/
├── .claude-plugin/         # Plugin metadata
├── commands/               # 30+ commands (organized by category)
├── agents/                 # 10 agents (organized by type)
├── skills/                 # Example skills
├── hooks/                  # Multi-runtime hooks
├── scripts/                # Utility scripts
├── templates/              # Task tracking templates
├── references/             # Best practices docs
└── docs/                   # Plugin documentation
```

**Golden Paws Source**:
- Current implementation in `.claude/` directory
- Use as reference during migration
- Keep intact (don't modify during plugin creation)

### Questions to Resolve

- [ ] What's the final plugin name? (`claude-workflow-pro` is working title)
- [ ] Which GitHub organization will host the plugin?
- [ ] Which GitHub organization will host the marketplace (if separate)?
- [ ] Should we create public marketplace or submit to community marketplace?
- [ ] What license? (MIT recommended, but confirm)

### Gotchas

- **Hook order matters**: UserPromptSubmit hooks run in order defined in hooks.json
- **Path detection**: Must work in projects without config file (auto-detect)
- **Config validation**: Invalid config should fail fast with helpful error
- **Marketplace caching**: Plugin updates may require cache clear
- **Runtime detection**: Hook runtime detection must be reliable across platforms
- **Documentation links**: Use relative links within docs, absolute for external

## Links

- Plan: docs/implementation-plans/2025-11-15-claude-workflow-plugin.md
- Tasks: docs/implementation-plans/2025-11-15-claude-workflow-plugin-tasks.md
- Current .claude implementation: `.claude/` directory
- Claude Code Plugin Docs: https://code.claude.com/docs/en/plugins.md
- Plugin Marketplace Docs: https://code.claude.com/docs/en/plugin-marketplaces.md
- Plugin Reference: https://code.claude.com/docs/en/plugins-reference.md

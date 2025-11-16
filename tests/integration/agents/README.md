# Agent System Integration Tests

Tests for agent discovery, progressive loading, and context management.

## Test Files

- `test-agent-discovery.sh` - Validates agent category discovery
- `test-agent-loading.sh` - Tests progressive loading mechanism
- `test-agent-context.sh` - Verifies context reduction

## What We Test

- Agent category READMEs load correctly
- Individual agents load on demand
- Context usage is reduced vs loading all agents
- Result filtering works

## Running Tests

```bash
./tests/integration/agents/test-agent-discovery.sh
./tests/integration/agents/test-agent-loading.sh
./tests/integration/agents/test-agent-context.sh
```

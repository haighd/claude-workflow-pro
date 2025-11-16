# Workflow Orchestration Agents

## Available Agents

_Workflow agents will be added here as we extract them from existing commands for better modularity._

## Planned Agents

### `research-orchestrator.md` - Multi-Agent Research Coordination

**Purpose:** Coordinate parallel research across multiple specialized agents
**Best for:** Complex investigation requiring multiple perspectives

### `plan-creator.md` - Implementation Plan Generation

**Purpose:** Create structured, phased implementation plans
**Best for:** Breaking down complex features into manageable steps

### `implementation-executor.md` - Plan Execution Management

**Purpose:** Execute implementation plans with progress tracking
**Best for:** Systematic feature implementation

## Usage Guidelines

Workflow agents coordinate other agents and should:

1. Discover needed capabilities dynamically
2. Load agents on-demand
3. Filter and aggregate results efficiently
4. Maintain progress state

## Efficiency Tips

- Use progressive discovery for sub-agents
- Implement result filtering at each stage
- Checkpoint progress for large workflows

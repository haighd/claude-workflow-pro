---
name: Agent Discovery System
description: Progressive loading of specialized agents by category to optimize context usage.
---

# Agent Discovery System
## Progressive Agent Loading

This directory contains specialized agents organized by category for on-demand discovery and loading. Instead of loading all agent definitions upfront, explore categories based on task requirements to reduce context usage.

## Agent Categories

### 📁 `codebase/` - Code Analysis & Search

Agents for exploring, analyzing, and understanding codebases.

**Use when:**

- Finding specific files, functions, or patterns
- Analyzing code structure and relationships
- Understanding implementation details
- Locating usage examples

**Available agents:**

- `locator` - Find files and components quickly
- `analyzer` - Deep analysis of code structure
- `pattern-finder` - Identify patterns and anti-patterns

### 📁 `documentation/` - Documentation & Thoughts Analysis

Agents for exploring documentation, comments, and architectural thoughts.

**Use when:**

- Finding architectural decisions
- Exploring development thoughts and rationale
- Analyzing documentation structure
- Understanding design choices

**Available agents:**

- `thoughts-locator` - Find specific thoughts/decisions
- `thoughts-analyzer` - Analyze and synthesize documentation

### 📁 `workflow/` - Workflow Orchestration

Agents for managing complex multi-step workflows.

**Use when:**

- Orchestrating research tasks
- Creating implementation plans
- Managing development workflows
- Coordinating multi-agent operations

**Available agents:**

- (To be added based on workflow patterns)

### 📁 `web/` - Web Research & External Resources

Agents for searching and analyzing external resources.

**Use when:**

- Researching external libraries or frameworks
- Finding documentation online
- Gathering best practices
- Exploring similar implementations

**Available agents:**

- `web-search-researcher` - Search and analyze web resources

## Usage Pattern

1. **Identify task requirements** - What type of analysis is needed?
2. **Explore relevant category** - Load only the category README
3. **Load specific agent** - Load individual agent definition when needed
4. **Execute with filtering** - Agents return limited, structured results

## Result Filtering Guidelines

All agents follow these filtering principles:

- Return maximum 10 most relevant results by default
- Provide structured summaries, not raw data dumps
- Include relevance scores when applicable
- Support on-demand detailed exploration

## Context Efficiency

This progressive discovery system reduces initial context load by:

- **40-60%** for complex workflows
- **30-50%** for research operations
- **20-30%** for simple tasks

Instead of loading ~50KB of agent definitions upfront, load only the 2-5KB needed for specific tasks.

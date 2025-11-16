# Codebase Analysis Agents

## Available Agents

### `locator.md` - File & Component Discovery

**Purpose:** Quickly find files, functions, classes, and components
**Best for:** Initial exploration, finding entry points, locating implementations

**Capabilities:**

- Pattern matching across file names and paths
- Finding specific function/class definitions
- Locating imports and dependencies
- Identifying test files for components

**Result limits:** Returns top 10 most relevant files by default
**Output format:** Structured list with relevance scores

---

### `analyzer.md` - Deep Code Analysis

**Purpose:** Analyze code structure, relationships, and implementation details
**Best for:** Understanding complex logic, data flow, architectural patterns

**Capabilities:**

- Analyzing function call chains
- Understanding data transformations
- Identifying side effects
- Mapping component relationships

**Result limits:** Returns structured summary with key insights
**Output format:** Hierarchical analysis with code snippets

---

### `pattern-finder.md` - Pattern Recognition

**Purpose:** Identify coding patterns, anti-patterns, and consistency issues
**Best for:** Code quality assessment, refactoring opportunities, best practices

**Capabilities:**

- Detecting repeated code patterns
- Finding anti-patterns and code smells
- Identifying optimization opportunities
- Checking consistency across codebase

**Result limits:** Returns top 5 most significant patterns
**Output format:** Pattern description with examples and impact assessment

## Usage Guidelines

1. Start with `locator` to find relevant files
2. Use `analyzer` for deep-dive into specific components
3. Apply `pattern-finder` for quality and consistency checks

## Efficiency Tips

- Specify search scope to reduce processing time
- Request summaries first, details only when needed
- Chain agents sequentially based on findings

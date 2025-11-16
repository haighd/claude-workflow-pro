# Documentation Analysis Agents

## Available Agents

### `thoughts-locator.md` - Documentation Discovery

**Purpose:** Find specific architectural decisions, design thoughts, and documentation
**Best for:** Understanding why decisions were made, finding design documentation

**Capabilities:**

- Searching through documentation directories
- Finding specific decision records
- Locating design rationale
- Identifying architectural constraints

**Result limits:** Returns top 10 most relevant documents
**Output format:** Document excerpts with context and file references

---

### `thoughts-analyzer.md` - Documentation Synthesis

**Purpose:** Analyze and synthesize documentation across multiple sources
**Best for:** Getting comprehensive understanding, connecting related decisions

**Capabilities:**

- Cross-referencing multiple documents
- Identifying themes and patterns
- Synthesizing design evolution
- Mapping decision dependencies

**Result limits:** Returns synthesized summary with key themes
**Output format:** Thematic analysis with supporting references

## Usage Guidelines

1. Use `thoughts-locator` for specific queries
2. Apply `thoughts-analyzer` for comprehensive understanding
3. Combine findings with codebase analysis for full context

## Efficiency Tips

- Search for specific terms or timeframes
- Request theme-based summaries
- Focus on recent or active areas of development

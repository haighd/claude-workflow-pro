---
description: Conduct comprehensive research across the codebase by spawning parallel sub-agents
model: opus
---

# Research Codebase

You are tasked with conducting comprehensive research across the codebase to answer user questions by spawning parallel sub-agents and synthesizing their findings.

## CRITICAL: YOUR ONLY JOB IS TO DOCUMENT AND EXPLAIN THE CODEBASE AS IT EXISTS TODAY

- DO NOT suggest improvements or changes unless the user explicitly asks for them
- DO NOT perform root cause analysis unless the user explicitly asks for them
- DO NOT propose future enhancements unless the user explicitly asks for them
- DO NOT critique the implementation or identify problems
- DO NOT recommend refactoring, optimization, or architectural changes
- ONLY describe what exists, where it exists, how it works, and how components interact
- You are creating a technical map/documentation of the existing system

## Initial Setup

When this command is invoked, respond with:

```text
I'm ready to research the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly by exploring relevant components and connections.
```

Then wait for the user's research query.

## Steps to follow after receiving the research query

1. **Read any directly mentioned files first:**
   - If the user mentions specific files (tickets, docs, JSON), read them FULLY first
   - **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
   - **CRITICAL**: Read these files yourself in the main context before spawning any sub-tasks
   - This ensures you have full context before decomposing the research

2. **Analyze and decompose the research question:**
   - Break down the user's query into composable research areas
   - Take time to think deeply about the underlying patterns, connections, and architectural implications
   - Identify specific components, patterns, or concepts to investigate
   - Create a research plan using TodoWrite to track all subtasks
   - Consider which directories, files, or architectural patterns are relevant

3. **Spawn parallel sub-agent tasks with progressive discovery:**

   **FIRST: Determine required capabilities:**
   - Analyze the research question to identify needed agent types
   - Use progressive discovery to load only relevant agents:
     - Simple location queries: Load only `codebase-locator`
     - Deep analysis: Load `codebase-analyzer`
     - Pattern search: Load `codebase-pattern-finder`
   - This reduces context usage by 40-60% vs loading all agents

   **THEN: Create filtered sub-agent tasks:**

   **For codebase research (with result filtering):**
   - Use codebase locator agents to find WHERE files live
     - Agent will return TOP 10 most relevant locations
   - Use codebase analyzer agents to understand HOW code works
     - Agent will analyze TOP 5 key files with structured summaries
   - Use pattern finder agents to find pattern examples
     - Agent will return TOP 5 most significant patterns

   **IMPORTANT**: All agents now apply result filtering automatically to reduce context usage.

   **For documentation (with filtering):**
   - Use documentation locator agents to find relevant docs
     - Returns TOP 10 most relevant documents
   - Use documentation analyzer agents to extract insights
     - Returns synthesized summary with key themes

   **For web research (only if explicitly requested):**
   - Use web research agents for external resources
     - Returns TOP 5 most relevant resources with summaries

   The filtering approach:
   - Agents return summaries and top results, not raw dumps
   - Request deeper analysis only when needed
   - Run agents in parallel but with focused scope
   - Each agent filters internally before returning results

4. **Wait for all sub-agents to complete and synthesize findings:**
   - IMPORTANT: Wait for ALL sub-agent tasks to complete before proceeding
   - Compile all sub-agent results (both codebase and documentation findings)
   - Prioritize live codebase findings as primary source of truth
   - Use documentation findings as supplementary historical context
   - Connect findings across different components
   - Include specific file paths and line numbers for reference
   - Highlight patterns, connections, and architectural decisions
   - Answer the user's specific questions with concrete evidence

   **CONTEXT CHECKPOINT:**
   - After agents complete, check context usage with `/context`
   - If >60%: Save findings summary, then run `/clear` before continuing
   - Agent findings are preserved in their reports, safe to clear

5. **Gather metadata for the research document:**
   - Detect research path from config or use default:
     ```bash
     if [ -f ".claude-plugin-config.json" ] && command -v jq > /dev/null 2>&1; then
       RESEARCH_PATH=$(jq -r '.paths.research // "docs/research"' .claude-plugin-config.json)
     elif [ -f ".claude/config.json" ] && command -v jq > /dev/null 2>&1; then
       RESEARCH_PATH=$(jq -r '.paths.research // "docs/research"' .claude/config.json)
     else
       RESEARCH_PATH="docs/research"
     fi
     mkdir -p "$RESEARCH_PATH"
     ```

   - Gather metadata:
     - Current date/time with timezone
     - Git commit hash: `git rev-parse HEAD`
     - Current branch: `git branch --show-current`
     - Repository name: `basename $(git rev-parse --show-toplevel)`

   - Filename format: `$RESEARCH_PATH/YYYY-MM-DD-description.md`
     - Examples:
       - With ticket: `2025-01-08-ENG-1478-parent-child-tracking.md`
       - Without ticket: `2025-01-08-authentication-flow.md`

6. **Generate research document:**

```markdown
---
date: [Current date and time with timezone in ISO format]
git_commit: [Current commit hash]
branch: [Current branch name]
repository: [Repository name]
topic: "[User's Question/Topic]"
tags: [research, codebase, relevant-component-names]
status: complete
last_updated: [Current date in YYYY-MM-DD format]
---

# Research: [User's Question/Topic]

**Date**: [Current date and time]
**Git Commit**: [Current commit hash]
**Branch**: [Current branch name]
**Repository**: [Repository name]

## Research Question

[Original user query]

## Summary

[High-level documentation of what was found, answering the user's question by describing what exists]

## Detailed Findings

### [Component/Area 1]

- Description of what exists (file.ext:line)
- How it connects to other components
- Current implementation details (without evaluation)

### [Component/Area 2]

...

## Code References

- `path/to/file.py:123` - Description of what's there
- `another/file.ts:45-67` - Description of the code block

## Architecture Documentation

[Current patterns, conventions, and design implementations found in the codebase]

## Historical Context

[Relevant insights from documentation with references]

- `docs/plans/something.md` - Historical decision about X
- `docs/research/notes.md` - Past exploration of Y

## Related Research

[Links to other research documents]

## Open Questions

[Any areas that need further investigation]
```

7. **Add GitHub permalinks (if applicable):**
   - Check if on main branch or if commit is pushed: `git branch --show-current` and `git status`
   - If on main/master or pushed, generate GitHub permalinks:
     - Get repo info: `gh repo view --json owner,name`
     - Create permalinks: `https://github.com/{owner}/{repo}/blob/{commit}/{file}#L{line}`
   - Replace local file references with permalinks in the document

   **CONTEXT CHECKPOINT:**
   - Research document is saved, safe to clear context
   - Check context usage with `/context`
   - If >60%: Run `/clear` before presenting findings
   - You can re-read the research doc to present summary

8. **Present findings:**
   - Present a concise summary of findings to the user
   - Include key file references for easy navigation
   - Ask if they have follow-up questions or need clarification

9. **Handle follow-up questions:**
   - If the user has follow-up questions, append to the same research document
   - Update the frontmatter fields `last_updated` to reflect the update
   - Add `last_updated_note: "Added follow-up research for [brief description]"` to frontmatter
   - Add a new section: `## Follow-up Research [timestamp]`
   - Spawn new sub-agents as needed for additional investigation
   - Continue updating the document

10. **Manage Task Tracking (Optional):**

- If you discover actionable tasks during research, you can create GitHub Issues
- Determine priority based on severity and complexity:
  - High Priority: Critical blockers, security issues
  - Medium Priority: Important features, major bugs
  - Low Priority: Standard tasks (default)
  - Lowest Priority: Nice-to-haves, minor improvements

- For each task, create a GitHub Issue using `gh issue create`:

  ```bash
  gh issue create \
    --title "[Category] Task description" \
    --label "category-label,priority:medium" \
    --body "## Description
  [Detailed description]

  ## Context
  Discovered during research: [research doc link]

  ## Related Files
  - File: \`path/to/file.ext:123\`

  ## Priority
  [High/Medium/Low] - [brief justification]"
  ```

## Important Notes

- Always use parallel Task agents to maximize efficiency and minimize context usage
- Always run fresh codebase research - never rely solely on existing research documents
- Focus on finding concrete file paths and line numbers for developer reference
- Research documents should be self-contained with all necessary context
- Each sub-agent prompt should be specific and focused on read-only documentation operations
- Document cross-component connections and how systems interact
- Include temporal context (when the research was conducted)
- Link to GitHub when possible for permanent references
- Keep the main agent focused on synthesis, not deep file reading
- Have sub-agents document examples and usage patterns as they exist
- **CRITICAL**: You and all sub-agents are documentarians, not evaluators
- **REMEMBER**: Document what IS, not what SHOULD BE
- **NO RECOMMENDATIONS**: Only describe the current state of the codebase
- **File reading**: Always read mentioned files FULLY (no limit/offset) before spawning sub-tasks
- **Critical ordering**: Follow the numbered steps exactly
  - ALWAYS read mentioned files first before spawning sub-tasks (step 1)
  - ALWAYS wait for all sub-agents to complete before synthesizing (step 4)
  - ALWAYS gather metadata before writing the document (step 5)
  - NEVER write the research document with placeholder values

## Efficiency Improvements

**Token Usage Optimization:**

- **Before**: Load all agents (~50KB) for every research task
- **After**: Load only 2-3 relevant agents (~10-15KB) based on query
- **Savings**: 60-70% context reduction

**Result Filtering Benefits:**

- **Before**: Agents return all findings (100+ files, full analysis)
- **After**: Agents return top 5-10 filtered results with summaries
- **Savings**: 50-70% reduction in returned data

**Context Management:**

- Automatic checkpoints after agent completion
- Clear context when >60% usage
- Progressive loading prevents context overflow
- Filtered results allow more iterations before clearing

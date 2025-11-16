#!/bin/bash
#
# Commit Message Validator
# Validates commit messages follow conventional commits format
#
# Usage: Called automatically by Claude Code pre-commit hook

set -e

# Get the commit message from tool input
message="$1"

# Extract just the message part if it's a full git commit command
if [[ "$message" =~ git\ commit.*-m[[:space:]]+[\"\'](.*)[\"\'"] ]]; then
  message="${BASH_REMATCH[1]}"
fi

# Check for conventional commit format
# Format: <type>: <description>
# Types: feat, fix, docs, style, refactor, test, chore
if [[ ! "$message" =~ ^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert):[[:space:]] ]]; then
  echo "❌ Commit message must follow conventional commits format"
  echo ""
  echo "   Format: <type>: <description>"
  echo ""
  echo "   Valid types:"
  echo "     feat:     A new feature"
  echo "     fix:      A bug fix"
  echo "     docs:     Documentation only changes"
  echo "     style:    Code style changes (formatting, etc.)"
  echo "     refactor: Code refactoring"
  echo "     test:     Adding or updating tests"
  echo "     chore:    Maintenance tasks"
  echo "     perf:     Performance improvements"
  echo "     ci:       CI/CD changes"
  echo "     build:    Build system changes"
  echo "     revert:   Revert a previous commit"
  echo ""
  echo "   Examples:"
  echo "     feat: add user authentication"
  echo "     fix: resolve login redirect issue"
  echo "     docs: update API documentation"
  echo ""
  exit 1
fi

# Check message isn't too short
message_body=$(echo "$message" | cut -d: -f2- | xargs)
if [[ ${#message_body} -lt 10 ]]; then
  echo "⚠️  Commit message is very short (${#message_body} chars)"
  echo "   Consider adding more detail about the change"
  # Don't fail, just warn
fi

echo "✅ Commit message format valid"
exit 0

#!/bin/bash
#
# Test Runner Hook
# Automatically runs relevant tests when code files change
#

set -e

# Get the file that was modified from tool input
modified_file="$1"

# Extract just the filename if it's a full path
if [[ "$modified_file" =~ src/([^/]+)/([^/]+\.js) ]]; then
  module="${BASH_REMATCH[1]}"
  file="${BASH_REMATCH[2]}"

  echo "🧪 Running tests for ${module}/${file}..."

  # Try to find and run related test
  test_file="tests/unit/${file%.js}.test.js"

  if [[ -f "$CLAUDE_PROJECT_DIR/$test_file" ]]; then
    cd "$CLAUDE_PROJECT_DIR"
    if npm test -- "$test_file" --silent 2>/dev/null; then
      echo "✅ Tests passed for $test_file"
    else
      echo "⚠️  Tests failed for $test_file - review before committing"
    fi
  else
    echo "ℹ️  No test file found at $test_file"
  fi
fi

exit 0

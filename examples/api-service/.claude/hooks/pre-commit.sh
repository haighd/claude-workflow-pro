#!/bin/bash
#
# Pre-Commit Hook
# Runs comprehensive checks before allowing commits
#

set -e

echo "🔍 Running pre-commit checks..."

# Change to project directory
cd "$CLAUDE_PROJECT_DIR"

# 1. Run tests
echo "  Running tests..."
if ! npm test --silent 2>/dev/null; then
  echo "  ❌ Tests failed - fix before committing"
  exit 1
fi
echo "  ✅ Tests passed"

# 2. Run linter
echo "  Running linter..."
if ! npm run lint --silent 2>/dev/null; then
  echo "  ❌ Lint errors found - fix before committing"
  exit 1
fi
echo "  ✅ Lint passed"

# 3. Type checking
echo "  Running type check..."
if command -v tsc &> /dev/null; then
  if ! npm run type-check --silent 2>/dev/null; then
    echo "  ❌ Type errors found - fix before committing"
    exit 1
  fi
  echo "  ✅ Type check passed"
else
  echo "  ⚠️  TypeScript not installed, skipping type check"
fi

# 4. Check for secrets/sensitive data
echo "  Checking for secrets..."
if grep -r -i "api[_-]?key\|secret\|password\|token" src/ --include="*.js" --include="*.ts" | grep -v "process.env" | grep -v "//"; then
  echo "  ⚠️  Warning: Possible hardcoded secrets found"
  echo "  Please review and ensure no secrets are committed"
  # Don't fail, just warn
fi

echo ""
echo "✅ All pre-commit checks passed"
exit 0

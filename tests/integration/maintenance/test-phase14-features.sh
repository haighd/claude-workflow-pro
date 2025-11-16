#!/bin/bash

# Phase 14 Integration Tests
# Tests for Long-term Maintenance Setup features

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
print_test() {
    echo -e "${YELLOW}[TEST]${NC} $1"
    ((TESTS_RUN++))
}

print_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
}

print_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
}

print_header() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "$1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Get project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$PROJECT_ROOT"

print_header "Phase 14: Long-term Maintenance Setup - Integration Tests"

echo "Project Root: $PROJECT_ROOT"
echo "Test Suite: Phase 14 Features"
echo ""

# ============================================================================
# Test Suite 1: Documentation Presence
# ============================================================================

print_header "Test Suite 1: Documentation Files"

print_test "Deprecation policy documentation exists"
if [ -f "docs/DEPRECATION_POLICY.md" ]; then
    print_pass "DEPRECATION_POLICY.md found"
else
    print_fail "DEPRECATION_POLICY.md missing"
fi

print_test "Versioning strategy documentation exists"
if [ -f "docs/VERSIONING.md" ]; then
    print_pass "VERSIONING.md found"
else
    print_fail "VERSIONING.md missing"
fi

print_test "Backward compatibility guide exists"
if [ -f "docs/BACKWARD_COMPATIBILITY.md" ]; then
    print_pass "BACKWARD_COMPATIBILITY.md found"
else
    print_fail "BACKWARD_COMPATIBILITY.md missing"
fi

print_test "LTS policy documentation exists"
if [ -f "docs/LTS.md" ]; then
    print_pass "LTS.md found"
else
    print_fail "LTS.md missing"
fi

# ============================================================================
# Test Suite 2: Migration Guides
# ============================================================================

print_header "Test Suite 2: Migration Guides"

print_test "Migration guides directory exists"
if [ -d "docs/migrations" ]; then
    print_pass "migrations/ directory found"
else
    print_fail "migrations/ directory missing"
fi

print_test "Migration README exists"
if [ -f "docs/migrations/README.md" ]; then
    print_pass "migrations/README.md found"
else
    print_fail "migrations/README.md missing"
fi

print_test "v1.0.0 migration guide exists"
if [ -f "docs/migrations/v1.0.0.md" ]; then
    print_pass "v1.0.0 migration guide found"
else
    print_fail "v1.0.0 migration guide missing"
fi

print_test "v2.0.0 migration guide exists (future)"
if [ -f "docs/migrations/v2.0.0.md" ]; then
    print_pass "v2.0.0 migration guide found"
else
    print_fail "v2.0.0 migration guide missing"
fi

# ============================================================================
# Test Suite 3: Maintenance Commands
# ============================================================================

print_header "Test Suite 3: Maintenance Commands"

print_test "Maintenance commands directory exists"
if [ -d "commands/maintenance" ]; then
    print_pass "commands/maintenance/ directory found"
else
    print_fail "commands/maintenance/ directory missing"
fi

print_test "Health check command exists"
if [ -f "commands/maintenance/health.md" ]; then
    print_pass "health.md command found"
else
    print_fail "health.md command missing"
fi

print_test "Migration tool command exists"
if [ -f "commands/maintenance/migrate.md" ]; then
    print_pass "migrate.md command found"
else
    print_fail "migrate.md command missing"
fi

print_test "Check deprecations command exists"
if [ -f "commands/maintenance/check-deprecations.md" ]; then
    print_pass "check-deprecations.md command found"
else
    print_fail "check-deprecations.md command missing"
fi

print_test "Update dependencies command exists"
if [ -f "commands/maintenance/update-deps.md" ]; then
    print_pass "update-deps.md command found"
else
    print_fail "update-deps.md command missing"
fi

# ============================================================================
# Test Suite 4: Documentation Content Validation
# ============================================================================

print_header "Test Suite 4: Documentation Content Validation"

print_test "Deprecation policy contains semantic versioning"
if grep -q "Semantic Versioning" "docs/DEPRECATION_POLICY.md"; then
    print_pass "Semantic versioning section found"
else
    print_fail "Semantic versioning section missing"
fi

print_test "Deprecation policy contains deprecation process"
if grep -q "Deprecation Process" "docs/DEPRECATION_POLICY.md"; then
    print_pass "Deprecation process found"
else
    print_fail "Deprecation process missing"
fi

print_test "Versioning doc contains version format"
if grep -q "MAJOR.MINOR.PATCH" "docs/VERSIONING.md"; then
    print_pass "Version format found"
else
    print_fail "Version format missing"
fi

print_test "LTS policy contains support lifecycle"
if grep -q "Support Lifecycle" "docs/LTS.md"; then
    print_pass "Support lifecycle found"
else
    print_fail "Support lifecycle missing"
fi

print_test "LTS policy mentions v1.0.0 as LTS"
if grep -q "v1.0.0 (LTS)" "docs/LTS.md" || grep -q "v1.0.0 LTS" "docs/LTS.md"; then
    print_pass "v1.0.0 LTS designation found"
else
    print_fail "v1.0.0 LTS designation missing"
fi

print_test "Backward compatibility contains compatibility matrix"
if grep -q "Compatibility Matrix" "docs/BACKWARD_COMPATIBILITY.md"; then
    print_pass "Compatibility matrix found"
else
    print_fail "Compatibility matrix missing"
fi

# ============================================================================
# Test Suite 5: Migration Guide Content
# ============================================================================

print_header "Test Suite 5: Migration Guide Content"

print_test "v1.0.0 migration guide contains installation steps"
if grep -q "Installation" "docs/migrations/v1.0.0.md"; then
    print_pass "Installation section found"
else
    print_fail "Installation section missing"
fi

print_test "v1.0.0 migration guide contains quick start"
if grep -q "Quick Start" "docs/migrations/v1.0.0.md"; then
    print_pass "Quick start section found"
else
    print_fail "Quick start section missing"
fi

print_test "v2.0.0 migration guide marked as future"
if grep -q "Future" "docs/migrations/v2.0.0.md" || grep -q "future" "docs/migrations/v2.0.0.md"; then
    print_pass "Future designation found"
else
    print_fail "Future designation missing"
fi

print_test "Migration README contains migration process"
if grep -q "Migration Process" "docs/migrations/README.md"; then
    print_pass "Migration process found"
else
    print_fail "Migration process missing"
fi

# ============================================================================
# Test Suite 6: Command Documentation Quality
# ============================================================================

print_header "Test Suite 6: Command Documentation Quality"

print_test "Health command contains usage examples"
if grep -q "Usage" "commands/maintenance/health.md"; then
    print_pass "Usage section found in health.md"
else
    print_fail "Usage section missing in health.md"
fi

print_test "Migrate command contains phase descriptions"
if grep -q "Phase" "commands/maintenance/migrate.md"; then
    print_pass "Phase descriptions found in migrate.md"
else
    print_fail "Phase descriptions missing in migrate.md"
fi

print_test "Check deprecations contains output format"
if grep -q "Output Format" "commands/maintenance/check-deprecations.md"; then
    print_pass "Output format found in check-deprecations.md"
else
    print_fail "Output format missing in check-deprecations.md"
fi

# ============================================================================
# Test Suite 7: Cross-references and Links
# ============================================================================

print_header "Test Suite 7: Cross-references"

print_test "Deprecation policy references versioning doc"
if grep -q "VERSIONING.md" "docs/DEPRECATION_POLICY.md"; then
    print_pass "Cross-reference to VERSIONING.md found"
else
    print_fail "Cross-reference to VERSIONING.md missing"
fi

print_test "Versioning doc references deprecation policy"
if grep -q "DEPRECATION_POLICY.md" "docs/VERSIONING.md"; then
    print_pass "Cross-reference to DEPRECATION_POLICY.md found"
else
    print_fail "Cross-reference to DEPRECATION_POLICY.md missing"
fi

print_test "LTS policy references versioning doc"
if grep -q "VERSIONING.md" "docs/LTS.md"; then
    print_pass "Cross-reference to VERSIONING.md found in LTS"
else
    print_fail "Cross-reference to VERSIONING.md missing in LTS"
fi

print_test "Backward compatibility references LTS policy"
if grep -q "LTS.md" "docs/BACKWARD_COMPATIBILITY.md"; then
    print_pass "Cross-reference to LTS.md found"
else
    print_fail "Cross-reference to LTS.md missing"
fi

# ============================================================================
# Test Suite 8: File Permissions
# ============================================================================

print_header "Test Suite 8: File Permissions"

print_test "Documentation files are readable"
READABLE_COUNT=0
for doc in docs/DEPRECATION_POLICY.md docs/VERSIONING.md docs/BACKWARD_COMPATIBILITY.md docs/LTS.md; do
    if [ -r "$doc" ]; then
        ((READABLE_COUNT++))
    fi
done

if [ $READABLE_COUNT -eq 4 ]; then
    print_pass "All documentation files readable ($READABLE_COUNT/4)"
else
    print_fail "Some documentation files not readable ($READABLE_COUNT/4)"
fi

print_test "Command files are readable"
READABLE_CMD_COUNT=0
for cmd in commands/maintenance/*.md; do
    if [ -r "$cmd" ]; then
        ((READABLE_CMD_COUNT++))
    fi
done

if [ $READABLE_CMD_COUNT -ge 4 ]; then
    print_pass "All maintenance commands readable ($READABLE_CMD_COUNT files)"
else
    print_fail "Some maintenance commands not readable ($READABLE_CMD_COUNT files)"
fi

# ============================================================================
# Test Suite 9: Documentation Completeness
# ============================================================================

print_header "Test Suite 9: Documentation Completeness"

print_test "Deprecation policy has version history"
if grep -q "Version History" "docs/DEPRECATION_POLICY.md"; then
    print_pass "Version history found in DEPRECATION_POLICY.md"
else
    print_fail "Version history missing in DEPRECATION_POLICY.md"
fi

print_test "Versioning doc has FAQ section"
if grep -q "FAQ" "docs/VERSIONING.md"; then
    print_pass "FAQ section found in VERSIONING.md"
else
    print_fail "FAQ section missing in VERSIONING.md"
fi

print_test "LTS policy has support tiers"
if grep -q "Support Tiers" "docs/LTS.md"; then
    print_pass "Support tiers found in LTS.md"
else
    print_fail "Support tiers missing in LTS.md"
fi

print_test "Backward compatibility has testing section"
if grep -q "Testing" "docs/BACKWARD_COMPATIBILITY.md" || grep -q "Compatibility Test" "docs/BACKWARD_COMPATIBILITY.md"; then
    print_pass "Testing section found in BACKWARD_COMPATIBILITY.md"
else
    print_fail "Testing section missing in BACKWARD_COMPATIBILITY.md"
fi

# ============================================================================
# Test Suite 10: Consistency Checks
# ============================================================================

print_header "Test Suite 10: Consistency Checks"

print_test "All docs reference v1.0.0 consistently"
V1_COUNT=$(grep -r "v1.0.0" docs/DEPRECATION_POLICY.md docs/VERSIONING.md docs/LTS.md docs/BACKWARD_COMPATIBILITY.md | wc -l)
if [ $V1_COUNT -gt 10 ]; then
    print_pass "v1.0.0 referenced consistently ($V1_COUNT times)"
else
    print_fail "v1.0.0 under-referenced ($V1_COUNT times)"
fi

print_test "LTS mentioned in multiple docs"
LTS_COUNT=$(grep -r "LTS" docs/*.md | wc -l)
if [ $LTS_COUNT -gt 20 ]; then
    print_pass "LTS mentioned across docs ($LTS_COUNT times)"
else
    print_fail "LTS under-mentioned ($LTS_COUNT times)"
fi

print_test "Migration guides mentioned in docs"
MIGRATION_COUNT=$(grep -r "migration" docs/*.md | wc -l)
if [ $MIGRATION_COUNT -gt 30 ]; then
    print_pass "Migration referenced frequently ($MIGRATION_COUNT times)"
else
    print_fail "Migration under-referenced ($MIGRATION_COUNT times)"
fi

# ============================================================================
# Summary
# ============================================================================

print_header "Test Summary"

echo "Tests Run:    $TESTS_RUN"
echo "Tests Passed: $TESTS_PASSED"
echo "Tests Failed: $TESTS_FAILED"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All Phase 14 tests passed!${NC}"
    echo ""
    echo "Phase 14 Components Validated:"
    echo "  ✅ Deprecation Policy"
    echo "  ✅ Versioning Strategy"
    echo "  ✅ Migration Guides (v1.0.0, v2.0.0)"
    echo "  ✅ Backward Compatibility Guide"
    echo "  ✅ LTS Policy"
    echo "  ✅ Maintenance Commands (4 commands)"
    echo "  ✅ Documentation Cross-references"
    echo "  ✅ Content Completeness"
    echo ""
    echo "Phase 14: Long-term Maintenance Setup - COMPLETE ✅"
    exit 0
else
    echo -e "${RED}❌ Some Phase 14 tests failed${NC}"
    echo ""
    echo "Please review failed tests above and fix issues."
    exit 1
fi

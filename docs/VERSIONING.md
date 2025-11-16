# Versioning Strategy

**Version**: 1.0.0
**Last Updated**: 2025-11-16
**Status**: Active

## Overview

Claude Workflow Pro follows **Semantic Versioning 2.0.0** (semver.org) to provide clear, predictable version numbering and compatibility guarantees.

## Semantic Versioning

### Format

```
MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]

Example: 2.1.3-beta.1+build.456
```

### Version Components

```
┌─────── MAJOR: Breaking changes
│  ┌──── MINOR: New features (backward compatible)
│  │  ┌─ PATCH: Bug fixes (backward compatible)
│  │  │
2  .  1  .  3  -beta.1  +build.456
          │       │           │
          │       │           └─ Build metadata (optional)
          │       └─ Pre-release identifier (optional)
          └─ Patch version
```

### Version Increment Rules

#### MAJOR Version (X.0.0)

Increment when making **incompatible API changes**:

- ❌ Removing commands
- ❌ Removing command arguments
- ❌ Changing command behavior significantly
- ❌ Removing configuration options
- ❌ Changing output format (breaking)
- ❌ Removing agents or templates
- ❌ Breaking plugin API changes
- ❌ Major architectural changes

**Example**: v1.5.2 → v2.0.0

#### MINOR Version (x.Y.0)

Increment when adding **backward-compatible functionality**:

- ✅ Adding new commands
- ✅ Adding optional command arguments
- ✅ Adding new configuration options
- ✅ Adding new agents or templates
- ✅ Enhancing existing features (non-breaking)
- ✅ Performance improvements
- ✅ Deprecating features (with warnings)

**Example**: v1.5.2 → v1.6.0

#### PATCH Version (x.y.Z)

Increment when making **backward-compatible bug fixes**:

- ✅ Bug fixes
- ✅ Security patches
- ✅ Documentation corrections
- ✅ Typo fixes
- ✅ Performance optimizations (non-breaking)
- ✅ Internal code refactoring

**Example**: v1.5.2 → v1.5.3

## Pre-release Versions

Pre-release versions indicate development builds not yet ready for production.

### Format

```
MAJOR.MINOR.PATCH-PRERELEASE.NUMBER

Examples:
- 2.0.0-alpha.1
- 2.0.0-beta.2
- 2.0.0-rc.1
```

### Pre-release Types

#### Alpha (α)

**Purpose**: Early development, feature incomplete
**Stability**: Unstable, expect breaking changes
**Audience**: Developers and early testers

```
1.6.0-alpha.1  → First alpha build
1.6.0-alpha.2  → Second alpha build (may have breaking changes)
```

#### Beta (β)

**Purpose**: Feature complete, stabilization phase
**Stability**: Mostly stable, minor changes possible
**Audience**: Wider testing audience

```
1.6.0-beta.1  → First beta build
1.6.0-beta.2  → Second beta build (bug fixes)
```

#### Release Candidate (rc)

**Purpose**: Final testing before release
**Stability**: Stable, only critical bugs fixed
**Audience**: Production testing

```
1.6.0-rc.1  → First release candidate
1.6.0-rc.2  → Second release candidate (critical fixes only)
```

### Pre-release Progression

```
Development → Alpha → Beta → RC → Stable
     ↓          ↓       ↓      ↓      ↓
  Internal  → Dev → Testing → QA → Production
```

## Build Metadata

Build metadata provides additional build information.

### Format

```
MAJOR.MINOR.PATCH+BUILD.METADATA

Examples:
- 1.5.3+build.1234
- 1.5.3+20251116.ab3f1e2
- 2.0.0-beta.1+exp.sha.5114f85
```

### Use Cases

- **CI/CD Build Numbers**: `1.5.3+build.1234`
- **Commit SHA**: `1.5.3+commit.ab3f1e2`
- **Build Date**: `1.5.3+20251116`
- **Platform**: `1.5.3+linux-x64`

**Note**: Build metadata DOES NOT affect version precedence.

## Version Precedence

Versions are compared using these rules:

1. Compare MAJOR, MINOR, PATCH numerically
2. Pre-release versions have LOWER precedence than stable
3. Compare pre-release identifiers left to right

### Examples (Ordered)

```
1.0.0-alpha.1
  ↓
1.0.0-alpha.2
  ↓
1.0.0-beta.1
  ↓
1.0.0-beta.2
  ↓
1.0.0-rc.1
  ↓
1.0.0
  ↓
1.0.1
  ↓
1.1.0
  ↓
2.0.0
```

## Release Cadence

### Regular Releases

| Type | Frequency | Example |
|------|-----------|---------|
| **PATCH** | As needed | Security fixes, critical bugs |
| **MINOR** | Quarterly | v1.1.0 (Q1), v1.2.0 (Q2), v1.3.0 (Q3), v1.4.0 (Q4) |
| **MAJOR** | Annually | v2.0.0 (Q4 2026), v3.0.0 (Q4 2027) |

### Special Releases

- **Security Patches**: Immediate (any day)
- **Hotfixes**: Within 48 hours of critical bug discovery
- **LTS Versions**: Every 4th major version

## Version Support Lifecycle

### Active Development

**Duration**: Current MAJOR + MINOR versions
**Updates**: All (features, bugs, security)

```
v1.5.0 (current) ──→ Active development
├─ New features
├─ Bug fixes
└─ Security patches
```

### Maintenance Mode

**Duration**: Previous MAJOR version
**Updates**: Bug fixes and security only

```
v1.4.x ──→ Maintenance mode (6 months)
├─ Bug fixes
└─ Security patches
```

### Security Only

**Duration**: 6 months after maintenance
**Updates**: Critical security patches only

```
v1.3.x ──→ Security only (6 months)
└─ Critical security patches
```

### End of Life (EOL)

**Updates**: None

```
v1.2.x ──→ EOL
└─ No updates (archived)
```

### Support Timeline Example

```
┌─────────┬──────────────┬──────────────┬──────────────┬──────────┐
│ Release │   Active     │ Maintenance  │  Security    │   EOL    │
├─────────┼──────────────┼──────────────┼──────────────┼──────────┤
│ v1.0.0  │ 12 months    │  6 months    │  6 months    │ Forever  │
│ (LTS)   │ Q4'25-Q4'26  │ Q4'26-Q2'27  │ Q2'27-Q4'27  │ Q4'27+   │
├─────────┼──────────────┼──────────────┼──────────────┼──────────┤
│ v2.0.0  │ 12 months    │  6 months    │  6 months    │ Forever  │
│         │ Q4'26-Q4'27  │ Q4'27-Q2'28  │ Q2'28-Q4'28  │ Q4'28+   │
├─────────┼──────────────┼──────────────┼──────────────┼──────────┤
│ v4.0.0  │ 24 months    │  6 months    │  6 months    │ Forever  │
│ (LTS)   │ Q4'28-Q4'30  │ Q4'30-Q2'31  │ Q2'31-Q4'31  │ Q4'31+   │
└─────────┴──────────────┴──────────────┴──────────────┴──────────┘
```

## Long-Term Support (LTS)

### LTS Designation

Every **4th MAJOR version** is designated LTS:

```
v1.0.0 (LTS) ──→ 24 months support
v2.0.0       ──→ 12 months support
v3.0.0       ──→ 12 months support
v4.0.0 (LTS) ──→ 24 months support
v5.0.0       ──→ 12 months support
v6.0.0       ──→ 12 months support
v7.0.0       ──→ 12 months support
v8.0.0 (LTS) ──→ 24 months support
```

### LTS Benefits

- **Extended Support**: 24 months vs 12 months
- **Stability**: Fewer breaking changes
- **Backports**: Selected feature backports
- **Priority Fixes**: Security and critical bugs
- **Documentation**: Maintained longer
- **Enterprise Ready**: Suitable for long-term deployments

### LTS vs Regular

| Feature | Regular | LTS |
|---------|---------|-----|
| Support Duration | 12 months | 24 months |
| Feature Updates | Active only | Active only |
| Bug Fixes | 6 months maintenance | 12 months maintenance |
| Security Patches | 6 months security | 12 months security |
| Breaking Changes | Annual | Every 4 years |
| Backports | Minimal | Selective |

## Version Compatibility

### Backward Compatibility

Within a MAJOR version, we guarantee:

✅ **Configuration files** from older MINOR/PATCH versions work
✅ **Commands** maintain same syntax and behavior
✅ **Agents** remain compatible
✅ **Templates** continue to function
✅ **Plugins** using same MAJOR API version work
✅ **Checkpoints** can be loaded

### Forward Compatibility

We strive for, but don't guarantee:

⚠️ **Configuration files** may work in older versions (best effort)
⚠️ **Checkpoints** from newer versions may load in older versions (degraded)

### Breaking Compatibility

Across MAJOR versions:

❌ **Breaking changes** are expected and documented
❌ **Migration required** for some features
✅ **Migration tools** provided
✅ **Documentation** for all breaking changes
✅ **Deprecation warnings** in previous MAJOR version

## Version Detection

### Check Current Version

```bash
# Display version
/workflow/version

# Output:
# Claude Workflow Pro v1.5.3
# API Version: 1
# Build: 20251116+ab3f1e2
```

### Check Compatibility

```bash
# Check if current project is compatible
/maintenance/check-compatibility

# Output:
# ✅ Project compatible with v1.5.3
# ⚠️  Using deprecated feature: /workflow/create-plan
#    Replacement: /workflow/plan create
#    Deprecated in: v1.5.0
#    Removal in: v2.0.0
```

### Check for Updates

```bash
# Check for available updates
/maintenance/check-updates

# Output:
# Current: v1.5.3
# Latest Stable: v1.6.0
# Latest LTS: v1.0.0
#
# Updates Available:
# - v1.5.4 (patch) - Security fix
# - v1.6.0 (minor) - New features
#
# To update: git pull && git checkout v1.6.0
```

## Release Process

### 1. Development Phase

```bash
# Work on feature branches
git checkout -b feature/new-workflow-command

# Regular commits
git commit -m "feat: add parallel execution support"
```

### 2. Pre-release

```bash
# Create alpha release
git tag -a v1.6.0-alpha.1 -m "Release v1.6.0-alpha.1"

# Create beta release
git tag -a v1.6.0-beta.1 -m "Release v1.6.0-beta.1"

# Create release candidate
git tag -a v1.6.0-rc.1 -m "Release v1.6.0-rc.1"
```

### 3. Stable Release

```bash
# Create stable release
git tag -a v1.6.0 -m "Release v1.6.0"
git push origin v1.6.0

# Update CHANGELOG
vim CHANGELOG.md

# Commit and push
git commit -m "docs: update CHANGELOG for v1.6.0"
git push
```

### 4. Post-release

```bash
# Create GitHub release
gh release create v1.6.0 \
  --title "v1.6.0 - Enhanced Workflow Features" \
  --notes-file docs/RELEASE_NOTES_v1.6.0.md

# Announce on community channels
# Update documentation
# Monitor for issues
```

## Version Tags and Branches

### Tags

```bash
# Stable releases
v1.0.0, v1.1.0, v1.2.0

# Pre-releases
v1.6.0-alpha.1, v1.6.0-beta.2, v1.6.0-rc.1

# List all tags
git tag --list 'v*'

# Checkout specific version
git checkout v1.5.3
```

### Branches

```
main            → Development (next minor)
release/v1.x    → Maintenance for v1.x
release/v2.x    → Maintenance for v2.x
lts/v1.0        → LTS maintenance for v1.0
lts/v4.0        → LTS maintenance for v4.0
```

## Dependency Versioning

### Plugin Dependencies

Plugins specify compatible versions:

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "claudeWorkflow": {
    "apiVersion": 1,
    "minVersion": "1.0.0",
    "maxVersion": "1.x.x"
  }
}
```

### Version Ranges

Using semver ranges:

```json
{
  "claudeWorkflow": {
    "version": "^1.5.0"  // >=1.5.0 <2.0.0
  }
}
```

**Supported Range Operators**:
- `^1.5.0` → Compatible with 1.5.0 (MINOR changes ok)
- `~1.5.0` → Compatible with 1.5.0 (PATCH changes ok)
- `>=1.5.0 <2.0.0` → Explicit range
- `1.5.x` → Any 1.5 PATCH version
- `*` → Any version (not recommended)

## Version Documentation

### CHANGELOG.md

Every version documented in CHANGELOG.md:

```markdown
## [1.6.0] - 2025-12-01

### Added
- Parallel workflow execution
- Enhanced metrics dashboard
- Cloud checkpoint sync

### Changed
- Improved plan validation performance

### Deprecated
- `/workflow/create-plan` in favor of `/workflow/plan create`

### Removed
- None

### Fixed
- Checkpoint loading race condition
- Memory leak in long-running workflows

### Security
- Updated dependencies with security vulnerabilities
```

### Release Notes

Detailed release notes for each version:

```markdown
# Release Notes: v1.6.0

## Highlights
- 🚀 Parallel workflow execution
- 📊 Real-time metrics dashboard
- ☁️  Cloud checkpoint synchronization

## Breaking Changes
None

## Migration Guide
See docs/migrations/v1.6.0.md

## Full Changelog
See CHANGELOG.md
```

## Version in Code

### Version File

```json
// version.json
{
  "version": "1.6.0",
  "apiVersion": 1,
  "buildDate": "2025-11-16",
  "commit": "ab3f1e2"
}
```

### Runtime Version Check

```javascript
// Plugin version check example
const { version } = require('./version.json');

if (semver.lt(version, '1.5.0')) {
  console.warn('Plugin requires Claude Workflow Pro >= 1.5.0');
  process.exit(1);
}
```

## FAQ

### Q: How often are new versions released?

**A**: PATCH releases as needed, MINOR releases quarterly, MAJOR releases annually.

### Q: How long is each version supported?

**A**: Regular versions: 12 months active + 6 months maintenance + 6 months security. LTS: 24 months active + 6 months maintenance + 6 months security.

### Q: Can I skip versions when upgrading?

**A**: You can skip MINOR/PATCH versions within same MAJOR. Skipping MAJOR versions requires reviewing each migration guide.

### Q: What if I need to stay on an older version?

**A**: Use LTS versions for longer support. After EOL, you can continue using but won't receive updates.

### Q: How are security vulnerabilities handled?

**A**: Immediate PATCH release for all supported versions, including security-only versions.

### Q: What makes a version "LTS"?

**A**: Every 4th MAJOR version receives extended support and stability commitment.

### Q: Can I use pre-release versions in production?

**A**: Not recommended. Pre-releases are for testing only.

### Q: How do I know if a version has breaking changes?

**A**: MAJOR version bumps always indicate breaking changes. Check migration guide.

## References

- [Semantic Versioning 2.0.0](https://semver.org/)
- [DEPRECATION_POLICY.md](./DEPRECATION_POLICY.md)
- [CHANGELOG.md](../CHANGELOG.md)
- [Migration Guides](./migrations/)
- [LTS Policy](./LTS.md)

## Version History

| Version | Date       | Changes                    |
|---------|------------|----------------------------|
| 1.0.0   | 2025-11-16 | Initial versioning policy  |

---

**Questions about versioning?** Open an issue or discussion on GitHub.

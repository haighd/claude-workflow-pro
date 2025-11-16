# GitHub Auto Release

Automatically generate release notes and create GitHub releases from merged PRs and commits.

## Purpose

Automate the release process by generating comprehensive release notes from git history, categorizing changes, and creating properly formatted GitHub releases.

## Usage

```bash
/github/auto-release [version] [--draft] [--prerelease] [--config=path]
```

## Parameters

- `version` - Version number (e.g., `v1.2.0`, `1.2.0-beta.1`)
  - If omitted, automatically determines next version based on changes
- `--draft` - Create as draft release (default: published)
- `--prerelease` - Mark as pre-release
- `--config=path` - Path to custom release configuration

## What It Does

### Release Generation

1. **Version Detection**
   - Analyze commits since last release
   - Determine version bump (major/minor/patch)
   - Suggest next version number

2. **Change Collection**
   - Gather all merged PRs
   - Collect commit messages
   - Extract breaking changes
   - Identify contributors

3. **Categorization**
   - Group by change type (features, fixes, etc.)
   - Sort by importance
   - Filter noise (chore commits, etc.)

4. **Release Notes**
   - Generate formatted changelog
   - Add upgrade instructions
   - Include breaking changes
   - List contributors

5. **Asset Generation**
   - Create release artifacts
   - Generate checksums
   - Attach binaries (if applicable)

## Release Configuration

### Default Configuration

Create `.claude-release.json` in project root:

```json
{
  "versioning": {
    "scheme": "semver",
    "auto-detect": true,
    "increment-rules": {
      "major": ["breaking", "major"],
      "minor": ["feat", "feature"],
      "patch": ["fix", "patch", "chore"]
    },
    "prerelease-tags": ["alpha", "beta", "rc"],
    "initial-version": "0.1.0"
  },
  "changelog": {
    "enabled": true,
    "include-prs": true,
    "include-commits": false,
    "categories": [
      {
        "title": "🚀 Features",
        "labels": ["feature", "enhancement"],
        "commits": ["feat"]
      },
      {
        "title": "🐛 Bug Fixes",
        "labels": ["bug", "fix"],
        "commits": ["fix"]
      },
      {
        "title": "⚡ Performance",
        "labels": ["performance"],
        "commits": ["perf"]
      },
      {
        "title": "📚 Documentation",
        "labels": ["documentation", "docs"],
        "commits": ["docs"]
      },
      {
        "title": "🔒 Security",
        "labels": ["security"],
        "commits": ["security"]
      },
      {
        "title": "♻️ Refactoring",
        "labels": ["refactoring"],
        "commits": ["refactor"]
      },
      {
        "title": "🧪 Tests",
        "labels": ["test", "testing"],
        "commits": ["test"]
      },
      {
        "title": "🔧 Maintenance",
        "labels": ["chore", "maintenance"],
        "commits": ["chore"]
      }
    ],
    "exclude-labels": ["duplicate", "invalid", "wontfix"],
    "breaking-changes-section": true,
    "contributors-section": true
  },
  "release-notes": {
    "template": "default",
    "include-installation": true,
    "include-upgrade-guide": true,
    "include-deprecations": true,
    "footer-template": "templates/release-footer.md"
  },
  "git": {
    "tag-prefix": "v",
    "tag-message": "Release ${version}",
    "since-last-tag": true,
    "include-merge-commits": false
  },
  "github": {
    "create-release": true,
    "release-draft": false,
    "prerelease": false,
    "discussion-category": "Announcements"
  },
  "assets": {
    "enabled": false,
    "build-command": "npm run build",
    "files": [
      "dist/**/*",
      "LICENSE",
      "README.md"
    ],
    "checksums": true
  },
  "notifications": {
    "slack": {
      "enabled": false,
      "webhook": "${SLACK_WEBHOOK}",
      "channel": "#releases"
    },
    "twitter": {
      "enabled": false,
      "message-template": "🎉 Released ${version}! ${url}"
    }
  }
}
```

## Release Output

### Example: Feature Release (v1.2.0)

```markdown
# v1.2.0

Release Date: 2025-11-16

## What's New

This release adds OAuth2 authentication, improves performance,
and fixes several bugs.

## 🚀 Features

- **OAuth2 Authentication** (#456) @contributor1
  Add OAuth2 support with Google and GitHub providers
- **Dark Mode** (#457) @contributor2
  Implement dark mode toggle in settings
- **Export to CSV** (#458) @contributor3
  Add CSV export functionality for reports

## 🐛 Bug Fixes

- Fix login redirect loop (#459) @contributor4
- Resolve dashboard crash on empty data (#460) @contributor5
- Correct timezone handling in reports (#461) @contributor6

## ⚡ Performance

- Optimize database queries (50% faster) (#462) @contributor7
- Reduce bundle size by 30% (#463) @contributor8

## 📚 Documentation

- Add OAuth2 setup guide (#464) @contributor9
- Update API documentation (#465) @contributor10

## 🔧 Maintenance

- Update dependencies (#466) @dependabot
- Refactor authentication module (#467) @contributor11

## 📊 Statistics

- **PRs Merged:** 12
- **Contributors:** 11
- **Commits:** 45
- **Files Changed:** 87

## 🙏 Contributors

Thank you to all contributors who made this release possible!

@contributor1, @contributor2, @contributor3, @contributor4,
@contributor5, @contributor6, @contributor7, @contributor8,
@contributor9, @contributor10, @contributor11, @dependabot

## 📦 Installation

```bash
npm install your-package@1.2.0
```

## 🔄 Upgrade from v1.1.0

1. Update package:
   ```bash
   npm update your-package
   ```

2. Update configuration:
   - OAuth2 configuration required (see docs/oauth-setup.md)
   - Dark mode is enabled by default (can be disabled in settings)

3. No breaking changes

## 🔗 Links

- [Full Changelog](https://github.com/owner/repo/compare/v1.1.0...v1.2.0)
- [Documentation](https://docs.example.com/v1.2.0)
- [Installation Guide](https://docs.example.com/installation)

---

**Full Changelog**: https://github.com/owner/repo/compare/v1.1.0...v1.2.0
```

### Example: Patch Release (v1.2.1)

```markdown
# v1.2.1

Release Date: 2025-11-17

## Bug Fix Release

This patch release fixes critical bugs found in v1.2.0.

## 🐛 Bug Fixes

- **Critical:** Fix OAuth2 token refresh (#470) @contributor1
- **High:** Resolve dark mode flickering (#471) @contributor2
- **Medium:** Correct CSV export encoding (#472) @contributor3

## 📦 Installation

```bash
npm install your-package@1.2.1
```

## 🔄 Upgrade from v1.2.0

```bash
npm update your-package
```

No configuration changes required.

---

**Full Changelog**: https://github.com/owner/repo/compare/v1.2.0...v1.2.1
```

### Example: Breaking Change Release (v2.0.0)

```markdown
# v2.0.0

Release Date: 2025-12-01

## ⚠️ BREAKING CHANGES

This is a major release with breaking changes. Please read the
upgrade guide carefully before updating.

## 💥 Breaking Changes

- **API Endpoints:** All API endpoints now require authentication (#500)
  - Migration: Add authentication to all API calls
  - See: docs/migration-v2.md

- **Configuration Format:** New configuration format (#501)
  - Migration: Run `npm run migrate-config` to update
  - Old config files are automatically backed up

- **Minimum Requirements:** Node.js 18+ required (#502)
  - Update Node.js to version 18 or higher

## 🚀 Features

- New authentication system (#500)
- Improved configuration management (#501)
- Better error handling (#503)

## 🐛 Bug Fixes

- Multiple bug fixes (see full changelog)

## 📦 Installation

```bash
npm install your-package@2.0.0
```

## 🔄 Upgrade from v1.x

**IMPORTANT:** Follow these steps in order:

1. **Backup your data:**
   ```bash
   npm run backup
   ```

2. **Check Node.js version:**
   ```bash
   node --version  # Must be 18+
   ```

3. **Update package:**
   ```bash
   npm install your-package@2.0.0
   ```

4. **Migrate configuration:**
   ```bash
   npm run migrate-config
   ```

5. **Update API calls:**
   - Add authentication to all API requests
   - See docs/migration-v2.md for details

6. **Test thoroughly:**
   - Run your test suite
   - Test in staging environment

## 📚 Migration Guide

Full migration guide: [docs/migration-v2.md](docs/migration-v2.md)

## 🙏 Contributors

@contributor1, @contributor2, @contributor3...

---

**Full Changelog**: https://github.com/owner/repo/compare/v1.2.1...v2.0.0
```

## Auto-Version Detection

### Semantic Versioning Rules

```
Commits since last release:

feat: Add OAuth2 support                    → Minor bump
fix: Resolve login bug                       → Patch bump
feat!: Change API authentication (BREAKING)  → Major bump

Result: Major version bump (due to breaking change)
Suggested version: v2.0.0
```

### Version Bump Logic

```javascript
function determineVersion(commits) {
  let hasMajor = false;
  let hasMinor = false;
  let hasPatch = false;

  commits.forEach(commit => {
    if (commit.includes('BREAKING') || commit.includes('!:')) {
      hasMajor = true;
    } else if (commit.startsWith('feat')) {
      hasMinor = true;
    } else if (commit.startsWith('fix')) {
      hasPatch = true;
    }
  });

  if (hasMajor) return 'major';
  if (hasMinor) return 'minor';
  if (hasPatch) return 'patch';
  return 'patch'; // default
}

// Example:
// Current: v1.2.3
// Changes: feat, fix
// Next: v1.3.0 (minor bump)
```

## Release Workflow

### Manual Release

```bash
# 1. Determine next version
/github/auto-release

Output:
Analyzing commits since v1.2.0...
Found: 5 features, 3 fixes, 0 breaking changes
Suggested version: v1.3.0 (minor bump)

# 2. Review and confirm
/github/auto-release v1.3.0 --draft

Output:
Created draft release: v1.3.0
URL: https://github.com/owner/repo/releases/tag/v1.3.0
Review and publish when ready.

# 3. Publish
# (via GitHub UI or)
/github/publish-release v1.3.0
```

### Automated Release

Configure GitHub Actions:

```yaml
name: Auto Release

on:
  push:
    branches: [main]

jobs:
  release:
    if: startsWith(github.event.head_commit.message, 'chore: release')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Determine Version
        id: version
        run: |
          VERSION=$(claude /github/auto-release --detect-only)
          echo "version=$VERSION" >> $GITHUB_OUTPUT

      - name: Create Release
        run: |
          claude /github/auto-release ${{ steps.version.outputs.version }}

      - name: Notify
        run: |
          # Notify team via Slack, email, etc.
          echo "Released ${{ steps.version.outputs.version }}"
```

## Custom Release Templates

### Template File

Create `templates/release-template.md`:

```markdown
# ${version}

Release Date: ${date}

${summary}

${breaking_changes}

${features}

${bug_fixes}

${performance}

${documentation}

${maintenance}

## Statistics

${statistics}

## Contributors

${contributors}

## Installation

\`\`\`bash
${installation_command}
\`\`\`

## Upgrade Guide

${upgrade_instructions}

${footer}
```

### Template Variables

Available variables:
- `${version}` - Release version
- `${date}` - Release date
- `${summary}` - Auto-generated summary
- `${breaking_changes}` - Breaking changes section
- `${features}` - Features list
- `${bug_fixes}` - Bug fixes list
- `${performance}` - Performance improvements
- `${documentation}` - Documentation changes
- `${maintenance}` - Maintenance changes
- `${statistics}` - PR/commit/contributor stats
- `${contributors}` - Contributors list
- `${installation_command}` - Installation command
- `${upgrade_instructions}` - Upgrade guide
- `${footer}` - Custom footer

## Advanced Features

### Breaking Change Detection

Automatically detect breaking changes:

```javascript
// From commit messages
feat!: Change API authentication
// or
feat: Change API (BREAKING CHANGE: All endpoints require auth)

// From PR labels
labels: ["breaking-change"]

// From PR body
## Breaking Changes
- All API endpoints now require authentication
```

### Asset Building

Build and attach release assets:

```json
{
  "assets": {
    "enabled": true,
    "build-command": "npm run build:production",
    "files": [
      {
        "path": "dist/bundle.js",
        "name": "bundle.js",
        "label": "Production Bundle"
      },
      {
        "path": "dist/bundle.min.js",
        "name": "bundle.min.js",
        "label": "Minified Bundle"
      }
    ],
    "checksums": {
      "enabled": true,
      "algorithms": ["sha256", "sha512"]
    }
  }
}
```

### Release Channels

Support multiple release channels:

```json
{
  "channels": {
    "stable": {
      "branch": "main",
      "tag-pattern": "v*.*.*",
      "prerelease": false
    },
    "beta": {
      "branch": "beta",
      "tag-pattern": "v*.*.*-beta.*",
      "prerelease": true
    },
    "alpha": {
      "branch": "develop",
      "tag-pattern": "v*.*.*-alpha.*",
      "prerelease": true
    }
  }
}
```

## Examples

### Create Feature Release

```bash
/github/auto-release

Output:
📦 Auto Release

Analyzing changes since v1.2.0...

Changes found:
  - 5 features
  - 3 bug fixes
  - 2 performance improvements
  - 0 breaking changes

Suggested version: v1.3.0 (minor bump)

Proceed with release? [y/N]: y

Creating release v1.3.0...
  ✓ Generated changelog
  ✓ Created git tag
  ✓ Pushed to GitHub
  ✓ Created GitHub release
  ✓ Notified #releases channel

Release published: https://github.com/owner/repo/releases/tag/v1.3.0
```

### Create Hotfix Release

```bash
/github/auto-release v1.2.1

Output:
📦 Creating hotfix release v1.2.1

Changes since v1.2.0:
  - 2 critical bug fixes
  - 0 features

Creating patch release...
  ✓ Generated changelog
  ✓ Created git tag v1.2.1
  ✓ Created GitHub release
  ✓ Marked as hotfix release
  ✓ Notified on-call team

Hotfix published: https://github.com/owner/repo/releases/tag/v1.2.1
```

### Create Pre-Release

```bash
/github/auto-release v2.0.0-beta.1 --prerelease

Output:
📦 Creating pre-release v2.0.0-beta.1

Changes since v1.3.0:
  - 1 breaking change
  - 3 features
  - 2 bug fixes

Creating pre-release...
  ✓ Generated changelog with breaking changes section
  ✓ Created git tag v2.0.0-beta.1
  ✓ Created GitHub pre-release
  ✓ Added "Breaking Changes" warning
  ✓ Published to beta channel

Beta release published: https://github.com/owner/repo/releases/tag/v2.0.0-beta.1

Warning: This is a pre-release with breaking changes.
See migration guide before upgrading.
```

## Best Practices

1. **Conventional Commits**: Use conventional commit format
2. **Label PRs**: Label PRs for accurate categorization
3. **Document Breaking Changes**: Always document in PR
4. **Test Before Release**: Run full test suite
5. **Review Draft**: Create draft first, review, then publish
6. **Semantic Versioning**: Follow semver strictly

## Troubleshooting

### No Changes Detected

```bash
# Check commits since last tag
git log $(git describe --tags --abbrev=0)..HEAD --oneline

# If no meaningful commits, create patch release
/github/auto-release v1.2.1 --empty
```

### Wrong Version Suggested

```bash
# Override auto-detection
/github/auto-release v2.0.0  # Manual version

# Or adjust rules in config
{
  "versioning": {
    "increment-rules": {
      "major": ["breaking", "BREAKING CHANGE"],
      "minor": ["feat", "feature"],
      "patch": ["fix", "patch"]
    }
  }
}
```

## Related Commands

- `/github/create-pr` - Create pull request
- `/github/merge-pr` - Merge pull request
- `/workflow/checkpoint` - Create checkpoint before release
- `/development/test-agent` - Run tests before release

## See Also

- Semantic versioning specification
- Conventional commits format
- Release management best practices
- Changelog format standards

---

**Command Type:** GitHub Automation
**Agent Used:** release-agent
**Requires:** GitHub integration, git tags, commit history
**Version:** 1.0.0

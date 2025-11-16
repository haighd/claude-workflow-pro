# Security Policy

## Overview

The security of Claude Workflow Pro is a top priority. This document outlines our security policy, how to report vulnerabilities, and what to expect from the security process.

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          | Notes                          |
| ------- | ------------------ | ------------------------------ |
| 0.1.x   | :white_check_mark: | Current development version    |
| < 0.1   | :x:                | Pre-release, not supported     |

Once version 1.0 is released, we will support:
- Current major version
- Previous major version (for 6 months after new release)

## Security Considerations

### Plugin Security Model

Claude Workflow Pro is a plugin for Claude Code that:

1. **Operates in the Claude Code sandbox** - Inherits Claude Code's security model
2. **Executes bash commands** - Via Claude Code's Bash tool (requires user approval)
3. **Accesses local files** - Only through Claude Code's file tools
4. **Makes API calls** - Uses GitHub CLI for GitHub integration (requires authentication)
5. **No external dependencies** - Pure Markdown/YAML plugin with no npm packages

### What This Plugin Does

**Safe Operations:**
- Reads and writes files in your project directory
- Executes git commands for version control
- Calls GitHub CLI (`gh`) for GitHub integration
- Creates documentation and checkpoint files
- Analyzes code using static analysis

**Potentially Sensitive Operations:**
- Executes shell commands (requires Claude Code approval)
- Accesses GitHub repositories (requires `gh` authentication)
- Reads configuration files (may contain sensitive settings)
- Creates commits and pushes to GitHub (user-controlled)

### What This Plugin Does NOT Do

- Install or execute arbitrary code from the internet
- Access files outside your project directory
- Store or transmit data to external servers (beyond GitHub)
- Require npm packages or external dependencies
- Execute commands without Claude Code's approval system
- Access environment variables or system credentials directly

## Reporting a Vulnerability

### How to Report

If you discover a security vulnerability, please follow these steps:

1. **DO NOT** open a public GitHub issue
2. **DO NOT** disclose the vulnerability publicly until it has been addressed
3. **DO** report it privately using one of these methods:

   **Preferred**: Use GitHub Security Advisories
   - Go to https://github.com/yourusername/claude-workflow-pro/security/advisories/new
   - Fill out the security advisory form
   - Click "Submit report"

   **Alternative**: Email the maintainer
   - Email: [INSERT SECURITY EMAIL]
   - Subject: "Security Vulnerability in Claude Workflow Pro"
   - Include details as outlined below

### What to Include

Please include as much information as possible:

1. **Vulnerability Type**
   - Command injection
   - Path traversal
   - Information disclosure
   - Unauthorized access
   - Other (please describe)

2. **Affected Components**
   - Which command(s) or agent(s)
   - Which files or functions
   - Configuration settings involved

3. **Impact Assessment**
   - What could an attacker do?
   - What data could be accessed or modified?
   - What systems could be compromised?
   - Are there prerequisites (user actions, configurations)?

4. **Reproduction Steps**
   - Minimal steps to reproduce
   - Example commands or payloads
   - Required setup or configuration
   - Expected vs actual behavior

5. **Proof of Concept**
   - Code snippets (if applicable)
   - Screenshots or recordings (if helpful)
   - Sample malicious input
   - Environment details

6. **Suggested Remediation** (optional)
   - How you think it should be fixed
   - Alternative approaches
   - Mitigation strategies

### Example Report

```markdown
**Vulnerability Type**: Command Injection

**Affected Component**: /github/create-issue command

**Impact**: An attacker could execute arbitrary shell commands by crafting
a malicious issue title with shell metacharacters.

**Reproduction**:
1. Run: /github/create-issue
2. Enter title: `Test"; rm -rf /; echo "`
3. The command is executed without proper escaping

**Suggested Fix**: Properly escape shell metacharacters in issue titles
before passing to gh CLI, or use gh's --body-file option to avoid shell
interpolation.
```

## Response Process

### Timeline

- **24 hours**: Initial response acknowledging receipt
- **72 hours**: Initial assessment and severity classification
- **7 days**: Detailed response with planned fix timeline
- **30 days**: Security patch released (for critical/high severity)
- **90 days**: Public disclosure (after patch is available)

### Severity Levels

We use CVSS 3.1 for severity classification:

- **Critical (9.0-10.0)**: Immediate action, patch within 7 days
- **High (7.0-8.9)**: Urgent attention, patch within 30 days
- **Medium (4.0-6.9)**: Important, patch within 60 days
- **Low (0.1-3.9)**: Minor, patch in next minor release

### What to Expect

1. **Acknowledgment**: We'll confirm receipt of your report
2. **Assessment**: We'll evaluate severity and impact
3. **Fix Development**: We'll develop and test a fix
4. **Coordinated Disclosure**: We'll coordinate release timing with you
5. **Credit**: We'll credit you in the security advisory (if desired)
6. **Public Disclosure**: We'll publish advisory after patch is available

## Security Updates

### How to Stay Informed

- **GitHub Security Advisories**: https://github.com/yourusername/claude-workflow-pro/security/advisories
- **Release Notes**: Check CHANGELOG.md for security fixes
- **GitHub Releases**: Watch the repository for release notifications

### Applying Updates

When a security update is released:

1. Update your local copy:
   ```bash
   cd ~/.claude-plugins/claude-workflow-pro
   git pull
   ```

2. Restart Claude Code to load the updated plugin

3. Review the security advisory for any additional steps

## Security Best Practices

### For Users

1. **Keep the plugin updated**
   - Check for updates regularly
   - Read security advisories
   - Update promptly when patches are available

2. **Review commands before execution**
   - Understand what commands will do
   - Check generated shell commands
   - Use Claude Code's approval system

3. **Protect sensitive data**
   - Don't commit credentials to git
   - Use `.gitignore` for sensitive files
   - Review changes before pushing to GitHub

4. **Use GitHub CLI securely**
   - Authenticate with tokens, not passwords
   - Use minimal required permissions
   - Review `gh` commands before approval

5. **Configuration security**
   - Don't put secrets in `.claude-plugin-config.json`
   - Use environment variables for sensitive data
   - Don't commit config files with credentials

### For Contributors

1. **Validate all inputs**
   - Escape shell metacharacters
   - Validate file paths
   - Sanitize user input

2. **Avoid command injection**
   - Use parameterized commands
   - Quote variables properly
   - Avoid `eval` and similar constructs

3. **Respect file boundaries**
   - Stay within project directory
   - Validate paths before access
   - Check for path traversal attempts

4. **Handle errors securely**
   - Don't leak sensitive data in errors
   - Log security-relevant events
   - Fail securely (deny by default)

5. **Review dependencies**
   - This plugin has no npm dependencies
   - Keep it that way unless absolutely necessary
   - Audit any future dependencies carefully

## Security Checklist

### When Adding New Commands

- [ ] Input validation implemented
- [ ] Shell commands properly escaped
- [ ] File paths validated
- [ ] Error handling doesn't leak sensitive data
- [ ] User approval required for sensitive operations
- [ ] Documentation includes security considerations
- [ ] Tested with malicious inputs

### When Adding GitHub Integration

- [ ] Uses `gh` CLI (not direct API calls)
- [ ] Requires user authentication
- [ ] Validates repository access
- [ ] Doesn't expose tokens or credentials
- [ ] Respects GitHub rate limits
- [ ] Handles errors gracefully

### When Adding File Operations

- [ ] Validates file paths
- [ ] Prevents path traversal
- [ ] Stays within project boundaries
- [ ] Checks file permissions
- [ ] Handles symlinks safely
- [ ] Doesn't overwrite critical files

## Known Security Limitations

### By Design

1. **Requires user trust in Claude Code**
   - This plugin inherits Claude Code's security model
   - Users must trust Claude Code's sandbox

2. **Executes shell commands**
   - Some operations require bash execution
   - Users must review and approve commands

3. **GitHub access required**
   - GitHub features need `gh` CLI authentication
   - Users must manage their own credentials

4. **Local file system access**
   - Plugin can read/write files in project directory
   - Users should understand file operations

### Not Security Issues

The following are intentional design decisions, not vulnerabilities:

- Executing git commands (required for version control)
- Creating and modifying files in project directory (core functionality)
- Calling GitHub CLI (required for GitHub integration)
- Reading configuration files (required for plugin configuration)

## Incident Response

If a security incident occurs:

1. **Immediate**: Assess scope and impact
2. **Within 24h**: Notify affected users (if possible)
3. **Within 72h**: Release emergency patch
4. **Within 7d**: Publish detailed post-mortem
5. **Ongoing**: Implement preventive measures

## Contact

- **Security Issues**: Use GitHub Security Advisories (preferred)
- **General Security Questions**: Open a GitHub Discussion
- **Private Disclosures**: [INSERT SECURITY EMAIL]

## Recognition

We appreciate security researchers who responsibly disclose vulnerabilities:

- Credit in security advisories (opt-in)
- Recognition in CHANGELOG.md
- Contributor acknowledgment in repository

Thank you for helping keep Claude Workflow Pro secure!

---

**Last Updated**: 2025-11-15
**Next Review**: 2025-12-15

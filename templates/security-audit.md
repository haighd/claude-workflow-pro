# Security Audit Workflow Template

This template provides a comprehensive approach to security audits and vulnerability remediation.

## Template Variables

Replace these placeholders when using this template:

- `{{AUDIT_NAME}}` - Name of the security audit
- `{{SCOPE}}` - full-application/component/feature
- `{{URGENCY}}` - routine/elevated/critical
- `{{AUDITOR}}` - Person conducting audit

## Phase 1: Planning

### 1.1 Define Audit Scope
```bash
# Create audit plan
Create: docs/security/{{AUDIT_NAME}}-scope.md

Define:
- Components in scope
- Components out of scope
- Specific concerns/threats
- Compliance requirements
- Timeline
```

### 1.2 Gather Context
```bash
# Understand the system
/research/architecture-agent

Task: Analyze security-relevant architecture

Focus on:
- Data flows
- Authentication/authorization
- External integrations
- Sensitive data handling
- API endpoints
- User input points
```

### 1.3 Review Threat Model
```bash
# Identify threats
Threat categories:
- [ ] Injection attacks (SQL, NoSQL, Command, LDAP)
- [ ] Authentication/authorization flaws
- [ ] Sensitive data exposure
- [ ] XML external entities (XXE)
- [ ] Broken access control
- [ ] Security misconfiguration
- [ ] Cross-site scripting (XSS)
- [ ] Insecure deserialization
- [ ] Using components with vulnerabilities
- [ ] Insufficient logging/monitoring
- [ ] CSRF attacks
- [ ] Server-side request forgery (SSRF)
```

## Phase 2: Automated Scanning

### 2.1 Dependency Vulnerability Scan
```bash
# Scan for known vulnerabilities in dependencies
npm audit
# or
pip-audit
# or
bundle audit
# or
composer audit

# Document findings
npm audit --json > security/{{AUDIT_NAME}}-npm-audit.json
```

### 2.2 Static Analysis
```bash
# Run static security analysis
# For JavaScript/TypeScript
npx eslint . --ext .js,.ts --config .eslintrc-security.js

# For Python
bandit -r . -f json -o security/{{AUDIT_NAME}}-bandit.json

# For Go
gosec ./...

# For general purpose
semgrep --config=auto .
```

### 2.3 Secret Scanning
```bash
# Scan for exposed secrets
# Using gitleaks
gitleaks detect --source . --report-path security/{{AUDIT_NAME}}-secrets.json

# Using trufflehog
trufflehog filesystem . --json > security/{{AUDIT_NAME}}-trufflehog.json

# Manual review of:
- Environment variables
- Configuration files
- Code comments
- Test files
- Documentation
```

### 2.4 License Compliance
```bash
# Check for license issues
npx license-checker --json > security/{{AUDIT_NAME}}-licenses.json

# Review for:
- GPL violations
- Incompatible licenses
- Unknown licenses
- Deprecated packages
```

## Phase 3: Manual Code Review

### 3.1 Authentication Review
```bash
# Review authentication implementation
/development/security-audit

Focus: Authentication mechanisms

Check for:
- Weak password policies
- Insecure password storage
- Missing multi-factor authentication
- Session management issues
- Token generation/validation
- OAuth/SAML implementation
- Brute force protection
```

### 3.2 Authorization Review
```bash
# Review authorization logic
/development/security-audit

Focus: Access control

Check for:
- Broken access control
- Privilege escalation
- Insecure direct object references
- Missing function-level access control
- CORS misconfiguration
- API authorization
```

### 3.3 Input Validation Review
```bash
# Review all input handling
/development/security-audit

Focus: Input validation

Check for:
- SQL injection
- NoSQL injection
- Command injection
- LDAP injection
- XPath injection
- Path traversal
- XML injection
- Template injection
```

### 3.4 Output Encoding Review
```bash
# Review output handling
/development/security-audit

Focus: Output encoding

Check for:
- Cross-site scripting (XSS)
- HTML injection
- JavaScript injection
- CSS injection
- HTTP header injection
- URL redirection flaws
```

### 3.5 Cryptography Review
```bash
# Review cryptographic implementations
/development/security-audit

Focus: Cryptography

Check for:
- Weak algorithms (MD5, SHA1, DES)
- Hardcoded keys/secrets
- Insufficient key lengths
- Improper IV usage
- Weak random number generation
- Insecure certificate validation
- Missing encryption for sensitive data
```

### 3.6 Data Protection Review
```bash
# Review data handling
/development/security-audit

Focus: Sensitive data

Check for:
- PII exposure
- Sensitive data in logs
- Insecure data transmission
- Missing encryption at rest
- Insufficient data retention policies
- Cache poisoning
- Information leakage
```

## Phase 4: Dynamic Testing

### 4.1 API Security Testing
```bash
# Test API endpoints
Tools: Postman, Burp Suite, OWASP ZAP

Test for:
- Authentication bypass
- Authorization flaws
- Rate limiting
- Input validation
- Error handling
- API versioning issues
```

### 4.2 Web Application Testing
```bash
# Test web interface
Tools: OWASP ZAP, Burp Suite

Test for:
- XSS vulnerabilities
- CSRF vulnerabilities
- Clickjacking
- Security headers
- Cookie security
- Form validation
```

### 4.3 Network Security Testing
```bash
# Test network layer
Tools: nmap, Wireshark

Test for:
- Open ports
- Insecure protocols
- SSL/TLS configuration
- Certificate validation
- Network segmentation
```

## Phase 5: Infrastructure Review

### 5.1 Configuration Review
```bash
# Review infrastructure configuration
Check:
- Server hardening
- Database configuration
- Firewall rules
- Network segmentation
- Cloud security groups
- Container security
- Kubernetes policies
```

### 5.2 Deployment Security
```bash
# Review deployment processes
Check:
- CI/CD pipeline security
- Secret management
- Build artifact integrity
- Deployment authentication
- Rollback procedures
```

### 5.3 Monitoring and Logging
```bash
# Review security monitoring
Check:
- Security event logging
- Log retention
- Intrusion detection
- Anomaly detection
- Alert thresholds
- Incident response procedures
```

## Phase 6: Documentation

### 6.1 Create Findings Report
```bash
# Document all findings
Create: docs/security/{{AUDIT_NAME}}-findings.md

For each finding:
- Title and description
- Severity (Critical/High/Medium/Low)
- CWE/CVE reference
- Affected components
- Proof of concept
- Remediation recommendations
- Timeline for fix
```

### 6.2 Prioritize Findings
```bash
# Risk-based prioritization
Factors:
- Severity of vulnerability
- Ease of exploitation
- Potential impact
- Affected users/data
- Public exposure
- Compliance requirements

Priority levels:
- P0: Critical - Fix immediately
- P1: High - Fix within 1 week
- P2: Medium - Fix within 1 month
- P3: Low - Fix when convenient
```

### 6.3 Create Remediation Plan
```bash
/workflow/create-plan

Plan name: {{AUDIT_NAME}}-remediation
Description: Address security findings from {{AUDIT_NAME}}

Tasks (ordered by priority):
1. [ ] P0 findings: [list]
2. [ ] P1 findings: [list]
3. [ ] P2 findings: [list]
4. [ ] P3 findings: [list]
5. [ ] Verification testing
6. [ ] Documentation updates
```

## Phase 7: Remediation

### 7.1 Fix Critical Issues
```bash
# Address P0/P1 issues immediately
For each critical finding:

1. Create hotfix branch:
   git checkout -b security/{{finding-id}}

2. Implement fix:
   /development/code-with-agent
   Task: Fix security vulnerability {{finding-id}}

3. Test fix:
   - Verify vulnerability fixed
   - Ensure no regression
   - Add security test

4. Fast-track review:
   /github/create-pr
   Labels: security, critical, fast-track
```

### 7.2 Security Testing
```bash
# Verify fixes
For each fix:
1. Reproduce original vulnerability
2. Verify fix prevents exploitation
3. Test edge cases
4. Add regression test

# Re-run automated scans
npm audit
semgrep --config=auto .
```

### 7.3 Deploy Fixes
```bash
# Prioritized deployment
Critical fixes:
- Emergency deployment
- Minimal review cycle
- Monitor closely post-deployment

High priority fixes:
- Next deployment cycle
- Standard review
- Coordinate with team

Medium/Low priority:
- Regular sprint cycle
- Bundle with other changes
```

## Phase 8: Verification

### 8.1 Re-test Vulnerabilities
```bash
# Verify all findings addressed
Verification checklist:
- [ ] All P0 findings fixed
- [ ] All P1 findings fixed
- [ ] All P2 findings scheduled/fixed
- [ ] All P3 findings scheduled
- [ ] Fixes verified by retesting
- [ ] No new vulnerabilities introduced
```

### 8.2 Re-run Automated Scans
```bash
# Full scan after remediation
npm audit
semgrep --config=auto .
gitleaks detect --source .

# Compare to initial scan:
- Vulnerabilities before: [count]
- Vulnerabilities after: [count]
- Reduction: [percentage]
```

### 8.3 External Validation
```bash
# For critical systems
Consider:
- Third-party penetration test
- Bug bounty program
- Security consultant review
- Compliance audit
```

## Phase 9: Preventive Measures

### 9.1 Update Development Practices
```bash
# Prevent future vulnerabilities
Actions:
- [ ] Update coding guidelines
- [ ] Add pre-commit security hooks
- [ ] Implement security linting
- [ ] Add security testing to CI/CD
- [ ] Create security checklist for PRs
```

### 9.2 Developer Training
```bash
# Knowledge sharing
Training topics:
- OWASP Top 10
- Secure coding practices
- Common vulnerabilities
- Security tools usage
- Incident response

Format:
- Team workshops
- Documentation
- Code review emphasis
- Pair programming
```

### 9.3 Continuous Monitoring
```bash
# Ongoing security
Implement:
- Automated dependency scanning
- Regular security audits (quarterly)
- Security metrics tracking
- Vulnerability disclosure process
- Bug bounty program (optional)
```

## Phase 10: Reporting

### 10.1 Executive Summary
```bash
# Create summary for stakeholders
Create: docs/security/{{AUDIT_NAME}}-summary.md

Include:
- Audit scope and methodology
- Key findings (high-level)
- Remediation status
- Residual risk
- Recommendations
- Next steps
```

### 10.2 Technical Report
```bash
# Detailed technical report
Create: docs/security/{{AUDIT_NAME}}-report.md

Include:
- Detailed findings
- Technical analysis
- Proof of concept
- Remediation details
- Test results
- Tool outputs
```

### 10.3 Compliance Documentation
```bash
# For compliance requirements
Document:
- Audit methodology
- Tools used
- Findings and remediation
- Control effectiveness
- Evidence/artifacts

Standards:
- SOC 2
- ISO 27001
- PCI DSS
- HIPAA
- GDPR
```

## Security Audit Checklist

### Authentication & Authorization
- [ ] Password strength requirements
- [ ] Password storage (hashing + salt)
- [ ] Multi-factor authentication
- [ ] Session management
- [ ] Token security
- [ ] OAuth/SAML implementation
- [ ] Access control enforcement
- [ ] Privilege escalation prevention

### Input Validation
- [ ] SQL injection prevention
- [ ] NoSQL injection prevention
- [ ] Command injection prevention
- [ ] Path traversal prevention
- [ ] XML injection prevention
- [ ] LDAP injection prevention
- [ ] Input sanitization
- [ ] File upload validation

### Output Encoding
- [ ] XSS prevention
- [ ] HTML encoding
- [ ] JavaScript encoding
- [ ] URL encoding
- [ ] JSON encoding
- [ ] HTTP header validation

### Cryptography
- [ ] Strong algorithms
- [ ] Sufficient key lengths
- [ ] Secure key storage
- [ ] Proper IV usage
- [ ] Random number generation
- [ ] Certificate validation
- [ ] TLS configuration

### Data Protection
- [ ] Encryption at rest
- [ ] Encryption in transit
- [ ] PII handling
- [ ] Sensitive data in logs
- [ ] Data retention
- [ ] Secure deletion
- [ ] Cache security

### Configuration
- [ ] Security headers
- [ ] Cookie security
- [ ] CORS configuration
- [ ] Error handling
- [ ] Debug mode disabled
- [ ] Default credentials changed
- [ ] Unnecessary services disabled

### Infrastructure
- [ ] Server hardening
- [ ] Network segmentation
- [ ] Firewall configuration
- [ ] Patch management
- [ ] Backup security
- [ ] Disaster recovery

### Monitoring
- [ ] Security logging
- [ ] Log integrity
- [ ] Intrusion detection
- [ ] Anomaly detection
- [ ] Incident response plan
- [ ] Alert procedures

## Severity Definitions

### Critical (P0)
```
Immediate threat to system/data security
Examples:
- Remote code execution
- SQL injection with data access
- Authentication bypass
- Exposed secrets/credentials

Response: Fix within 24 hours
```

### High (P1)
```
Significant security risk
Examples:
- XSS vulnerabilities
- Authorization flaws
- Sensitive data exposure
- Weak cryptography

Response: Fix within 1 week
```

### Medium (P2)
```
Moderate security concern
Examples:
- CSRF vulnerabilities
- Information disclosure
- Security misconfiguration
- Outdated dependencies (no exploit)

Response: Fix within 1 month
```

### Low (P3)
```
Minor security issue
Examples:
- Missing security headers
- Verbose error messages
- Low-impact information disclosure
- Best practice violations

Response: Fix when convenient
```

## Common Vulnerabilities

### SQL Injection
```bash
# Vulnerable
query = f"SELECT * FROM users WHERE id = {user_id}"

# Secure
query = "SELECT * FROM users WHERE id = ?"
cursor.execute(query, (user_id,))
```

### Cross-Site Scripting (XSS)
```bash
# Vulnerable
output = f"<div>{user_input}</div>"

# Secure
from html import escape
output = f"<div>{escape(user_input)}</div>"
```

### Authentication Issues
```bash
# Vulnerable
if password == stored_password:  # Plain text comparison

# Secure
import bcrypt
if bcrypt.checkpw(password.encode(), stored_hash):
```

### Insecure Cryptography
```bash
# Vulnerable
hash = hashlib.md5(data).hexdigest()

# Secure
hash = hashlib.sha256(data).hexdigest()
# Or better: use bcrypt/scrypt/argon2 for passwords
```

## Tools Reference

### Automated Scanners
- **npm audit** - Node.js dependency scanner
- **pip-audit** - Python dependency scanner
- **Snyk** - Comprehensive dependency scanner
- **OWASP Dependency-Check** - Dependency vulnerability scanner

### Static Analysis
- **Semgrep** - Multi-language static analysis
- **Bandit** - Python security linter
- **ESLint** - JavaScript/TypeScript linter
- **Gosec** - Go security checker
- **SonarQube** - Code quality and security

### Secret Detection
- **Gitleaks** - Secret scanner
- **TruffleHog** - Secret scanner
- **git-secrets** - AWS secret prevention

### Dynamic Testing
- **OWASP ZAP** - Web application scanner
- **Burp Suite** - Security testing platform
- **Postman** - API testing
- **SQLMap** - SQL injection testing

### Infrastructure
- **Nmap** - Network scanner
- **OpenVAS** - Vulnerability scanner
- **Nessus** - Vulnerability scanner
- **CIS-CAT** - Configuration assessment

## Quick Reference

```bash
# Automated scanning
npm audit
semgrep --config=auto .
gitleaks detect --source .

# Manual review
/development/security-audit

# Create plan
/workflow/create-plan

# Fix vulnerabilities
/development/code-with-agent

# Verify fixes
Re-run scans + manual testing

# Document
Create security report
Update CHANGELOG
```

## Related Templates

- `bug-fix.md` - For security bug fixes
- `incident-response.md` - For security incidents
- `compliance-audit.md` - For compliance reviews
- `penetration-test.md` - For pen testing

---

**Template Version:** 1.0.0
**Last Updated:** 2025-11-16
**Maintained By:** Claude Workflow Pro Team

**References:**
- OWASP Top 10
- CWE/SANS Top 25
- NIST Cybersecurity Framework
- ISO 27001/27002

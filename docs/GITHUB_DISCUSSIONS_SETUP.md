# GitHub Discussions Setup Guide

This guide explains how to set up and manage GitHub Discussions for Claude Workflow Pro.

## Overview

GitHub Discussions provides a community forum for:
- Asking questions and getting help
- Sharing workflows and use cases
- Proposing new ideas
- Announcing updates
- Building community

## Initial Setup

### 1. Enable Discussions

**Via GitHub UI:**
1. Go to repository Settings
2. Scroll to "Features" section
3. Check "Discussions"
4. Click "Set up discussions"

**First-time setup creates:**
- Welcome discussion (auto-generated)
- Default categories
- Discussion templates

### 2. Configure Categories

**Recommended Categories:**

| Category | Description | Purpose |
|----------|-------------|---------|
| 📢 **Announcements** | Official updates and news | Release notes, feature announcements, important changes |
| 💡 **Ideas** | Feature requests and suggestions | Community-driven feature proposals |
| 🙏 **Q&A** | Questions and answers | Help and support, "How do I...?" questions |
| 🙌 **Show and Tell** | Share your workflows | User stories, examples, creative uses |
| 💬 **General** | General discussion | Community chat, off-topic, introductions |
| 🐛 **Troubleshooting** | Debug and solve issues | Non-bug issues, configuration help |

**Category Settings:**

**Announcements** (📢):
- Format: Announcement
- Enable: ✓ Maintainers can only create discussions
- Emoji: 📢

**Ideas** (💡):
- Format: Open-ended discussion
- Enable: ✓ Anyone can create discussions
- Emoji: 💡
- Labels: `enhancement`, `idea`

**Q&A** (🙏):
- Format: Question/Answer
- Enable: ✓ Anyone can create discussions
- Enable: ✓ Mark answers
- Emoji: 🙏
- Labels: `question`

**Show and Tell** (🙌):
- Format: Open-ended discussion
- Enable: ✓ Anyone can create discussions
- Emoji: 🙌
- Labels: `showcase`

**General** (💬):
- Format: Open-ended discussion
- Enable: ✓ Anyone can create discussions
- Emoji: 💬

**Troubleshooting** (🐛):
- Format: Question/Answer
- Enable: ✓ Anyone can create discussions
- Enable: ✓ Mark answers
- Emoji: 🐛
- Labels: `help wanted`, `troubleshooting`

### 3. Create Welcome Discussion

**Title:** Welcome to Claude Workflow Pro Community! 👋

**Content:**
```markdown
# Welcome to Claude Workflow Pro Community! 👋

We're excited to have you here! This is the place to:

## 🗣️ Connect with the Community

- Ask questions and get help from other users
- Share your workflows and creative uses
- Propose new features and improvements
- Stay updated with announcements

## 📚 Getting Started

New to Claude Workflow Pro? Check out:

- [Quick Start Guide](../README.md#quick-start)
- [Usage Examples](../USAGE.md)
- [Configuration Guide](../CONFIGURATION.md)
- [Example Projects](../examples/)

## 🤝 How to Participate

### Asking Questions

Use the **Q&A** category for:
- "How do I...?" questions
- Configuration help
- Best practices
- Command usage

**Tips for good questions:**
1. Search existing discussions first
2. Provide context about your project
3. Include relevant error messages
4. Mention your Claude Code version
5. Mark helpful answers with ✓

### Sharing Ideas

Use the **Ideas** category for:
- Feature requests
- Workflow improvements
- New command suggestions
- Integration proposals

**Tips for good ideas:**
1. Describe the problem you're solving
2. Explain your proposed solution
3. Consider impact and scope
4. Check roadmap for similar plans

### Show and Tell

Use the **Show and Tell** category for:
- Interesting workflows you've created
- Project showcases using the plugin
- Creative use cases
- Tips and tricks

**We love seeing:**
- Before/after workflow comparisons
- Time savings stories
- Novel uses of commands
- Custom configurations

### Reporting Bugs

**Important:** Use [GitHub Issues](../issues) for bugs, not Discussions.

Discussions are for:
- ✅ Questions and help
- ✅ Ideas and proposals
- ✅ Community chat

Issues are for:
- 🐛 Bug reports
- 📝 Documentation errors
- 🔒 Security vulnerabilities

## 📋 Community Guidelines

Please review our:
- [Code of Conduct](../CODE_OF_CONDUCT.md)
- [Contributing Guide](../CONTRIBUTING.md)
- [Security Policy](../SECURITY.md)

**Key principles:**
- Be respectful and inclusive
- Assume good intentions
- Help others learn
- Stay on topic
- No spam or self-promotion without value

## 🏆 Recognition

We appreciate active community members! Contributors who help others, share knowledge, and improve discussions may be:
- Featured in release notes
- Added to CONTRIBUTORS.md
- Granted maintainer status for exceptional contributions

## 🔔 Stay Updated

- Watch this repository for notifications
- Follow announcements for new releases
- Subscribe to categories you're interested in

## 💬 Start Participating!

Jump into any category and:
- Introduce yourself
- Ask your first question
- Share what you're building
- Help answer someone else's question

Looking forward to building this community together! 🚀

---

**Project Links:**
- [Repository](https://github.com/yourusername/claude-workflow-pro)
- [Documentation](../README.md)
- [Examples](../examples/)
- [Issues](../issues)

**Maintainers:** @yourusername
```

Pin this discussion to the top.

### 4. Create Initial Discussions

**Create these to seed the community:**

**Discussion 1: Share Your Setup** (Show and Tell)
```markdown
# Share Your Setup 🔧

How have you configured Claude Workflow Pro for your project?

Share your:
- Project type (web app, API, library, etc.)
- `.claude-plugin-config.json` setup
- Favorite commands
- Custom workflows
- Tips and tricks

Help others learn from your experience!
```

**Discussion 2: Feature Ideas for v1.1.0** (Ideas)
```markdown
# Feature Ideas for v1.1.0 💡

Now that v1.0.0 is released, we're planning the next version!

What features would you like to see?

**Some ideas we're considering:**
- Additional agent types
- Custom command templates
- Team collaboration features
- CI/CD integrations
- Advanced workflow patterns

**What would help you most?**

Vote with 👍 on ideas you like, or share your own!
```

**Discussion 3: Common Workflows** (General)
```markdown
# Common Workflows 📋

What are your most-used command sequences?

Share the workflows that save you the most time!

**Example:**
```
# My bug fix workflow
/github/next-task  # Get highest priority bug
/github/start-from-issue <number>
/development/debug  # If needed
/development/local-review
/development/commit
```

**What's yours?**
```

### 5. Moderation Settings

**Configure moderation:**
1. Go to Discussions settings
2. Set minimum account age: 0 days (or 7 days if spam is an issue)
3. Enable: ✓ Limit interactions to prior contributors (optional)
4. Enable: ✓ Lock discussions after 90 days of inactivity

**Moderation team:**
- Add maintainers as moderators
- Grant "Maintain" access level minimum
- Define escalation process for violations

### 6. Pinned Discussions

**Pin in this order:**
1. Welcome discussion
2. Release announcements (latest)
3. Feature roadmap or v1.1.0 ideas
4. FAQ (create if needed)

Maximum 4 pinned discussions.

## Discussion Templates

Templates are located in `.github/DISCUSSION_TEMPLATE/`:

**announcements.yml:**
```yaml
labels: [announcement]
```

**ideas.yml:**
```yaml
labels: [enhancement, idea]
```

**q-and-a.yml:**
```yaml
labels: [question]
```

**show-and-tell.yml:**
```yaml
labels: [showcase]
```

## Maintenance

### Weekly Tasks

- [ ] Review new discussions
- [ ] Respond to unanswered questions
- [ ] Mark helpful answers
- [ ] Pin important discussions
- [ ] Unpin outdated content

### Monthly Tasks

- [ ] Review most active discussions
- [ ] Create summary of common questions for FAQ
- [ ] Highlight interesting showcases in announcements
- [ ] Update welcome message if needed
- [ ] Archive or lock old discussions

### Release Tasks

- [ ] Post announcement in Announcements category
- [ ] Update pinned discussions
- [ ] Link to release notes
- [ ] Respond to questions about new features

## Best Practices

### For Maintainers

**Responding to Questions:**
- Respond within 24-48 hours
- Be helpful and encouraging
- Point to documentation when relevant
- Mark as answered when resolved
- Thank people for participation

**Managing Ideas:**
- Label with priority and scope
- Link to relevant issues or PRs
- Update roadmap based on popular requests
- Close with explanation if rejected
- Celebrate implemented ideas

**Moderating Discussions:**
- Enforce Code of Conduct consistently
- Be patient with new users
- Guide off-topic discussions
- Lock heated discussions if needed
- Document moderation decisions

### For Community Members

**Good Discussion Etiquette:**
- Search before posting
- Use appropriate category
- Be specific and detailed
- Follow up on your questions
- Mark answers that help
- Thank those who assist

**Building Community:**
- Welcome new members
- Share knowledge generously
- Upvote helpful content
- Participate regularly
- Stay positive and constructive

## FAQ Creation

Based on discussion trends, create FAQ:

**Location:** Pin in General or create FAQ discussion

**Format:**
```markdown
# Frequently Asked Questions

## Installation & Setup

**Q: Where do I install the plugin?**
A: [Answer with link to docs]

## Configuration

**Q: How do I customize directory structure?**
A: [Answer with example]

## Usage

**Q: What's the difference between /workflow/create-plan and /github/start-from-issue?**
A: [Detailed comparison]

## Troubleshooting

**Q: GitHub commands aren't working**
A: [Common solutions]
```

Update quarterly based on common questions.

## Metrics to Track

**Engagement metrics:**
- Total discussions
- Active participants
- Questions answered
- Upvotes/reactions
- Response time (average)

**Content metrics:**
- Top discussions
- Most helpful answers
- Popular showcases
- Common question themes

**Growth metrics:**
- New participants per month
- Returning participants
- Discussion creation rate
- Answer rate (% questions answered)

## Integration with Issues

**When to convert:**
- Bug reports posted as discussions → Convert to issue
- Feature requests with high upvotes → Create issue
- Security concerns → Direct to security policy

**Linking:**
- Reference issues in discussions
- Reference discussions in PRs
- Link showcases in release notes

## Automation (Optional)

**GitHub Actions for Discussions:**

```yaml
# .github/workflows/discussions.yml
name: Discussion Management

on:
  discussion:
    types: [created]

jobs:
  auto-label:
    runs-on: ubuntu-latest
    steps:
      - name: Auto-label questions
        # Add labels based on content

  welcome:
    runs-on: ubuntu-latest
    steps:
      - name: Welcome new participants
        # Comment on first discussion
```

## Success Criteria

Discussions are successful when:
- ✅ Questions get answered within 48 hours
- ✅ Community members help each other
- ✅ Interesting use cases are shared
- ✅ Feature ideas come from users
- ✅ Positive, welcoming atmosphere
- ✅ Growing participation

## Resources

- [GitHub Discussions Documentation](https://docs.github.com/en/discussions)
- [Community Management Best Practices](https://opensource.guide/building-community/)
- [Moderating Discussions](https://docs.github.com/en/discussions/managing-discussions-for-your-community/moderating-discussions)

---

**Setup Status:** Configured in Phase 11
**Maintainer:** Dan Haight
**Last Updated:** 2025-11-15

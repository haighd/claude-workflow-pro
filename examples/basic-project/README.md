# Basic Project Example

This is the **minimal example** showing the simplest way to use Claude Workflow Pro.

## What's Included

This example demonstrates:
- ✅ Basic plugin configuration
- ✅ Using core workflow commands
- ✅ Simple project structure

## Project Structure

```
basic-project/
├── .claude/
│   └── settings.json          # Optional: Custom settings
├── .claude-plugin-config.json # Plugin configuration
├── src/
│   └── index.js              # Sample source file
├── package.json              # Project metadata
└── README.md                 # This file
```

## Setup Instructions

### 1. Copy Plugin Configuration

```bash
# Copy the plugin config to your project
cp .claude-plugin-config.json /path/to/your/project/
```

### 2. Install Claude Workflow Pro

```bash
# Navigate to your project
cd /path/to/your/project

# Install the plugin (if using marketplace)
claude plugins install claude-workflow-pro

# OR link locally for development
ln -s /path/to/claude-workflow-pro ~/.claude/plugins/claude-workflow-pro
```

### 3. Verify Installation

```bash
# Check available commands
claude --help | grep workflow

# You should see:
# /workflow/init
# /workflow/create-plan
# /workflow/checkpoint
# etc.
```

## Usage Examples

### Initialize a New Workflow

```bash
claude /workflow/init
```

This will:
- Create `.claude/` directory
- Set up initial project structure
- Create a welcome message

### Create a Plan

```bash
claude /workflow/create-plan "Add user authentication"
```

This will:
- Guide you through creating a task plan
- Save the plan to `.claude/plans/`
- Break down the work into manageable tasks

### Create a Checkpoint

```bash
claude /workflow/checkpoint
```

This will:
- Save your current progress
- Document what's been completed
- Note what's next
- Create a checkpoint file in `.claude/sessions/`

## Configuration File

The `.claude-plugin-config.json` file is minimal:

```json
{
  "version": "1.0.0",
  "paths": {
    "tasks": ".claude/tasks",
    "plans": ".claude/plans",
    "sessions": ".claude/sessions",
    "documentation": ".claude/docs"
  },
  "workflow": {
    "autoCheckpoint": false,
    "planTemplate": "default"
  }
}
```

### Key Settings

- **paths**: Where to store workflow files
- **workflow.autoCheckpoint**: Whether to auto-create checkpoints (default: false)
- **workflow.planTemplate**: Which plan template to use (default: "default")

## What You Can Do

With this basic setup, you can:

1. **Plan Your Work**
   - Use `/workflow/create-plan` to break down features
   - Use `/workflow/validate-plan` to review plans
   - Use `/workflow/implement-plan` to execute plans

2. **Track Progress**
   - Use `/workflow/checkpoint` to save progress
   - Use `/workflow/resume-work` to continue from checkpoints

3. **Organize Tasks**
   - Plans are saved in `.claude/plans/`
   - Sessions are saved in `.claude/sessions/`
   - Everything is in markdown for easy reading

## Next Steps

Once you're comfortable with the basics:

1. **Explore More Commands**: See [../web-app](../web-app) for GitHub integration
2. **Add Agents**: See [../api-service](../api-service) for agent system
3. **Customize**: Read [CONFIGURATION.md](../../CONFIGURATION.md) for all options

## Tips

- Start with `/workflow/init` in any new project
- Use `/workflow/create-plan` before starting complex work
- Create checkpoints at natural stopping points
- Keep your `.claude/` directory in git (it's documentation!)

## Learn More

- [Full Documentation](../../README.md)
- [Usage Guide](../../USAGE.md)
- [Configuration Reference](../../CONFIGURATION.md)

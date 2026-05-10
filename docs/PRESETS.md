# Presets

Presets help an agent adapt AI Team to common project types after installation.

Presets live in `.ai/presets/` and are copied into target projects with the rest of `.ai/`.

## Available presets

- `.ai/presets/web-app.md` - frontend or full-stack web applications.
- `.ai/presets/python-cli.md` - Python command-line tools and libraries.
- `.ai/presets/open-source.md` - public GitHub projects.
- `.ai/presets/agent-tooling.md` - tools, prompts, workflows, and infrastructure for agents.

## How to use

After running the init workflow, tell the agent:

```text
Read .ai/presets/<preset>.md and apply the relevant conventions to this project context.
```

The agent should update `.ai/context/project.md`, `.ai/context/stack.md`, and `.ai/context/conventions.md` only after explaining what it plans to change.

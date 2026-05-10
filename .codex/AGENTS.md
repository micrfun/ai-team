# Project Instructions for AI Agents

This project uses the `.ai/` template system. All role definitions, workflows, and templates are in `.ai/`.

## ⚠️ First action on every new task

Check `.ai/context/project.md`:

- If the file contains `AI-TEAM-CONTEXT: NOT_INITIALIZED` → **stop and run the `init` workflow first**. Do not start the user's actual task until context is initialized.
- If filled in → proceed.

The `init` workflow activates the `bootstrap` role, which auto-detects from project files, conducts a short interview (or accepts free-text description), fills `.ai/context/*.md`, and replaces the marker.

**Skip init only if** the user explicitly says so — then answer briefly without using the role system.

## Where to find things

- **Roles**: `.ai/roles/<role>.md`
- **Workflows**: `.ai/workflows/<workflow>.md`
- **Templates**: `.ai/templates/<template>.md`
- **Context**: `.ai/context/{project,stack,conventions}.md`

## At the start of any task (after init)

Read in this order:
1. `.ai/context/project.md`
2. `.ai/context/stack.md`
3. `.ai/context/conventions.md`

## When asked to act as a role
1. Read `.ai/roles/<role>.md`
2. Follow `Principles`, avoid `Anti-patterns`
3. Produce outputs in formats specified
4. Use templates from `.ai/templates/`

## When asked to run a workflow
1. Read `.ai/workflows/<workflow>.md`
2. Execute steps in order
3. Save artifacts to specified paths
4. Stop at human checkpoints

## Available roles
bootstrap, orchestrator, product, ux-designer, architect, engineer, qa, reviewer, security, growth

## Available workflows
init, discovery, plan, implement, review, ship

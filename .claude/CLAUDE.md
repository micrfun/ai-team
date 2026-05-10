# Project Instructions

This project uses the `.ai/` template system for AI-assisted development.

## ⚠️ First action on every new task

**Before doing anything else**, check `.ai/context/project.md`:

- If the file contains the marker `AI-TEAM-CONTEXT: NOT_INITIALIZED` → **stop and run the `init` workflow first**. Do not attempt the user's task until context is initialized.
- If the file is filled in → proceed normally.

The `init` workflow (`.ai/workflows/init.md`) activates the `bootstrap` role, which:
1. Auto-detects what it can from existing project files (`package.json`, `README.md`, etc.)
2. Asks the user a few short questions or accepts a free-text project description
3. Fills in `.ai/context/{project,stack,conventions}.md`
4. Replaces the `NOT_INITIALIZED` marker with `INITIALIZED`

**You may skip init only if** the user explicitly says «just answer this one question» or «skip init» — in that case answer briefly without using the role/workflow system.

## Where to find things

- **Roles**: `.ai/roles/<role>.md`
- **Workflows**: `.ai/workflows/<workflow>.md`
- **Templates**: `.ai/templates/<template>.md`
- **Context**: `.ai/context/{project,stack,conventions}.md`

## How to act

**At the start of any task** (after init):
1. Read `.ai/protocol.md`
2. Read `.ai/workflows/agent-run.md`
3. Read `.ai/context/project.md`
4. Read `.ai/context/stack.md`
5. Read `.ai/context/conventions.md`
6. Read `.ai/state/current.md` if present

**When asked to act as a role**:
1. Read `.ai/roles/<role>.md` fully
2. Follow its `Principles`, avoid `Anti-patterns`
3. Produce outputs in formats specified
4. Use templates from `.ai/templates/`

**When asked to run a workflow**:
1. Read `.ai/workflows/<workflow>.md`
2. Execute steps in order
3. Activate roles as specified
4. Save artifacts to specified paths
5. Stop at human checkpoints

## Subagents

Subagents in `.claude/agents/` are thin wrappers around `.ai/roles/`. Invoke via Task tool, or read the role file and adopt the role yourself.

## Slash commands

Slash commands in `.claude/commands/` map to workflows in `.ai/workflows/`.

## Available roles
bootstrap, orchestrator, product, ux-designer, architect, engineer, qa, reviewer, security, growth

## Available workflows
agent-run, init, discovery, plan, implement, review, ship, update-ai-team

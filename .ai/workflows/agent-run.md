# Workflow: Agent Run

## When to use

Use this at the start of any task handled by any agent.

## Steps

1. **Read protocol**
   - Read `.ai/protocol.md` if present.

2. **Read context**
   - Read `.ai/context/project.md`.
   - Read `.ai/context/stack.md`.
   - Read `.ai/context/conventions.md`.

3. **Read state**
   - Read `.ai/state/current.md` if present.
   - Read `.ai/state/blockers.md` if present.

4. **Detect init requirement**
   - If `.ai/context/project.md` contains `AI-TEAM-CONTEXT: NOT_INITIALIZED`, stop the requested task and run `.ai/workflows/init.md`.

5. **Classify request**
   - `discovery` for unclear product direction.
   - `plan` for a known task that needs specification.
   - `implement` for approved specs.
   - `review` for code/spec review.
   - `ship` for release work.
   - direct role if the user explicitly requested one.

6. **Choose next role or workflow**
   - Prefer existing workflows.
   - Use `orchestrator` when the task spans 3+ roles or has unclear sequencing.

7. **State assumptions**
   - List assumptions before changing files.
   - Ask the user when a missing answer could change architecture, behavior, data, or public API.

8. **Produce or update artifacts**
   - Follow `.ai/templates/*`.
   - Include artifact metadata and lifecycle status.

9. **Update state**
   - Update `.ai/state/current.md`.
   - Update `.ai/state/tasks.md`, `.ai/state/blockers.md`, `.ai/state/risks.md`, or `.ai/state/handoffs.md` when relevant.

10. **Summarize**
   - Changed files.
   - What changed.
   - Open questions.
   - Exact local verification commands.

11. **Stop at checkpoints**
   - Stop for human approval before implementation, release, destructive operations, migrations, and unresolved major scope changes.

## Exit criteria

- The next role or workflow is clear.
- State files reflect the current work.
- Human checkpoint is reached when required.

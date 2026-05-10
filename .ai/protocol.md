# AI Team `.ai/` Protocol

**Protocol version**: 0.2-draft
**Purpose**: Define the portable file protocol used by AI coding agents inside a repository.

AI Team is a file-based coordination layer. Agents communicate through project files, not hidden chat memory or a required runtime service.

## Required directories

```text
.ai/
  protocol.md
  context/
  roles/
  workflows/
  templates/
  state/
```

## Required context files

```text
.ai/context/project.md
.ai/context/stack.md
.ai/context/conventions.md
```

These files describe the stable project context that every role should read before work.

## Required state files

```text
.ai/state/current.md
.ai/state/tasks.md
.ai/state/blockers.md
.ai/state/risks.md
.ai/state/handoffs.md
```

State files describe active work. They are operational notes, not long-term product documentation.

## Artifact directories

AI Team uses these default artifact directories at the repository root:

```text
specs/
decisions/
discovery/
implementation/
qa/
reviews/
evals/
releases/
```

Projects may choose different locations, but the chosen convention must be recorded in `.ai/context/conventions.md`.

## Artifact metadata

Long-lived artifacts should start with:

```markdown
**Status**: draft / reviewed / approved / implemented / tested / shipped / archived
**Owner role**: product / ux-designer / architect / engineer / qa / reviewer / security / orchestrator
**Last updated**: YYYY-MM-DD
**Depends on**:
**Next action**:
```

## Lifecycle statuses

- `draft` - written but not reviewed.
- `reviewed` - checked by another role or human.
- `approved` - accepted for the next workflow step.
- `implemented` - implementation is complete enough for QA/review.
- `tested` - required verification has been performed or delegated to the user.
- `shipped` - released or merged.
- `archived` - kept for history, no longer active.

## Handoff rules

1. A role writes or updates an artifact before handing work to another role.
2. The receiving role reads `.ai/context/*`, `.ai/state/current.md`, and the handoff artifact.
3. The handoff must identify:
   - changed files;
   - open questions;
   - blockers;
   - next expected action.
4. Human checkpoints are required before irreversible operations, releases, migrations, destructive file changes, or scope expansion.

## Update rules

Installers preserve existing files by default. Incoming conflicting files are written with a `.ai-team-new` suffix.

Agents must not merge `.ai-team-new` files automatically unless the user approves the merge plan.

Project-specific files under `.ai/context/` and `.ai/state/` are never safe to blindly overwrite.

## Compatibility

Protocol changes should be additive when possible.

If a future protocol version breaks compatibility, document:

- migration steps;
- changed required files;
- deprecated files;
- required user review points.

# Why Files as Protocol

AI agents often lose coordination when work lives only in chat memory. A different agent, model, tool, or session may not see the same context.

AI Team uses files as the shared protocol.

## Benefits

- **Portable**: any agent that can read files can participate.
- **Auditable**: plans, reviews, state, and decisions remain in the repository.
- **Tool-agnostic**: Claude Code, Codex, Gemini CLI, Cursor, Antigravity, OpenClaw, and other agents can share the same source of truth.
- **Human-readable**: the user can inspect and edit every artifact.
- **No runtime required**: coordination does not depend on a server, task queue, daemon, package manager, or hosted service.

## Trade-offs

- Agents must be instructed to read the right files.
- State files can drift if agents forget to update them.
- Conflict resolution still needs human judgment for project-specific instructions.

## Design rule

Prefer explicit files over hidden memory.

When an agent learns something important, it should either:

- update context;
- update state;
- write an artifact;
- ask the user before changing project-specific truth.

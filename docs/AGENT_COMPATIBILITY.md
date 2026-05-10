# Agent Compatibility

AI Team is designed for agents that can read and write project files. It does not require a specific model, CLI, editor, or package manager.

## Universal protocol

Give any agent this sequence:

```text
Install AI Team from https://github.com/micrfun/ai-team.
After installation, read AI-TEAM-BOOTSTRAP.md.
Then read .ai/protocol.md and .ai/workflows/agent-run.md.
Initialize .ai/context/project.md, .ai/context/stack.md, and .ai/context/conventions.md for this project.
Do not overwrite existing project instructions unless I explicitly approve it.
Do not run runtime commands unless this project allows them.
```

## Claude Code

Claude Code reads `.claude/CLAUDE.md`, subagents from `.claude/agents/`, and slash commands from `.claude/commands/`.

Recommended first prompt:

```text
Read CLAUDE.md and AI-TEAM-BOOTSTRAP.md, then run the AI Team init workflow.
```

## Codex

Codex reads `.codex/AGENTS.md` and the project-level `AGENTS.md` when present.

Recommended first prompt:

```text
Read .codex/AGENTS.md and AI-TEAM-BOOTSTRAP.md, then run the AI Team init workflow.
```

## Gemini CLI

Gemini reads `.gemini/GEMINI.md`.

Recommended first prompt:

```text
Read .gemini/GEMINI.md and AI-TEAM-BOOTSTRAP.md, then run the AI Team init workflow.
```

## Cursor

Cursor reads `.cursor/rules/ai-team.mdc`.

Recommended first prompt:

```text
Use the AI Team Cursor rule and initialize this project from AI-TEAM-BOOTSTRAP.md.
```

## Antigravity

Antigravity reads `.antigravity/AGENTS.md`.

Recommended first prompt:

```text
Read .antigravity/AGENTS.md and AI-TEAM-BOOTSTRAP.md, then run the AI Team init workflow.
```

## Generic agents

For agents such as Hermes, OpenClaw, or other file-aware coding agents, use `AGENT_INSTALL_PROMPT.md` from this repository.

If the agent cannot run shell commands, ask it to manually copy:

- `.ai/`
- `.claude/`
- `.codex/`
- `.gemini/`
- `.cursor/`
- `.antigravity/`
- `README.md` as `AI-TEAM-README.md`
- `INSTALL.md` as `AI-TEAM-INSTALL.md`
- `AGENT_INSTALL_PROMPT.md` as `AI-TEAM-AGENT-INSTALL-PROMPT.md`
- `AI_TEAM_BOOTSTRAP.md` as `AI-TEAM-BOOTSTRAP.md`

See [COMPATIBILITY_MATRIX.md](COMPATIBILITY_MATRIX.md) for a task-oriented comparison.

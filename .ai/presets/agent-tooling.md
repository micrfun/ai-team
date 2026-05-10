# Preset: Agent Tooling

Use this preset for tools, prompts, workflows, and infrastructure used by AI agents.

## Context additions

Add to `.ai/context/project.md` when applicable:

- supported agent tools;
- expected human checkpoints;
- file protocol or artifact contract;
- safety boundaries.

Add to `.ai/context/conventions.md` when applicable:

- prompt/versioning conventions;
- eval strategy;
- review requirements;
- installation and update behavior.

## Conventions

- Prefer explicit file protocols over hidden chat memory.
- Keep agent instructions short enough to be read frequently.
- Make destructive actions opt-in.
- Require agents to report changed files and local verification commands.
- Treat prompts and workflow files as production behavior, not comments.

## Role emphasis

- Architect defines artifact contracts.
- Security reviews prompt injection, secret exposure, and unsafe tool use.
- QA defines eval scenarios and regression prompts.
- Reviewer checks both code and instruction files.

# AI Team Bootstrap Protocol

Read this file after installing AI Team into a target project.

## Goal

Initialize AI Team for the current project without relying on hidden agent behavior.

## Rules

- Inspect project files before changing context.
- Prefer file reads over shell commands.
- Run shell or Git commands only when the target project's instructions allow them.
- Do not run build, lint, test, dev server, package manager, browser runner, or temporary runtime commands unless the user explicitly asks.
- Do not overwrite existing project instructions without asking.
- Do not delete suspicious files.
- If a nested `.git` directory exists, report it and ask the user what to do.

## Steps

1. Read local project instructions if present:
   - `AGENTS.md`
   - `CLAUDE.md`
   - `GEMINI.md`
   - `.cursor/rules/*`
   - existing `.ai/context/*.md`

2. Read AI Team context files:
   - `.ai/context/project.md`
   - `.ai/context/stack.md`
   - `.ai/context/conventions.md`

3. If `.ai/context/project.md` contains `AI-TEAM-CONTEXT: NOT_INITIALIZED`, run the init workflow manually:
   - read `.ai/workflows/init.md`;
   - read `.ai/roles/bootstrap.md`;
   - inspect project documentation and common manifest/config files;
   - summarize what you found for the user;
   - ask the user to confirm or correct the summary;
   - fill `.ai/context/project.md`, `.ai/context/stack.md`, and `.ai/context/conventions.md`;
   - replace `AI-TEAM-CONTEXT: NOT_INITIALIZED` with `AI-TEAM-CONTEXT: INITIALIZED`.

4. After initialization, tell the user:
   - changed files;
   - what was inferred;
   - what remains unknown;
   - exact local verification commands, if runtime verification is needed.

5. If the project clearly matches a preset, ask the user before applying it:
   - `.ai/presets/web-app.md`
   - `.ai/presets/python-cli.md`
   - `.ai/presets/open-source.md`
   - `.ai/presets/agent-tooling.md`

## Discovery checklist

Read files that exist in the target project:

- `README.md`
- `package.json`
- `pnpm-lock.yaml`, `package-lock.json`, `yarn.lock`
- `pyproject.toml`, `requirements.txt`
- `Cargo.toml`
- `go.mod`
- `Gemfile`
- `composer.json`
- `pom.xml`
- `tsconfig.json`
- `.editorconfig`
- lint, format, CI, deployment, and docs config files

If shell commands are allowed by the target project, Git history can help. If shell commands are not allowed, skip Git history and continue from files.

## Preset guidance

Presets are optional context refinements. They should not override project facts.

Use a preset only when it matches the target project, then summarize the proposed context changes before editing `.ai/context/*`.

## Completion criteria

AI Team is initialized when:

- `.ai/context/project.md` describes what the project is and who it is for;
- `.ai/context/stack.md` describes the known stack and local commands;
- `.ai/context/conventions.md` describes coding, testing, Git, and documentation conventions;
- unknown details are marked as `<TBD: уточнить позже>`;
- the user has seen and accepted the summary.

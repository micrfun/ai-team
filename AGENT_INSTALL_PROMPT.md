# AI Team Agent Install Prompt

Copy this prompt into any agent that has access to the target project files.

```text
You are working inside my target project. Install AI Team from:

https://github.com/micrfun/ai-team

Goal:
Add an AI development team system to this project so future agents can work through shared roles, workflows, templates, and project context files.

Rules:
- Inspect the target project before changing files.
- Do not run application build, lint, test, dev server, package manager, browser runner, or temporary runtime commands unless I explicitly ask.
- Do not delete existing files.
- Do not overwrite existing agent instructions without asking first. Prefer the installer default safe merge mode.
- If there is a nested .git directory, report it and ask me what to do.
- Keep changes minimal and scoped to installing AI Team.

Install:
- On Windows PowerShell, use:
  $installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/v0.2.1/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target . -Ref v0.2.1
- On macOS/Linux, use:
  curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/v0.2.1/install.sh | bash -s -- . --ref v0.2.1
- If shell execution is not available, manually copy these directories from the repository root into the target project:
  .ai
  .claude
  .codex
  .gemini
  .cursor
  .antigravity
  and copy README.md as AI-TEAM-README.md if AI-TEAM-README.md does not already exist.
  If a target file already exists, preserve it and write the incoming file beside it with a .ai-team-new suffix.

Adaptation after install:
1. Read AI-TEAM-BOOTSTRAP.md.
2. Read .ai/context/project.md.
3. If it contains AI-TEAM-CONTEXT: NOT_INITIALIZED, run the init workflow manually:
   - Read .ai/workflows/init.md.
   - Read .ai/roles/bootstrap.md.
   - Inspect project files such as README.md, package manifests, lockfiles, config files, docs, and existing agent instructions.
   - Use shell or Git commands only if the target project policy allows them.
   - Summarize what you found and ask me to confirm or correct it.
   - Fill .ai/context/project.md, .ai/context/stack.md, and .ai/context/conventions.md.
   - Replace AI-TEAM-CONTEXT: NOT_INITIALIZED with AI-TEAM-CONTEXT: INITIALIZED.
4. After initialization, tell me which files changed and what future commands, if any, I should run locally.

Expected result:
- The project has an .ai/ directory with shared roles, workflows, templates, and context.
- Supported agent tools have local adapter instructions.
- The project context files describe this specific project rather than generic placeholders.
```

# Update Guide

Use this guide when AI Team is already installed in a project and you want to bring in a newer template version.

## Default update behavior

Installers preserve existing files by default.

When a file already exists, the incoming version is written beside it with a `.ai-team-new` suffix.

Example:

```text
.codex/AGENTS.md
.codex/AGENTS.md.ai-team-new
```

Review `.ai-team-new` files manually and merge useful changes into the existing project files.

## Files to preserve

These files are project-specific and should not be blindly overwritten:

- `.ai/context/project.md`
- `.ai/context/stack.md`
- `.ai/context/conventions.md`
- `.ai/state/current.md`
- `.ai/state/tasks.md`
- `.ai/state/blockers.md`
- `.ai/state/risks.md`
- `.ai/state/handoffs.md`
- existing `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and Cursor rules
- any local workflow or role customizations made by the project

## Recommended update flow

1. Run dry-run first.

PowerShell:

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/main/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target . -DryRun
```

Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/main/install.sh | bash -s -- . --dry-run
```

2. Run normal install.

PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File $installer -Target .
```

Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/main/install.sh | bash -s -- .
```

3. Review conflict files.

PowerShell:

```powershell
Get-ChildItem -Recurse -Filter *.ai-team-new
```

Bash:

```bash
find . -name '*.ai-team-new' -type f
```

4. Merge relevant changes manually.

5. Delete reviewed `.ai-team-new` files only after confirming the merge.

AI Team also includes `.ai/workflows/update-ai-team.md`, which agents can use to review and classify `.ai-team-new` files before applying changes.

## Force mode

Use force mode only in disposable projects or when you intentionally want to replace existing AI Team files.

PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target . -Force
```

Bash:

```bash
./install.sh . --force
```

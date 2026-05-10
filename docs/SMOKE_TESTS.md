# Smoke Tests

This checklist verifies AI Team installation behavior in disposable target projects.

Runtime check must be performed by the user locally.

## Preparation

Use temporary target directories that do not contain valuable files.

### Windows target

```powershell
New-Item -ItemType Directory -Force C:\Temp\ai-team-empty
New-Item -ItemType Directory -Force C:\Temp\ai-team-existing\.codex
"existing" | Set-Content C:\Temp\ai-team-existing\.codex\AGENTS.md
```

### macOS / Linux target

```bash
mkdir -p /tmp/ai-team-empty
mkdir -p /tmp/ai-team-existing/.codex
printf '%s\n' 'existing' > /tmp/ai-team-existing/.codex/AGENTS.md
```

## PowerShell checks

Run from a local clone of this repository:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\Temp\ai-team-empty -DryRun
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\Temp\ai-team-empty
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\Temp\ai-team-existing
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\Temp\ai-team-existing -Force
```

Expected:

- `-DryRun` prints planned operations and does not create target files.
- normal install creates `.ai/`, adapter folders, and `AI-TEAM-*.md`.
- repeated install preserves existing files and writes `.ai-team-new` conflict files.
- repeated install preserves `.ai/context/project.md` and writes the incoming copy as `.ai-team-new`.
- `-Force` overwrites AI Team files intentionally.

## Bash checks

Run from a local clone of this repository:

```bash
./install.sh /tmp/ai-team-empty --dry-run
./install.sh /tmp/ai-team-empty
./install.sh /tmp/ai-team-existing
./install.sh /tmp/ai-team-existing --force
```

Expected:

- `--dry-run` prints planned operations and does not create target files.
- normal install creates `.ai/`, adapter folders, and `AI-TEAM-*.md`.
- repeated install preserves existing files and writes `.ai-team-new` conflict files.
- repeated install preserves `.ai/context/project.md` and writes the incoming copy as `.ai-team-new`.
- `--force` overwrites AI Team files intentionally.

## Raw-link checks

PowerShell:

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/v0.2.1/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target C:\Temp\ai-team-empty -Ref v0.2.1 -DryRun
```

Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/v0.2.1/install.sh | bash -s -- /tmp/ai-team-empty --ref v0.2.1 --dry-run
```

Expected:

- raw installer downloads the GitHub archive;
- stable installer receives an explicit tag ref and does not fall back to `main`;
- target files are not changed in dry-run mode;
- planned file operations are visible.

## CI coverage

GitHub Actions runs a subset of these checks on:

- Windows with PowerShell;
- Ubuntu with bash.

CI checks fresh install, dry-run, safe reinstall, context preservation, state/protocol files, and force mode. Raw-link checks are kept manual so release candidates can be tested against the intended branch or tag.

CI also checks that installers accept a release tag through `-Ref` / `--ref`.

## Bootstrap check

After installing into a disposable project, open it with an agent and ask:

```text
Read AI-TEAM-BOOTSTRAP.md and initialize AI Team for this project.
```

Expected:

- agent reads project files first;
- agent does not run runtime commands unless allowed;
- `.ai/context/project.md`, `.ai/context/stack.md`, and `.ai/context/conventions.md` are filled for the target project;
- unknown values are marked as `<TBD: уточнить позже>`.

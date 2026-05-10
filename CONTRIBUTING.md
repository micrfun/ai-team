# Contributing

AI Team is a template project. Changes should keep installation safe for existing projects and should not add runtime dependencies unless there is a clear reason.

## Principles

- Keep `.ai/` as the source of truth.
- Keep tool-specific folders as thin adapters.
- Do not overwrite user project files by default.
- Preserve compatibility with raw GitHub installer links.
- Prefer clear Markdown instructions over custom tooling.

## Change checklist

Before proposing a change, verify:

- installer behavior remains safe by default;
- existing files in target projects are preserved unless force mode is explicit;
- `AI_TEAM_BOOTSTRAP.md` still explains the post-install path for generic agents;
- README and INSTALL examples stay in sync with installer flags;
- no secrets, local paths, or private project assumptions are introduced.

## Local verification

Runtime check must be performed by the user locally.

Suggested static checks:

```powershell
Get-Content .\README.md
Get-Content .\INSTALL.md
Get-Content .\AI_TEAM_BOOTSTRAP.md
Get-Content .\install.ps1
Get-Content .\install.sh
git diff --check
```

Suggested install checks in a disposable target project:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\path\to\temp-project -DryRun
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\path\to\temp-project
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\path\to\temp-project -Force
```

```bash
./install.sh /tmp/ai-team-target --dry-run
./install.sh /tmp/ai-team-target
./install.sh /tmp/ai-team-target --force
```

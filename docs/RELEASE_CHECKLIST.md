# Release Checklist

Use this checklist before publishing a new AI Team version.

Runtime check must be performed by the user locally.

## Before tagging

- [ ] Review `README.md`.
- [ ] Review `INSTALL.md`.
- [ ] Review `AI_TEAM_BOOTSTRAP.md`.
- [ ] Review `AGENT_INSTALL_PROMPT.md`.
- [ ] Review `CHANGELOG.md`.
- [ ] Run `git diff --check`.
- [ ] Run smoke tests from `docs/SMOKE_TESTS.md` in disposable target projects.
- [ ] Confirm no secrets, private paths, or local-only assumptions were added.

## Tagging

```bash
git status -sb
git tag -a v0.1.0 -m "v0.1.0"
git push origin main
git push origin v0.1.0
```

## Release notes template

## AI Team v0.1.0

Initial public release.

### Highlights

- Tool-agnostic `.ai/` role and workflow system.
- Adapters for Claude Code, Codex, Gemini CLI, Cursor, and Antigravity.
- Safe-by-default PowerShell and bash installers.
- Dry-run and explicit force modes.
- Generic agent bootstrap protocol.

### Install

PowerShell:

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/v0.1.0/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target .
```

Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/v0.1.0/install.sh | bash -s -- .
```

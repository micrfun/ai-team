# Release Process

Use this checklist when publishing a new AI Team version.

## 1. Choose Version

- Use patch releases for installer, docs, examples, and compatibility fixes.
- Use minor releases for protocol structure changes.
- Keep protocol version separate from release version.

Example:

```text
AI Team release: 0.2.2
Protocol version: 0.2-draft
```

## 2. Update Files

Update every stable-version reference:

- `README.md`;
- `INSTALL.md`;
- `AGENT_INSTALL_PROMPT.md`;
- `docs/PROTOCOL.md`;
- `CHANGELOG.md`.

If the protocol contract changes, also update:

- `.ai/protocol.md`;
- `docs/PROTOCOL.md`;
- relevant workflows, roles, templates, and examples.

## 3. Check Installer Commands

Stable raw commands must pin both the raw URL and the installer ref:

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/vX.Y.Z/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target . -Ref vX.Y.Z
```

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/vX.Y.Z/install.sh | bash -s -- . --ref vX.Y.Z
```

Do not publish a stable command that omits `-Ref` or `--ref`.

## 4. Verify Locally

At minimum, inspect:

```bash
git diff --check
git status --short
```

Runtime checks must be run in an environment that supports shell execution for both PowerShell and bash installers.

## 5. Commit And Tag

```bash
git add -A
git commit -m "Release vX.Y.Z"
git tag -a vX.Y.Z -m "vX.Y.Z"
git push origin main
git push origin vX.Y.Z
```

## 6. Confirm GitHub

After pushing:

- confirm the tag exists;
- confirm smoke tests pass for `main`;
- confirm smoke tests pass for the tag;
- open the raw stable links and verify they point to the tagged files.

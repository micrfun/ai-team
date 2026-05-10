# Install AI Team

AI Team can be installed by a person or by any coding agent that can read and write project files.

## One-command install

Run the command from the root of the target project.

### Windows / PowerShell

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/main/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target .
```

Preview without changing target files:

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/main/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target . -DryRun
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/main/install.sh | bash -s -- .
```

Preview without changing target files:

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/main/install.sh | bash -s -- . --dry-run
```

## Agent install

Give the contents of [AGENT_INSTALL_PROMPT.md](AGENT_INSTALL_PROMPT.md) to the agent working in the target project.

The agent should:

1. install the template files;
2. inspect the target project;
3. initialize `.ai/context/project.md`, `.ai/context/stack.md`, and `.ai/context/conventions.md`;
4. report changed files and local verification commands.

## What gets copied

- `.ai/`
- `.claude/`
- `.codex/`
- `.gemini/`
- `.cursor/`
- `.antigravity/`
- `AI-TEAM-README.md` if it does not already exist
- `AI-TEAM-INSTALL.md` if it does not already exist
- `AI-TEAM-AGENT-INSTALL-PROMPT.md` if it does not already exist
- `AI-TEAM-BOOTSTRAP.md`

## Conflict behavior

The bundled installers are safe by default.

Existing files are preserved. When a file already exists, the installer writes the new copy next to it with a `.ai-team-new` suffix.

Use explicit overwrite only when you intend to replace existing AI Team files:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target . -Force
```

```bash
./install.sh . --force
```

For agent-driven installs, the agent should ask before overwriting existing instructions.

## After install

Open the project in your preferred AI tool and ask:

```text
Read AI-TEAM-BOOTSTRAP.md and run the AI Team init workflow for this project.
```

The agent should read `AI-TEAM-BOOTSTRAP.md`, then `.ai/workflows/init.md`, use the `bootstrap` role, and fill the context files for the specific project.

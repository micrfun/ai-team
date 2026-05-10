# Installer Safety and Bootstrap Spec

## Goal

Make AI Team safe to install into existing projects by humans or agents without destroying local agent instructions, and make the post-install bootstrap protocol explicit for any agent.

## Requirements

1. Installers must be safe by default.
   - Existing files in target projects are not overwritten by default.
   - Missing files are copied normally.
   - Conflicting files are written next to the original with a `.ai-team-new` suffix.
   - Users can opt into overwrite with an explicit force flag.

2. Installers must support preview mode.
   - PowerShell exposes `-DryRun`.
   - Bash exposes `--dry-run`.
   - Preview mode prints planned operations and does not write target files.

3. Installers must preserve raw-link install support.
   - PowerShell raw install downloads the GitHub archive when `.ai/` is not next to the script.
   - Bash pipe install downloads the GitHub archive when running from stdin.

4. Bootstrap must be tool-agnostic and explicit.
   - Add a root `AI_TEAM_BOOTSTRAP.md` that any agent can read after installation.
   - Installed projects receive `AI-TEAM-BOOTSTRAP.md`.
   - README and install prompt point agents to this file.

5. Bootstrap instructions must respect local runtime policy.
   - File reads are the default discovery mechanism.
   - Shell and Git commands are optional and only allowed when the target project policy permits them.

## Non-goals

- No package manager or runtime dependency.
- No automatic semantic merge of conflicting instruction files.
- No deletion of existing project files.
- No hidden installation side effects outside the selected target directory and temporary download directory.

## Verification

Runtime check must be performed by the user locally.

Static review should confirm:

- default install path no longer overwrites target files;
- force mode is explicit;
- dry-run mode does not write target files;
- raw-link installation still has a source download path;
- bootstrap instructions no longer require shell commands.

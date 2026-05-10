# Security Policy

AI Team is a template that installs agent instructions into other projects. The main security concern is preserving the target project's existing instructions, secrets, and local policies.

## Supported versions

The `main` branch is the active development version. Tagged releases should be preferred for reproducible installs once available.

## Reporting issues

Report security issues privately to the repository owner when possible. If private reporting is not available, open a GitHub issue without including secrets, tokens, private repository contents, or exploit details that would put users at immediate risk.

## Security expectations

- Installers must not delete target project files.
- Installers must preserve existing files by default.
- Force overwrite must be explicit.
- Agent prompts must instruct agents not to expose secrets.
- Bootstrap must respect local project runtime policies.
- Any future network behavior must be documented in README and INSTALL.

## Current network behavior

Raw installer usage downloads this repository archive from GitHub:

- `https://github.com/micrfun/ai-team/archive/refs/heads/main.zip`
- `https://github.com/micrfun/ai-team/archive/refs/heads/main.tar.gz`

No package manager install is required.

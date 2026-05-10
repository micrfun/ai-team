# Compatibility Matrix

This matrix helps choose which agent to use with AI Team.

| Agent | Reads project instructions | Supports slash commands | Can write files | Good for | Limitations |
| --- | ---: | ---: | ---: | --- | --- |
| Codex | yes | partial | yes | coding, refactors, repository maintenance | depends on local environment and configured tools |
| Claude Code | yes | yes | yes | implementation, role/subagent workflows, review | cost and context management matter |
| Gemini CLI | yes | partial | yes | broad-context review and synthesis | instruction following varies by task shape |
| Cursor | yes | no/partial | yes | IDE-guided edits and local developer workflow | less autonomous orchestration |
| Antigravity | yes | partial | yes | coding workflows with AGENTS-style instructions | environment-specific behavior |
| OpenClaw | depends | depends | yes | orchestration and agent workflows | needs setup and project-specific validation |
| Hermes | depends | depends | yes | generic file-aware agent tasks | needs explicit bootstrap prompt |

## Recommendation

- Use `agent-run` for any agent that supports reading files.
- Use `orchestrator` for multi-role work.
- Use `reviewer` or `qa` with broad-context agents when reviewing larger diffs.
- Use stable tagged installer links for projects where reproducibility matters.

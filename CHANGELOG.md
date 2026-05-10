# Changelog

## 0.2.1

- Fix stable raw installer behavior with explicit `-Ref` / `--ref` support.
- Update stable install commands to pass the matching release tag.
- Add templates and example state artifacts for implementation, QA, and handoff records.
- Add public protocol docs and files-as-protocol rationale.

## 0.2.0

- Formalize `.ai/` as a protocol with `.ai/protocol.md`.
- Add `.ai/state/*` files for active work coordination.
- Add universal `.ai/workflows/agent-run.md`.
- Add `.ai/workflows/update-ai-team.md`.
- Strengthen orchestrator, plan, implement, and spec lifecycle contracts.
- Add compatibility matrix and initialized example artifacts.
- Expand CI smoke tests for protocol/state/context preservation.

## 0.1.1

- Add GitHub Actions smoke tests for PowerShell and bash installers.
- Add agent compatibility guide.
- Add optional `.ai/presets/` for common project types.
- Add roadmap and GitHub issue/PR templates.

## 0.1.0

- Make PowerShell and bash installers safe by default.
- Add explicit force overwrite mode.
- Add dry-run preview mode.
- Add `AI_TEAM_BOOTSTRAP.md` for generic agent initialization.
- Clarify bootstrap behavior when shell or Git commands are not allowed.
- Add public project maintenance docs.
- Initial AI Team template.
- Add `.ai/` roles, workflows, templates, and context files.
- Add adapters for Claude Code, Codex, Gemini CLI, Cursor, and Antigravity.
- Add PowerShell and bash installers.
- Add agent install prompt.
- Add smoke-test checklist, update guide, release checklist, and example target projects.
- Add stricter output contracts for Product, Architect, Engineer, QA, and Reviewer roles.

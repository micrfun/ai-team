# Preset: Open Source

Use this preset for projects intended to be public on GitHub.

## Context additions

Add to `.ai/context/project.md` when applicable:

- target audience;
- public/private status;
- license choice;
- maintenance expectations;
- contribution policy.

Add to `.ai/context/conventions.md` when applicable:

- issue and PR workflow;
- changelog expectations;
- release process;
- security reporting policy.

## Conventions

- Do not include secrets, private URLs, private user data, or machine-specific assumptions.
- Keep install instructions reproducible.
- Prefer tagged release links for stable user-facing commands.
- Include security notes for tools that affect credentials, automation, or file writes.

## Role emphasis

- Product clarifies audience and positioning.
- Architect checks public API and compatibility.
- Reviewer checks accidental private data and unsafe install behavior.
- QA checks installation and documentation paths.

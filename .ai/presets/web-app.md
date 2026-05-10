# Preset: Web App

Use this preset for frontend or full-stack web applications.

## Context additions

Add to `.ai/context/stack.md` when applicable:

- frontend framework and version;
- routing model;
- styling system;
- component library;
- data-fetching pattern;
- build and preview commands;
- browser verification expectations.

## Conventions

- Preserve existing UI patterns unless the user asks for redesign.
- Treat accessibility, responsive layout, loading states, empty states, and error states as part of the feature.
- Do not introduce new UI libraries without explaining why existing project code cannot solve the problem.
- Runtime check must be performed by the user locally when local runtime policy forbids agent-run checks.

## Role emphasis

- Product defines user outcome and acceptance criteria.
- UX Designer defines flows and states.
- Architect defines component/data boundaries.
- Engineer implements narrow changes.
- QA verifies responsive and interaction behavior.

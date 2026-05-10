# Project Context

## What we're building

A minimal browser app used as an AI Team example target.

## Who it's for

- **Primary segment**: maintainers testing AI Team installation and bootstrap behavior.
- **JTBD**: verify that an agent can infer project purpose from a small JavaScript project.
- **Trigger**: testing installer or bootstrap changes.

## Goals

- Provide a small target project for documentation and smoke checks.

## Non-goals

- This is not a production app.

## Constraints

- Runtime commands are documented but not run by agents unless the user permits them.

## Success metrics

- AI Team context can be initialized from README and `package.json`.

# Preset: Python CLI

Use this preset for Python command-line tools, scripts, and libraries.

## Context additions

Add to `.ai/context/stack.md` when applicable:

- Python version;
- package manager;
- CLI entry points;
- test framework;
- formatter and linter;
- supported operating systems.

## Conventions

- Prefer standard library features unless a dependency is justified.
- Keep CLI parsing, domain logic, and I/O boundaries separate.
- Document commands but do not run them when local runtime policy forbids agent-run checks.
- Include examples of expected CLI input and output in specs.

## Role emphasis

- Architect defines command contracts and error behavior.
- Engineer keeps functions testable without invoking the CLI process.
- QA covers success, invalid input, filesystem, and exit-code behavior.

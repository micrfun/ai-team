---
description: Run the 'review' workflow as defined in .ai/workflows/review.md
---

Read `.ai/workflows/review.md` and execute it for the topic/feature provided in the user's message.

Before starting:
1. Confirm the scope with the user if it's ambiguous
2. Read `.ai/context/project.md` for project context
3. Activate roles as the workflow specifies — either by reading their files yourself or by invoking subagents (Task tool) where available

Stop at human checkpoints and ask for approval before continuing.

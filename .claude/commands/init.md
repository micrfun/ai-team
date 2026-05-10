---
description: Initialize the project context by running the bootstrap role
---

Read `.ai/workflows/init.md` and execute it.

This activates the `bootstrap` role to:
1. Auto-detect project info from existing files
2. Interview the user briefly (or accept a free-text project description)
3. Fill in `.ai/context/{project,stack,conventions}.md`
4. Replace `NOT_INITIALIZED` markers with `INITIALIZED`
5. Suggest the next step

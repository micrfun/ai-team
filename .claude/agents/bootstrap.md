---
name: bootstrap
description: Initializes the project context by interviewing the user and auto-detecting from project files. Run when context is not yet filled in.
---

You are operating in the **bootstrap** role for this project.

**Required first step**: Read `.ai/roles/bootstrap.md` for the full role definition.

Your job is to:
1. Auto-detect what you can from existing files (`package.json`, `README.md`, lockfiles, configs)
2. Show the user what you found and ask for confirmation
3. Conduct a short interview — accept free-text descriptions, don't force a Q&A format
4. Fill in `.ai/context/{project,stack,conventions}.md`
5. Replace the `<!-- AI-TEAM-CONTEXT: NOT_INITIALIZED -->` marker with `<!-- AI-TEAM-CONTEXT: INITIALIZED -->` in each file
6. Suggest the next step (discovery / plan / specific role)

Be brief. Aim for 5–10 minutes total. Use `<TBD: ...>` for fields the user can't or won't fill in right now.

# Workflow: Update AI Team

## When to use

Use when AI Team has been reinstalled and the target project contains `.ai-team-new` conflict files.

## Steps

1. **Find updates**
   - Locate all files ending in `.ai-team-new`.
   - Do not delete or overwrite anything.

2. **Classify each update**
   - `safe to merge`: documentation-only or additive changes with no project-specific conflict.
   - `needs human review`: adapter instructions, workflow behavior, role contracts.
   - `project-specific conflict`: `.ai/context/*`, `.ai/state/*`, or locally customized instructions.

3. **Prepare merge plan**
   - For each file, state current file, incoming file, classification, and recommended action.

4. **Human checkpoint**
   - Ask the user to approve the merge plan before applying changes.

5. **Apply approved changes**
   - Merge only approved items.
   - Preserve project-specific context.

6. **Cleanup**
   - Delete reviewed `.ai-team-new` files only after user approval.

7. **Update state**
   - Record the update in `.ai/state/handoffs.md` or `.ai/state/current.md`.

## Exit criteria

- Every `.ai-team-new` file is either merged, intentionally kept, or explicitly deferred.
- No project-specific context is overwritten without approval.
- User receives a changed-files summary.

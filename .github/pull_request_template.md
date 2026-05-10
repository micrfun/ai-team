## Summary

-

## Verification

Runtime check must be performed by the user locally when local runtime checks are needed.

- [ ] `git diff --check`
- [ ] Installer smoke tests updated or not affected
- [ ] README/INSTALL/CHANGELOG updated if behavior changed

## Compatibility

- [ ] Existing target project files are preserved by default
- [ ] `.ai/context/*` project-specific files are not blindly overwritten
- [ ] Agent instructions remain tool-agnostic where possible

#!/usr/bin/env bash
# AI Team installer
# Usage:
#   curl -fsSL <URL>/install.sh | bash -s -- [target-directory] [--force] [--dry-run]
#   ./install.sh [target-directory] [--force] [--dry-run]

set -euo pipefail

TARGET=""
FORCE=0
DRY_RUN=0

for arg in "$@"; do
    case "$arg" in
        --force)
            FORCE=1
            ;;
        --dry-run)
            DRY_RUN=1
            ;;
        -*)
            echo "Unknown option: $arg"
            exit 1
            ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$arg"
            else
                echo "Unexpected argument: $arg"
                exit 1
            fi
            ;;
    esac
done

TARGET="${TARGET:-$(pwd)}"
SOURCE_FILE="${BASH_SOURCE[0]:-$0}"
IS_LOCAL_SOURCE=0
if [ -f "$SOURCE_FILE" ]; then
    SCRIPT_DIR="$(cd "$(dirname "$SOURCE_FILE")" && pwd)"
    IS_LOCAL_SOURCE=1
else
    SCRIPT_DIR=""
fi

SOURCE_DIR="$SCRIPT_DIR"
TEMP_SOURCE=""

write_action() {
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "[dry-run] $1"
    else
        echo "$1"
    fi
}

copy_ai_team_file() {
    local source_path="$1"
    local target_path="$2"
    local target_parent
    target_parent="$(dirname "$target_path")"

    if [ "$FORCE" -eq 1 ] || [ ! -e "$target_path" ]; then
        write_action "Install $target_path"
        if [ "$DRY_RUN" -ne 1 ]; then
            mkdir -p "$target_parent"
            cp "$source_path" "$target_path"
        fi
        return
    fi

    local conflict_path="${target_path}.ai-team-new"
    write_action "Keep existing $target_path; write update to $conflict_path"
    if [ "$DRY_RUN" -ne 1 ]; then
        mkdir -p "$target_parent"
        cp "$source_path" "$conflict_path"
    fi
}

copy_ai_team_directory() {
    local source_path="$1"
    local target_path="$2"

    if [ ! -d "$source_path" ]; then
        return
    fi

    if [ ! -d "$target_path" ]; then
        write_action "Create directory $target_path"
        if [ "$DRY_RUN" -ne 1 ]; then
            mkdir -p "$target_path"
        fi
    fi

    while IFS= read -r -d '' source_file; do
        local relative_path="${source_file#"$source_path"/}"
        copy_ai_team_file "$source_file" "$target_path/$relative_path"
    done < <(find "$source_path" -type f -print0)
}

cleanup() {
    if [ -n "$TEMP_SOURCE" ] && [ -d "$TEMP_SOURCE" ]; then
        rm -rf "$TEMP_SOURCE"
    fi
}
trap cleanup EXIT

if [ "$IS_LOCAL_SOURCE" -ne 1 ] || [ ! -d "$SOURCE_DIR/.ai" ]; then
    write_action "Download AI Team archive"
    TEMP_SOURCE="$(mktemp -d)"
    curl -fsSL "https://github.com/micrfun/ai-team/archive/refs/heads/main.tar.gz" | tar -xz -C "$TEMP_SOURCE"
    SOURCE_DIR="$TEMP_SOURCE/ai-team-main"
fi

echo "AI Team installer"
echo "Target directory: $TARGET"
if [ "$FORCE" -eq 1 ]; then
    echo "Mode: force overwrite"
elif [ "$DRY_RUN" -eq 1 ]; then
    echo "Mode: dry run, no files will be changed"
else
    echo "Mode: safe merge, existing files are preserved"
fi
echo ""

if [ ! -d "$TARGET" ]; then
    echo "Target directory does not exist: $TARGET"
    exit 1
fi

DIRS=(.ai .claude .codex .gemini .cursor .antigravity)

for dir in "${DIRS[@]}"; do
    copy_ai_team_directory "$SOURCE_DIR/$dir" "$TARGET/$dir"
done

copy_ai_team_file "$SOURCE_DIR/README.md" "$TARGET/AI-TEAM-README.md"
copy_ai_team_file "$SOURCE_DIR/INSTALL.md" "$TARGET/AI-TEAM-INSTALL.md"
copy_ai_team_file "$SOURCE_DIR/AGENT_INSTALL_PROMPT.md" "$TARGET/AI-TEAM-AGENT-INSTALL-PROMPT.md"
copy_ai_team_file "$SOURCE_DIR/AI_TEAM_BOOTSTRAP.md" "$TARGET/AI-TEAM-BOOTSTRAP.md"

echo ""
if [ "$DRY_RUN" -eq 1 ]; then
    echo "Dry run complete. No files were changed."
else
    echo "Installation complete."
fi
echo ""
echo "Next steps:"
echo "  1. Open the project in any AI CLI."
echo "  2. Ask the agent to read AI-TEAM-BOOTSTRAP.md."
echo "  3. Run the AI Team init workflow for this project."
echo ""
echo "Use --force only when you intentionally want to overwrite existing AI Team files."

#!/usr/bin/env bash
# AI Team Template — установщик
# Использование:
#   curl -fsSL <URL>/install.sh | bash
# или из распакованного архива:
#   ./install.sh [target-directory]

set -euo pipefail

TARGET="${1:-$(pwd)}"
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

if [ "$IS_LOCAL_SOURCE" -ne 1 ] || [ ! -d "$SOURCE_DIR/.ai" ]; then
    TEMP_SOURCE="$(mktemp -d)"
    curl -fsSL "https://github.com/micrfun/ai-team/archive/refs/heads/main.tar.gz" | tar -xz -C "$TEMP_SOURCE"
    SOURCE_DIR="$TEMP_SOURCE/ai-team-main"
fi

echo "🤖 AI Team Template installer"
echo "Target directory: $TARGET"
echo ""

if [ ! -d "$TARGET" ]; then
    echo "❌ Target directory does not exist: $TARGET"
    exit 1
fi

# Список папок шаблона
DIRS=(.ai .claude .codex .gemini .cursor .antigravity)

# Проверка конфликтов
CONFLICTS=()
for dir in "${DIRS[@]}"; do
    if [ -d "$TARGET/$dir" ]; then
        CONFLICTS+=("$dir")
    fi
done

if [ ${#CONFLICTS[@]} -gt 0 ]; then
    echo "⚠️  Found existing directories: ${CONFLICTS[*]}"
    read -p "Overwrite? [y/N]: " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
fi

# Копирование
for dir in "${DIRS[@]}"; do
    if [ -d "$SOURCE_DIR/$dir" ]; then
        cp -r "$SOURCE_DIR/$dir" "$TARGET/"
        echo "✓ Installed $dir"
    fi
done

# Docs кладём только если их нет
copy_doc() {
    local source="$1"
    local target="$2"

    if [ ! -f "$TARGET/$target" ] && [ -f "$SOURCE_DIR/$source" ]; then
        cp "$SOURCE_DIR/$source" "$TARGET/$target"
        echo "✓ Installed $target"
    fi
}

copy_doc "README.md" "AI-TEAM-README.md"
copy_doc "INSTALL.md" "AI-TEAM-INSTALL.md"
copy_doc "AGENT_INSTALL_PROMPT.md" "AI-TEAM-AGENT-INSTALL-PROMPT.md"

echo ""
echo "✅ Installation complete."
echo ""
echo "Next steps:"
echo "  1. Open the project in any AI CLI (Claude Code, Codex, Gemini, Cursor, Antigravity)"
echo "  2. The agent will detect the unfilled context and run /init automatically"
echo "  3. Or trigger it manually: ask the agent to 'run init workflow'"
echo ""
echo "Read AI-TEAM-README.md and AI-TEAM-INSTALL.md for details."

if [ -n "$TEMP_SOURCE" ] && [ -d "$TEMP_SOURCE" ]; then
    rm -rf "$TEMP_SOURCE"
fi

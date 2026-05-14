#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$(pwd)"

echo "Copying qrspi-setup for OpenCode from: $SCRIPT_DIR"
echo "                       to working directory: $DEST_DIR"
echo ""

copy_file() {
    local src="$1"
    local dest="$2"
    local name="$(basename "$dest")"

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "  SKIP $name (exists)"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  COPY $name"
}

copy_dir() {
    local src="$1"
    local dest="$2"
    local name="$(basename "$dest")"

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "  SKIP $name (exists)"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    cp -R "$src" "$dest"
    echo "  COPY $name"
}

echo "=== AGENTS.md ==="
copy_file "$SCRIPT_DIR/AGENTS.md" "$DEST_DIR/AGENTS.md"

echo ""
echo "=== .opencode/commands ==="
mkdir -p "$DEST_DIR/.opencode/commands"
for command_file in "$SCRIPT_DIR/commands"/*.md; do
    [ -e "$command_file" ] || continue
    copy_file "$command_file" "$DEST_DIR/.opencode/commands/$(basename "$command_file")"
done

echo ""
echo "=== .agents/skills ==="
mkdir -p "$DEST_DIR/.agents/skills"
for skill_dir in "$SCRIPT_DIR/skills"/*; do
    [ -d "$skill_dir" ] || continue
    copy_dir "$skill_dir" "$DEST_DIR/.agents/skills/$(basename "$skill_dir")"
done

echo ""
echo "=== docs ==="
mkdir -p "$DEST_DIR/docs"
for docs_dir in "$SCRIPT_DIR/docs"/*; do
    [ -d "$docs_dir" ] || continue

    dest_docs_dir="$DEST_DIR/docs/$(basename "$docs_dir")"
    mkdir -p "$dest_docs_dir"

    for item in "$docs_dir"/*; do
        [ -e "$item" ] || continue
        copy_file "$item" "$dest_docs_dir/$(basename "$item")"
    done
done

echo ""
echo "Done!"

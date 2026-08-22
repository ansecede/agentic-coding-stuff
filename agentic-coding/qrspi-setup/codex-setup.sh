#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$(pwd)"

echo "Copying qrspi-setup for Codex from: $SCRIPT_DIR"
echo "                    to working directory: $DEST_DIR"
echo ""

source "$SCRIPT_DIR/lib/copy-helpers.sh"

echo "=== AGENTS.md ==="
copy_file "$SCRIPT_DIR/AGENTS.md" "$DEST_DIR/AGENTS.md"

echo ""
echo "=== .agents/skills from commands ==="
mkdir -p "$DEST_DIR/.agents/skills"
for command_file in "$SCRIPT_DIR/commands"/*.md; do
    [ -e "$command_file" ] || continue

    skill_name="$(basename "$command_file" .md)"
    skill_dir="$DEST_DIR/.agents/skills/$skill_name"
    mkdir -p "$skill_dir"
    copy_file "$command_file" "$skill_dir/SKILL.md"
done

echo ""
echo "=== .agents/skills from skills ==="
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

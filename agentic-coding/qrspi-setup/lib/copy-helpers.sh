#!/bin/bash
# Shared helpers — sourced by *-setup.sh scripts. Not meant to be executed directly.

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

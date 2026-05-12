#!/bin/bash

# Get the absolute path of the directory this script is located in.
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/home" && pwd)
TARGET_DIR="$HOME"

echo "Installing dotfiles from: $DOTFILES_DIR"
echo

# Find all files, excluding .git and the script itself
find "$DOTFILES_DIR" -type f \
    -not -path "*/\.git/*" \
    -not -name "$(basename "$0")" \
    -not -path "*/dot-themes/*" \
    -print0 | while IFS= read -r -d '' src_file; do


    rel_path="${src_file#"$DOTFILES_DIR/"}"
    
    # Replace 'dot-' with '.' in the target path

    target_rel_path="${rel_path//dot-/.}"

 
    target_path="$TARGET_DIR/$target_rel_path"
    target_dir=$(dirname "$target_path")


    mkdir -p "$target_dir"

    # Handle existing files or links
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        if [ -L "$target_path" ] && [ "$(realpath "$target_path")" = "$src_file" ]; then
            echo "[LINKED] Already linked: $target_rel_path"
            continue
        fi
        echo "[BACKUP] Moving existing $target_rel_path to .bak"
        mv "$target_path" "$target_path.bak-$(date +%Y%m%d%H%M%S)"
    fi

    # Create the symlink
    echo "[LINK] $rel_path -> $target_rel_path"
    ln -s "$src_file" "$target_path"

done
echo "[LINK] Folder: dot-themes -> .themes"
ln -sfn "$DOTFILES_DIR/dot-themes" "$TARGET_DIR/.themes"
echo
echo "Done linking dotfiles"

echo "Enabling ly on 1 session"
sudo systemctl enable ly@tty1.service
sudo systemctl disable getty@tty1.service
echo "Done with script, system ready to use, please reboot"


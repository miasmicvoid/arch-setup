#!/bin/bash


# Get the directory where the script is located
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTS_DIR="$SCRIPT_DIR/dots"


if ! command -v stow &> /dev/null; then
    echo "Stow is missing. Install it please"

fi


echo "Linking configurations to $HOME..."

if [ -d "$DOTS_DIR" ]; then
    # Move into the dots directory so Stow sees the 'packages'
    cd "$DOTS_DIR"

    # Loop through every folder in dots/
    for folder in *; do
        if [ -d "$folder" ]; then
            echo "Deploying: $folder"
            # -R: (updates existing links)
            # -f: (overwrites default system files)
            # -t: Target 
            stow -R -f -t "$HOME" "$folder"
        fi
    done
else
    echo "Could not find 'dots' folder at $DOTS_DIR"
    exit 1
fi

echo "Finished."

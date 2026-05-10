#!/bin/bash


# Get the directory where the script is located
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTS_DIR="$SCRIPT_DIR/desktopenvironment"


if ! command -v stow &> /dev/null; then
    echo "Stow is missing. Install it please"

fi

echo "This script will overwrite existing config files in your home directory."
read -p "Are you sure you want to proceed? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Setup aborted."
    exit 1
fi

echo "It will also undo any uncommited changes in this repository."
read -p "Are you sure you want to proceed? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Setup aborted."
    exit 1
fi


echo "Linking configurations to $HOME..."

if [ -d "$DOTS_DIR" ]; then
    # Move into the dots directory so Stow sees the 'packages'
	cd "$DOTS_DIR"

    # Loop through every folder in dots/
	for folder in *; do
        	echo "Deploying: $folder"
            	# -R: (updates existing links)
            	# --adop: move files from original location to repo
            	# -t: Target 
		stow -v --dotfiles --target="$HOME" --adopt "$folder"
		git checkout .		
	done
    # Remove the moved files, link to original repo files
else
    echo "Could not find 'desktopenvironment' folder at $DOTS_DIR"
    exit 1
	fi

echo "Finished."

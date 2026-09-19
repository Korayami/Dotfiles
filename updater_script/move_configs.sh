#!/usr/bin/env bash

# Define your target dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Create the dotfiles directory if it doesn't exist
mkdir -p "$DOTFILES_DIR"

# 1. Handle standard config directories
# These go into ~/.dotfiles/<name>/.config/<name>
CONFIG_DIRS=(ambxst fish helix hypr kitty neofetch systemd yay)

for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Processing directory: $dir"
        mkdir -p "$DOTFILES_DIR/$dir/.config"
        mv "$dir" "$DOTFILES_DIR/$dir/.config/"
        
        # Symlink it back using stow
        (cd "$DOTFILES_DIR" && stow "$dir")
    else
        echo "Warning: Directory $dir not found, skipping."
    fi
done

# 2. Handle standalone files (like starship.toml)
# These go into ~/.dotfiles/<name>/.config/<filename>
if [ -f "starship.toml" ]; then
    echo "Processing file: starship.toml"
    mkdir -p "$DOTFILES_DIR/starship/.config"
    mv "starship.toml" "$DOTFILES_DIR/starship/.config/"
    
    # Symlink it back using stow
    (cd "$DOTFILES_DIR" && stow starship)
else
    echo "Warning: starship.toml not found, skipping."
fi

echo "🎉 All dotfiles migrated and symlinked via GNU Stow!"


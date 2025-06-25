#!/usr/bin/env bash
# A rebuild script that commits on a successful build
set -e

# # cd to your config dir
# pushd ~/.config/nixos/

# # Edit your config
# code ~/.config/nixos/

# Autoformat your nix files
alejandra .

# Shows your changes
# git diff -U0 **/*.nix

echo "NixOS Rebuilding..."

# Fix issues with Nix not finding files
git add .

# Rebuild, output simplified errors, log tracebacks
sudo nixos-rebuild switch

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep True | awk '{print $1;}')

# Commit all changes witih the generation metadata
# If an argument is provided, append it to the commit message
git commit -am "$current"

# Back to where you were
# popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

#!/usr/bin/env bash
# A rebuild script that commits on a successful build
set -e

# # cd to your config dir
# pushd ~/.config/nixos/

# # Edit your config
# code ~/.config/nixos/

# If theres a `.git-hide` folder, move it back
if [ -d ./.git-hide ]; then
  mv ./.git-hide/.git .
  mv ./.git-hide/.gitignore .
  rmdir ./.git-hide
fi

# Autoformat your nix files
alejandra .

# Shows your changes
git diff -U0 **/*.nix

echo "NixOS Rebuilding..."

# Move git files so the git repo isn't cloned and instead the folder is.
# This way we can have a secrets.nix ignored by git and still have it in the system
# FIXME: This is a hack. Try a wrapping flake that provides secrets and turn
# this one here into an overlay?
mkdir -p ./.git-hide
mv .git ./.git-hide/
mv .gitignore ./.git-hide/

# Rebuild, output simplified errors, log tracebacks
sudo nixos-rebuild switch

# Move them back
mv ./.git-hide/.git .
mv ./.git-hide/.gitignore .
rmdir ./.git-hide

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
# If an argument is provided, append it to the commit message
git commit -am "$current"

# Back to where you were
# popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
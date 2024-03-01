# `ls` but better
# https://github.com/nix-community/home-manager/blob/master/modules/programs/eza.nix
{
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
  };
}
# A fast terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.kitty = {
    enable = true;
  };
}

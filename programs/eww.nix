# Custom top bar
# https://github.com/nix-community/home-manager/blob/master/modules/programs/eww.nix
{ PROJECT_ROOT, ... }:
{
  programs.eww = {
    enable = true;
    configDir = "${PROJECT_ROOT}/eww";
  };
}
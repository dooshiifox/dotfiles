# Custom top bar
# https://github.com/nix-community/home-manager/blob/master/modules/programs/eww.nix
{ PROGRAM_ROOT, ... }:
{
  programs.eww = {
    enable = true;
    configDir = "${PROGRAM_ROOT}/eww";
  };
}
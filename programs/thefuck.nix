# Corrects your previous shell command (typically because you forgot `sudo`)
# https://github.com/nix-community/home-manager/blob/master/modules/programs/thefuck.nix
{
  programs.thefuck = {
    enable = true;
    enableInstantMode = false;
  };
}
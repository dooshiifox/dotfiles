# Firefox web browser
# https://github.com/nix-community/home-manager/blob/master/modules/programs/firefox.nix
{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
  };
}

# Chromium web browser
# https://github.com/nix-community/home-manager/blob/master/modules/programs/chromium.nix
{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}

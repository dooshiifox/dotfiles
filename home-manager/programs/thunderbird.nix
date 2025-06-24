# Email client
# https://github.com/nix-community/home-manager/blob/master/modules/programs/thunderbird.nix
{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-bin;

    # Config in secrets.nix
  };
}

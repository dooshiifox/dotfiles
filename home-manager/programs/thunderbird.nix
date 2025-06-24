# Email client
# https://github.com/nix-community/home-manager/blob/master/modules/programs/thunderbird.nix
{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-bin;

    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
}

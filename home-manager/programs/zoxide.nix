# `cd` but better
# https://github.com/nix-community/home-manager/blob/master/modules/programs/zoxide.nix
{
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
}

# Neovim
# https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
{ config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = false;
    withNodeJs = true;
  };

  home.file."./.config/nvim/".source = config.lib.file.mkOutOfStoreSymlink ./nvim;
}

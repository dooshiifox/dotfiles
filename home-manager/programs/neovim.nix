# Neovim
# https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # plugins = with pkgs.vimPlugins; [
    #   nvchad
    # ];
  };
}

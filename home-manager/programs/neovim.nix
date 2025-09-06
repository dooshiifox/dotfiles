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

  home.file."./.config/nvim/".source =
    config.lib.file.mkOutOfStoreSymlink "${config.lib.theme.source-folder}/home-manager/programs/nvim";
  home.file."${config.lib.theme.source-folder}/home-manager/programs/nvim/lua/colors.lua".text =
    with config.lib.theme.colors; ''
      local cols = {}
      cols.bg = "${bg}"
      cols.black = "${black}"
      cols.bg_secondary = "${bg-secondary}"
      cols.dark_grey = "${dark-grey}"
      cols.bg_tertiary = "${bg-tertiary}"
      cols.grey = "${grey}"
      cols.light_grey = "${light-grey}"
      cols.fg_secondary = "${fg-secondary}"
      cols.fg = "${fg}"
      cols.white = "${white}"
      cols.brown = "${brown}"
      cols.red = "${red}"
      cols.pink = "${pink}"
      cols.orange = "${orange}"
      cols.yellow = "${yellow}"
      cols.cream = "${cream}"
      cols.green = "${green}"
      cols.lime = "${lime}"
      cols.dark_cyan = "${dark-cyan}"
      cols.cyan = "${cyan}"
      cols.dark_blue = "${dark-blue}"
      cols.light_blue = "${light-blue}"
      cols.magenta = "${magenta}"
      cols.light_magenta = "${light-magenta}"
      cols.border = "${border}"
      cols.border_active = "${border-active}"
      cols.accent = "${accent}"
      cols.accent_fg = "${accent-fg}"

      return cols
    '';
}

# Neovim
# https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
{ config, lib, ... }:
let
  nix-to-lua =
    i:
    if builtins.isAttrs i then
      let
        table = builtins.concatStringsSep ", " (
          builtins.attrValues (
            builtins.mapAttrs (
              name: value:
              let
                snake_case = lib.replaceString "-" "_" name;
              in
              "${snake_case} = ${nix-to-lua value}"
            ) i
          )
        );
      in
      "{ ${table} }"
    else if builtins.isList i then
      let
        list = builtins.concatStringsSep ", " (map nix-to-lua i);
      in
      "{ ${list} }"
    else if builtins.isString i then
      "\"${i}\""
    else
      toString i;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = false;
    withNodeJs = true;
    withRuby = false;
    withPython3 = false;
    sideloadInitLua = true; # https://github.com/nix-community/home-manager/issues/5982#issuecomment-4615838595
  };

  home.file."./.config/nvim/".source =
    config.lib.file.mkOutOfStoreSymlink "${config.lib.theme.source-folder}/home-manager/programs/nvim";
  home.file."${config.lib.theme.source-folder}/home-manager/programs/nvim/lua/colors.lua".text =
    with config.lib.theme.colors; ''
      local cols = {}
      cols.bg = "${base00}"
      cols.bg_raised = "${base01}"
      cols.bg_highlight = "${base02}"
      cols.grey = "${base03}"
      cols.fg_secondary = "${base04}"
      cols.fg = "${base05}"
      cols.fg_raised = "${base06}"
      cols.fg_highlight = "${base07}"
      cols.brown = "${base0F}"
      cols.red = "${base08}"
      cols.pink = "${base12}"
      cols.orange = "${base09}"
      cols.yellow = "${base0A}"
      cols.cream = "${base13}"
      cols.green = "${base0B}"
      cols.lime = "${base14}"
      cols.dark_cyan = "${base0C}"
      cols.cyan = "${base15}"
      cols.dark_blue = "${base0D}"
      cols.light_blue = "${base16}"
      cols.magenta = "${base0E}"
      cols.light_magenta = "${base17}"

      cols.border = "${border}"
      cols.border_active = "${border-active}"
      cols.accent = "${accent}"
      cols.accent_fg = "${accent-fg}"
      cols.is_dark = ${if variant == "dark" then "true" else "false"};

      cols.fg_color = ${nix-to-lua fg-color}
      cols.bg_color = ${nix-to-lua bg-color}

      return cols
    '';
}

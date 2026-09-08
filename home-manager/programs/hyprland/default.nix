args@{
  config,
  pkgs,
  ...
}:
let
  lua = import ../../../helpers/lua.nix args;
  theme = config.lib.theme;
  inherit (theme) colors hexaToRgbaString;
in
{
  # TODO: symlink "${pkgs.hyprland}/share/hypr/stubs" to a directory and
  # update .luarc.json
  xdg.configFile."hypr/hyprconfig.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${theme.source-folder}/home-manager/programs/hyprland/hyprconfig.lua";

  xdg.configFile."hypr/hyprextra.lua".text = ''
    local m = {
      colors = ${lua.nix-to-lua colors},
      border_active_opacity = "${hexaToRgbaString colors.border-active-opacity}",
      border_inactive_opacity = "${hexaToRgbaString colors.border-opacity}",
      radius = ${toString theme.border-radius},
      inactive_opacity = ${toString theme.opacity.unfocused}
    }

    return m
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    configType = "lua";
    extraConfig = ''
      require("hyprconfig")
    '';
  };

  home.pointerCursor = {
    enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 20;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };
  home.packages = with pkgs; [ bibata-cursors ];
}

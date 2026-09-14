# Records the screen
# https://github.com/nix-community/home-manager/blob/master/modules/programs/obs-studio.nix
{ pkgs, config, ... }: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  xdg.configFile."obs-studio/themes/Yami_Custom.ovt".text =
    let
      theme = config.lib.theme;
      inherit (theme) colors;

      variables =
        let
          like-background =
            base-color: amount:
            let
              opacity = amount * 0.17;
            in
            theme.darken-towards base-color colors.bg opacity;
          shade =
            base-color: name:
            builtins.listToAttrs (
              builtins.genList (i: {
                name = name + (toString (i + 1));
                value = like-background base-color i;
              }) 6
            );
        in
        (shade colors.red "red")
        // (shade colors.yellow "yellow")
        // (shade colors.lime "green")
        // (shade colors.dark-cyan "teal")
        // (shade colors.dark-blue "blue")
        // (shade colors.magenta "purple")
        // (shade colors.light-magenta "pink")
        // {
          white1 = colors.shades.grey."50";
          white2 = colors.shades.grey."100";
          white3 = colors.shades.grey."200";
          white4 = colors.shades.grey."300";
          white5 = colors.shades.grey."400";
          black5 = colors.shades.grey."600";
          black4 = colors.shades.grey."700";
          black3 = colors.shades.grey."800";
          black2 = colors.shades.grey."900";
          black1 = colors.shades.grey."950";

          # why the fuck are there 8 greys of such small differences.
          grey1 = colors.shades.grey."600";
          grey2 = colors.shades.grey."700";
          grey3 = colors.shades.grey."700";
          grey4 = colors.shades.grey."800";
          grey5 = colors.shades.grey."800";
          grey6 = colors.shades.grey."800";
          grey7 = colors.shades.grey."900";
          grey8 = colors.shades.grey."900";

          bg_window = colors.bg;
          bg_base = colors.bg-raised;
          bg_preview = colors.bg;

          primary_lighter = like-background colors.accent 1;
          primary_light = like-background colors.accent 2;
          primary = like-background colors.accent 3;
          primary_dark = like-background colors.accent 4;
          primary_darker = like-background colors.accent 5;

          warning = "var(--yellow3)";
          danger = "var(--red3)";

          text = "var(--white1)";
          text_light = "var(--white1)";
          text_muted = "var(--white5)";
          text_disabled = "var(--text_muted)";
          text_inactive = "var(--white1)";

          border_color = colors.border;
          border_radius = (toString theme.rounded.button) + "px";
          border_radius_small = (toString (theme.rounded.button / 2)) + "px";
          border_radius_large = (toString theme.rounded.window) + "px";
        };

      variables-css = builtins.concatStringsSep "\n  " (
        builtins.attrValues (builtins.mapAttrs (name: value: "--${name}: ${value};") variables)
      );
    in
    ''
      @OBSThemeMeta {
        name: 'Custom';
        id: 'com.obsproject.Yami.Custom';
        extends: 'com.obsproject.Yami';
        author: 'Warchamp7';
        dark: '${if theme.variant == "dark" then "true" else "false"}';
      }

      @OBSThemeVars {
        ${variables-css}
      }
    '';
}

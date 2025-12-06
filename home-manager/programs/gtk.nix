{
  pkgs,
  config,
  ...
}:
let
  extra-config = {
    gtk-application-prefer-dark-theme = if config.lib.theme.colors.variant == "light" then 0 else 1;
  };
  gtkcss = with config.lib.theme; ''
    @define-color accent_color ${colors.accent};
    @define-color accent_bg_color ${colors.accent};
    @define-color accent_fg_color ${on-color colors.accent};
    @define-color destructive_color ${colors.red};
    @define-color destructive_bg_color ${colors.red};
    @define-color destructive_fg_color ${on-color colors.red};
    @define-color success_color ${colors.lime};
    @define-color success_bg_color ${colors.lime};
    @define-color success_fg_color ${on-color colors.lime};
    @define-color warning_color ${colors.orange};
    @define-color warning_bg_color ${colors.orange};
    @define-color warning_fg_color ${on-color colors.orange};
    @define-color error_color ${colors.red};
    @define-color error_bg_color ${colors.red};
    @define-color error_fg_color ${on-color colors.red};
    @define-color window_bg_color ${colors.bg};
    @define-color window_fg_color ${colors.fg};
    @define-color view_bg_color ${colors.bg-raised};
    @define-color view_fg_color ${colors.fg};
    @define-color headerbar_bg_color ${colors.bg-raised};
    @define-color headerbar_fg_color ${colors.fg};
    @define-color headerbar_border_color ${colors.border};
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
    @define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.07);
    @define-color sidebar_bg_color ${colors.bg-raised};
    @define-color sidebar_fg_color ${colors.fg};
    @define-color sidebar_backdrop_color @window_bg_color;
    @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
    @define-color secondary_sidebar_bg_color ${colors.bg-raised};
    @define-color secondary_sidebar_fg_color @sidebar_fg_color;
    @define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;
    @define-color secondary_sidebar_shade_color @sidebar_shade_color;
    @define-color card_bg_color ${colors.bg-raised};
    @define-color card_fg_color ${colors.fg};
    @define-color card_shade_color rgba(0, 0, 0, 0.07);
    @define-color dialog_bg_color ${colors.bg-raised};
    @define-color dialog_fg_color ${colors.fg};
    @define-color popover_bg_color ${colors.bg-raised};
    @define-color popover_fg_color ${colors.fg};
    @define-color popover_shade_color rgba(0, 0, 0, 0.07);
    @define-color shade_color rgba(0, 0, 0, 0.07);
    @define-color scrollbar_outline_color ${colors.bg-raised};
    @define-color blue_1 ${colors.dark-blue};
    @define-color blue_2 ${colors.dark-blue};
    @define-color blue_3 ${colors.dark-blue};
    @define-color blue_4 ${colors.dark-blue};
    @define-color blue_5 ${colors.dark-blue};
    @define-color green_1 ${colors.green};
    @define-color green_2 ${colors.green};
    @define-color green_3 ${colors.green};
    @define-color green_4 ${colors.green};
    @define-color green_5 ${colors.green};
    @define-color yellow_1 ${colors.yellow};
    @define-color yellow_2 ${colors.yellow};
    @define-color yellow_3 ${colors.yellow};
    @define-color yellow_4 ${colors.yellow};
    @define-color yellow_5 ${colors.yellow};
    @define-color orange_1 ${colors.orange};
    @define-color orange_2 ${colors.orange};
    @define-color orange_3 ${colors.orange};
    @define-color orange_4 ${colors.orange};
    @define-color orange_5 ${colors.orange};
    @define-color red_1 ${colors.red};
    @define-color red_2 ${colors.red};
    @define-color red_3 ${colors.red};
    @define-color red_4 ${colors.red};
    @define-color red_5 ${colors.red};
    @define-color purple_1 ${colors.magenta};
    @define-color purple_2 ${colors.magenta};
    @define-color purple_3 ${colors.magenta};
    @define-color purple_4 ${colors.magenta};
    @define-color purple_5 ${colors.magenta};
    @define-color brown_1 ${colors.brown};
    @define-color brown_2 ${colors.brown};
    @define-color brown_3 ${colors.brown};
    @define-color brown_4 ${colors.brown};
    @define-color brown_5 ${colors.brown};
    @define-color light_1 ${colors.shades.grey."200"};
    @define-color light_2 ${colors.shades.grey."200"};
    @define-color light_3 ${colors.shades.grey."200"};
    @define-color light_4 ${colors.shades.grey."200"};
    @define-color light_5 ${colors.shades.grey."200"};
    @define-color dark_1 ${colors.shades.grey."900"};
    @define-color dark_2 ${colors.shades.grey."900"};
    @define-color dark_3 ${colors.shades.grey."900"};
    @define-color dark_4 ${colors.shades.grey."900"};
    @define-color dark_5 ${colors.shades.grey."900"};
  '';
in
{
  gtk = {
    enable = true;

    gtk3.extraConfig = extra-config;
    gtk4.extraConfig = extra-config;

    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    font = {
      inherit (config.lib.theme.fonts.regular) package name;
      size = 11;
    };
  };

  xdg.configFile = {
    "gtk-3.0/gtk.css".text = gtkcss;
    "gtk-4.0/gtk.css".text = gtkcss;
  };
}

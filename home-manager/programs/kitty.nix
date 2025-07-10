# A fast terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix
{ config, ... }:
let
  theme = config.lib.theme;
  colors = theme.colors;
in
{
  programs.kitty = {
    enable = true;
    settings.background_opacity = theme.opacity.bg;
    font = {
      inherit (theme.fonts.monospace) package name;
      size = 11;
    };

    shellIntegration = {
      enableFishIntegration = true;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    extraConfig = ''
      shell fish
      linux_display_server wayland
      wayland_enable_ime no
      hide_window_decorations yes
      cursor_blink_interval 0.5
      cursor_stop_blinking_after 1
      enable_audio_bell no
      window_padding_width 4
      dynamic_background_opacity yes
      wheel_scroll_multiplier 2.0

      background ${colors.bg}
      foreground ${colors.fg}
      selection_background ${colors.fg}
      selection_foreground ${colors.bg}

      cursor ${colors.fg}
      cursor_text_color ${colors.bg}

      url_color ${colors.accent}

      active_tab_background ${colors.bg}
      active_tab_foreground ${colors.fg}
      inactive_tab_background ${colors.bg-secondary}
      inactive_tab_foreground ${colors.fg-secondary}
      tab_bar_background ${colors.bg-tertiary}

      transparent_background_colors ${colors.bg} ${colors.bg-secondary} ${colors.bg-tertiary}

      color0 ${colors.base00}
      color1 ${colors.base08}
      color2 ${colors.base0B}
      color3 ${colors.base0A}
      color4 ${colors.base0D}
      color5 ${colors.base0E}
      color6 ${colors.base0C}
      color7 ${colors.base05}
      color8 ${colors.base02}
      color9 ${colors.base12}
      color10 ${colors.base14}
      color11 ${colors.base13}
      color12 ${colors.base16}
      color13 ${colors.base17}
      color14 ${colors.base15}
      color15 ${colors.base07}
      color16 ${colors.base09}
      color17 ${colors.base0F}
      color18 ${colors.base01}
      color19 ${colors.base02}
      color20 ${colors.base04}
      color21 ${colors.base06}

      tab_bar_edge top
      tab_bar_style slant
    '';
  };
}

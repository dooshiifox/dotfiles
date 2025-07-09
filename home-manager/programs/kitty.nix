# A fast terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix
{ config, ... }:
{
  programs.kitty = {
    enable = true;
    settings.background_opacity = config.lib.theme.opacity.bg;
    font = {
      inherit (config.lib.theme.fonts.monospace) package name;
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

      background ${config.lib.theme.colors.bg}
      foreground ${config.lib.theme.colors.fg}
      selection_background ${config.lib.theme.colors.fg}
      selection_foreground ${config.lib.theme.colors.bg}

      cursor ${config.lib.theme.colors.fg}
      cursor_text_color ${config.lib.theme.colors.bg}

      url_color ${config.lib.theme.colors.light-grey}

      active_tab_background ${config.lib.theme.colors.bg}
      active_tab_foreground ${config.lib.theme.colors.fg}
      inactive_tab_background ${config.lib.theme.colors.bg-secondary}
      inactive_tab_foreground ${config.lib.theme.colors.fg-secondary}
      tab_bar_background ${config.lib.theme.colors.bg-tertiary}

      color0 ${config.lib.theme.colors.base00}
      color1 ${config.lib.theme.colors.base08}
      color2 ${config.lib.theme.colors.base0B}
      color3 ${config.lib.theme.colors.base0A}
      color4 ${config.lib.theme.colors.base0D}
      color5 ${config.lib.theme.colors.base0E}
      color6 ${config.lib.theme.colors.base0C}
      color7 ${config.lib.theme.colors.base05}
      color8 ${config.lib.theme.colors.base02}
      color9 ${config.lib.theme.colors.base12}
      color10 ${config.lib.theme.colors.base14}
      color11 ${config.lib.theme.colors.base13}
      color12 ${config.lib.theme.colors.base16}
      color13 ${config.lib.theme.colors.base17}
      color14 ${config.lib.theme.colors.base15}
      color15 ${config.lib.theme.colors.base07}
      color16 ${config.lib.theme.colors.base09}
      color17 ${config.lib.theme.colors.base0F}
      color18 ${config.lib.theme.colors.base01}
      color19 ${config.lib.theme.colors.base02}
      color20 ${config.lib.theme.colors.base04}
      color21 ${config.lib.theme.colors.base06}

      tab_bar_edge top
      tab_bar_style slant
    '';
  };
}

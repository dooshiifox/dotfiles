# A fast terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix
{THEME, ...}: {
  programs.kitty = {
    enable = true;

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
      background_opacity ${builtins.toString THEME.bg-opacity}
      dynamic_background_opacity yes
      wheel_scroll_multiplier 2.0

      background ${THEME.bg}
      foreground ${THEME.fg}
      selection_background ${THEME.fg}
      selection_foreground ${THEME.bg}
      color0 ${THEME.black}
      color8 ${THEME.gray}
      color1 ${THEME.dark-red}
      color9 ${THEME.red}
      color2 ${THEME.dark-green}
      color10 ${THEME.green}
      color3 ${THEME.dark-yellow}
      color11 ${THEME.yellow}
      color4 ${THEME.dark-blue}
      color12 ${THEME.blue}
      color5 ${THEME.dark-purple}
      color13 ${THEME.purple}
      color6 ${THEME.dark-cyan}
      color14 ${THEME.cyan}
      color7 ${THEME.light-gray}
      color15 ${THEME.white}

      font_family      family="${THEME.monospace-font}"
      font_size 11
      bold_font        auto
      italic_font      auto
      bold_italic_font auto

      tab_bar_edge top
      tab_bar_style slant
    '';
  };
}

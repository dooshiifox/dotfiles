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
    font = {
      inherit (theme.fonts.monospace) package name;
      size = 11;
    };

    shellIntegration = {
      enableFishIntegration = true;
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

      clear_all_shortcuts yes
      kitty_mod ctrl+shift+alt+super

      map ctrl+c copy_or_interrupt
      map ctrl+shift+c copy_to_clipboard
      map F86Copy copy_to_clipboard
      map ctrl+shift+v paste_from_clipboard
      map F86Paste paste_from_clipboard
      map kitty_mod+t new_tab_with_cwd
      map kitty_mod+w close_tab
      map kitty_mod+h previous_tab
      map kitty_mod+i next_tab
      map kitty_mod+c copy_to_clipboard
      map kitty_mod+v paste_from_clipboard

      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono

      background ${colors.bg}
      foreground ${colors.fg}
      selection_background ${colors.fg}
      selection_foreground ${colors.bg}
      background_opacity ${toString theme.opacity.bg}
      transparent_background_colors ${colors.bg-secondary}@0.75 ${colors.bg-tertiary}@0.75

      cursor ${colors.fg}
      cursor_text_color ${colors.bg}

      url_color ${colors.accent}

      active_tab_background ${colors.bg-tertiary}
      active_tab_foreground ${colors.fg}
      inactive_tab_background ${colors.bg-secondary}
      inactive_tab_foreground ${colors.fg-secondary}
      tab_bar_background ${colors.bg}
      tab_bar_margin_color ${colors.bg}

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

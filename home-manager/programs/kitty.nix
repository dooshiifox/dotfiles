# A fast terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix
{
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
      window_padding_width 10
      background_opacity 0.85
      dynamic_background_opacity yes
      wheel_scroll_multiplier 2.0

      background #000008
      foreground #d3c6aa
      selection_foreground #1d2021
      selection_background #d5c4a1
      color0 #1d1f21
      color8 #4e5154
      color1 #e67e80
      color9 #f4babb
      color2 #a7c080
      color10 #d5eab4
      color3 #dbbc7f
      color11 #ead6ad
      color4 #7fbbb3
      color12 #beeae4
      color5 #d699b6
      color13 #efcbdd
      color6 #83c092
      color14 #bee5c8
      color7 #d7e2ea
      color15 #eff4f7

      color16 #fe8019
      color17 #d65d0e
      color18 #3c3836
      color19 #504945
      color20 #bdae93
      color21 #ebdbb2

      font_family      family="JetBrainsMonoNL Nerd Font Mono"
      font_size 11
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
    '';
  };
}

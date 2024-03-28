{}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      force_no_accel = true;
    };
    general = {
      gaps_in = 10;
      gaps_out = 20;
      border_size = 4;
      "col.active_border" = "rgb(f7768e) rgb(2ac3de)";
      "col.inactive_border" = "rgb(313244)";

      layout = "dwindle";
    };
    decoration = {
      rounding = 12;
      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        new_optimizations = true;
      };
      inactive_opacity = 1.0;
      active_opacity = 1.0;
      fullscreen_opacity = 1.0;

      drop_shadow = true;
      shadow_range = 60;
      shadow_offset = "0 5";
      shadow_render_power = 4;
      "col.shadow" = "rgba(00000099)";
    };
    animations = {
      enabled = true;
      bezier = [
        "fastBezier, 0.05, 1.1, 0.2, 1.0"
        "linear, 0.0, 0.0, 1.0, 1.0"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 7, fastBezier, slide"
        "windowsOut, 1, 7, fastBezier, slide"
        "border, 1, 10, fastBezier"
        "fade, 1, 7, fastBezier"
        "workspaces, 1, 6, fastBezier"
        "border, 1, 1, liner"
        "borderangle, 1, 40, liner, loop"
        "borderangle, 1, 100, linear, loop"
      ];
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
    master = {
      new_is_master = true;
    };
    gestures = {
      workspace_swipe = false;
    };
    device = {
      name = "glorious-model-o-wireless";
      sensitivity = "-0.5";
    };
    misc = {
      disable_hyprland_logo = true;
    };

    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox-developer-edition"
          "$mod, T, exec, alacritty"
          "$mod, E, exec, nautilus"
          "$mod, W, killactive,"
          "$mainMod, V, togglefloating,"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          # ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}

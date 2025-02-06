{pkgs, ...}: {
  home.packages = with pkgs; [bibata-cursors];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      monitor = [
        "HDMI-A-3,1920x1080@60,0x0,1"
        "eDP-1,3840x2160@144,1920x0,2"
      ];

      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox-developer-edition"
          "$mod, T, exec, alacritty"
          "$mod, E, exec, nautilus"
          "$mod, W, killactive,"
          "$mod, V, togglefloating,"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
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

      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        force_no_accel = true;
        natural_scroll = false;
        touchpad = {
          natural_scroll = true;
        };
      };
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(ffffff88)";
        "col.inactive_border" = "rgba(888a8f88)";

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

        shadow = {
          enabled = true;
          range = 8;
          render_power = 4;
          offset = "0 5";
          color = "rgba(00000099)";
        };
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
      };
      gestures = {
        workspace_swipe = true;
      };
      misc = {
        disable_hyprland_logo = true;
      };

      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,16"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
    };

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.<plugin>
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
}

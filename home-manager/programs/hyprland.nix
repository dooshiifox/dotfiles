{
  pkgs,
  inputs,
  PROJECT_ROOT,
  ...
}: {
  home.packages = with pkgs; [bibata-cursors];

  # programs.hyprland.withUWSM = true;
  # programs.uwsm.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # systemd.enable = false;
    xwayland.enable = true;

    settings = {
      monitor = [
        # Home External
        "desc:KOGAN AUSTRALIA PTY LTD KALED24144F,1920x1080@120,0x0,1"
        # Internal
        "desc:BOE 0x0BB7,3840x2160@144,1920x0,2"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox-developer-edition"
        "$mod, T, exec, kitty"
        "$mod, E, exec, nautilus"
        "$mod, W, killactive,"
        "$mod, V, togglefloating,"
        "$mod, M, exec, ${PROJECT_ROOT}/scripts/system/open-eww-overlay music-overlay"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        ", Print, exec, grimblast copy area"

        "$mod, 1, workspace, 1"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod, 2, workspace, 2"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod, 3, workspace, 3"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod, 5, workspace, 5"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod, 6, workspace, 6"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod, 7, workspace, 7"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod, 8, workspace, 8"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      bindr = [
        # Toggle whether rofi is open
        # Only activates when SUPER is released
        "SUPER, SUPER_L, exec, pkill rofi || rofi -show drun"
      ];
      # l - works on lockscreen
      # e - repeat, re-runs when key is held
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86MonBrightnessUp, exec, brightnessctl s 1+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 1-"
      ];
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
        "HYPRCURSOR_SIZE,20"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        # Prefer igpu
        "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
      ];

      exec-once = [
        "hyprpaper"
        "hyprsunset"
        "eww daemon"
        "eww open bar"
      ];

      windowrulev2 = [
        "float, class:Minecraft.*"
      ];

      "plugin:dynamic-cursors" = {
        mode = "none";
      };
    };

    plugins = with pkgs; [
      # Doesnt work due to compilation errors.
      # If re-enabling, remember to enable in inputs
      # inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors # Did you read the above comment?
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };
}

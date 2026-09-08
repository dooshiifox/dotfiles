{
  pkgs,
  config,
  for_profile,
  ...
}:
{
  home.packages = with pkgs; [ bibata-cursors ];

  # programs.hyprland.withUWSM = true;
  # programs.uwsm.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    configType = "lua";

    settings = {
      monitor = [
        # Home External
        "desc:KOGAN AUSTRALIA PTY LTD KALED24144F,1920x1080@120,0x0,1"
      ]
      ++ for_profile "old" [
        # Internal
        "desc:BOE 0x0BB7,3840x2160@144,1920x0,2"
      ]
      ++ for_profile "work" [
        # Internal
        "eDP-1,2880x1800@120,1920x0,2"
      ];

      bind = [
        "SUPER, T, exec, kitty"
        "SUPER, B, exec, librewolf"
        "SUPER, F, exec, nemo"
        "SUPER, M, exec, thunderbird"
        "SUPER, Space, exec, pkill rofi || rofi -show drun"
        "SUPER, C, exec, hyprpicker -a"
        "SUPER, W, killactive,"
        "SUPER, V, togglefloating,"
        "SUPER, H, movefocus, l"
        "SUPER, I, movefocus, r"
        "SUPER, E, movefocus, u"
        "SUPER, A, movefocus, d"
        "SUPER, Escape, swapactiveworkspaces, 0 1"
        ", Print, exec, grimblast copysave area ~/Pictures/screenshots/$(date +\"%Y%m%d_%H%M%S\").png"
        "SUPER, D, exec, wayscriber --active" # TODO: use systemd mode. how to auto-enable?

        "SUPER, 1, workspace, 1"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];

      # l - works on lockscreen
      # e - repeat, re-runs when key is held
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        # TODO: currently broken
        # hyprctl dispatch execr "brightnessctl s 10 2> /home/dooshii/hello"
        # has "Failed to set brightness: Invalid request descriptor"
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, rmpc togglepause" # mpc does not work here?????
        ", XF86AudioPrev, exec, rmpc prev"
        ", XF86AudioNext, exec, rmpc next"
      ];
      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
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
        "col.active_border" =
          config.lib.theme.hexaToRgbaString config.lib.theme.colors.border-active-opacity;
        "col.inactive_border" = config.lib.theme.hexaToRgbaString config.lib.theme.colors.border-opacity;

        layout = "dwindle";
      };
      decoration = {
        rounding = config.lib.theme.border-radius;
        blur = {
          enabled = true;
          size = 12;
          passes = 3;
          new_optimizations = true;
        };
        inactive_opacity = config.lib.theme.opacity.unfocused;
        active_opacity = 1.0;
        fullscreen_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 12;
          render_power = 4;
          offset = "0 2";
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
        preserve_split = true;
      };
      master = {
      };
      gestures.gesture = [
        "3, horizontal, workspace"
      ];
      misc = {
        disable_hyprland_logo = true;
      };

      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,20"
      ]
      ++ for_profile "old" [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        # Prefer igpu
        "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
      ];

      # exec-once = [
      #   # "cd ~/Documents/CodingProjects/mpd-rating/ && pnpm dev --host"
      #   # "${config.lib.theme.source-folder}/scripts/music/rng"
      #   "sudo systemctl start docker.service"
      #   "[workspace 1 silent; monitor eDP-1] librewolf"
      #   "[workspace 2 silent; monitor HDMI-A-1] kitty"
      #   "[workspace 3 silent; monitor eDP-1] vesktop"
      #   "[workspace 3 silent; monitor eDP-1] signal-desktop"
      #   "[workspace 3 silent; monitor eDP-1] Telegram"
      #   "[workspace 4 silent; monitor eDP-1] slack"
      #   "[workspace 4 silent; monitor eDP-1] thunderbird"
      #   "[workspace 4 silent; monitor eDP-1] karere"
      # ];

      windowrule = [
        {
          name = "float-minecraft";
          "match:class" = "Minecraft.*";
          float = "on";
        }
        {
          name = "float-bevy";
          "match:class" = "shortlike";
          float = "on";
        }
        {
          name = "float-jetbrains-popup";
          "match:class" = "(jetbrains-)(.*)";
          "match:title" = "^win(.*)";
          "match:initial_title" = "win.*";
          float = "on";
          no_initial_focus = "on";
        }
      ];

      device = [
        {
          # TODO: Script to switch between the two monitors
          # hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:output HDMI-A-1
          # hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:output eDP-1
          # Unfortunately, https://github.com/hyprwm/Hyprland/issues/5724
          name = "wdht1f01:00-2575:092e-stylus";
          output = "eDP-1";
        }
      ];

      debug = {
        disable_logs = false;
        disable_time = false;
        enable_stdout_logs = true;
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 20;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };
}

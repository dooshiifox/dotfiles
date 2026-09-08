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

    extraConfig = ''
      hl.monitor({
        output = "HDMI-A-1",
        mode = "1920x1080@120",
        position = "0x0",
        scale = 1
      })

      hl.monitor({
        output = "eDP-1",
        mode = "2880x1800@120",
        position = "1920x0",
        scale = 2
      })

      hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"))
      hl.bind("SUPER + B", hl.dsp.exec_cmd("librewolf"))

      hl.bind("SUPER + Space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))

      hl.bind("SUPER + W", hl.dsp.window.close())
      hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" ))

      hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" ))
      hl.bind("SUPER + A", hl.dsp.focus({ direction = "down" ))
      hl.bind("SUPER + E", hl.dsp.focus({ direction = "up" ))
      hl.bind("SUPER + I", hl.dsp.focus({ direction = "right" ))

      for i = 1, 10 do
        local key = i % 10 -- 10 maps to 0
        hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
    '';

    # settings = {
    #   bind = [
    #     # "SUPER + F, exec, nemo"
    #     # "SUPER + C, exec, hyprpicker -a"
    #     # "SUPER, Escape, swapactiveworkspaces, 0 1"
    #     # ", Print, exec, grimblast copysave area ~/Pictures/screenshots/$(date +\"%Y%m%d_%H%M%S\").png"
    #     # "SUPER, D, exec, wayscriber --active" # TODO: use systemd mode. how to auto-enable?
    #   ];
    #
    #   # l - works on lockscreen
    #   # e - repeat, re-runs when key is held
    #   # bindel = [
    #   #   ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    #   #   ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    #   #
    #   #   # TODO: currently broken
    #   #   # hyprctl dispatch execr "brightnessctl s 10 2> /home/dooshii/hello"
    #   #   # has "Failed to set brightness: Invalid request descriptor"
    #   #   ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
    #   #   ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
    #   # ];
    #   # bindl = [
    #   #   ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    #   #   ", XF86AudioPlay, exec, rmpc togglepause" # mpc does not work here?????
    #   #   ", XF86AudioPrev, exec, rmpc prev"
    #   #   ", XF86AudioNext, exec, rmpc next"
    #   # ];
    #   # bindm = [
    #   #   "SUPER,mouse:272,movewindow"
    #   #   "SUPER,mouse:273,resizewindow"
    #   # ];
    #   #
    #   # input = {
    #   #   kb_layout = "us";
    #   #   follow_mouse = 1;
    #   #   force_no_accel = true;
    #   #   natural_scroll = false;
    #   #   touchpad = {
    #   #     natural_scroll = true;
    #   #   };
    #   # };
    #   # general = {
    #   #   gaps_in = 4;
    #   #   gaps_out = 8;
    #   #   border_size = 2;
    #   #   "col.active_border" =
    #   #     config.lib.theme.hexaToRgbaString config.lib.theme.colors.border-active-opacity;
    #   #   "col.inactive_border" = config.lib.theme.hexaToRgbaString config.lib.theme.colors.border-opacity;
    #   #
    #   #   layout = "dwindle";
    #   # };
    #   # decoration = {
    #   #   rounding = config.lib.theme.border-radius;
    #   #   blur = {
    #   #     enabled = true;
    #   #     size = 12;
    #   #     passes = 3;
    #   #     new_optimizations = true;
    #   #   };
    #   #   inactive_opacity = config.lib.theme.opacity.unfocused;
    #   #   active_opacity = 1.0;
    #   #   fullscreen_opacity = 1.0;
    #   #
    #   #   shadow = {
    #   #     enabled = true;
    #   #     range = 12;
    #   #     render_power = 4;
    #   #     offset = "0 2";
    #   #     color = "rgba(00000099)";
    #   #   };
    #   # };
    #   # animations = {
    #   #   enabled = true;
    #   #   bezier = [
    #   #     "fastBezier, 0.05, 1.1, 0.2, 1.0"
    #   #     "linear, 0.0, 0.0, 1.0, 1.0"
    #   #     "liner, 1, 1, 1, 1"
    #   #   ];
    #   #   animation = [
    #   #     "windows, 1, 7, fastBezier, slide"
    #   #     "windowsOut, 1, 7, fastBezier, slide"
    #   #     "border, 1, 10, fastBezier"
    #   #     "fade, 1, 7, fastBezier"
    #   #     "workspaces, 1, 6, fastBezier"
    #   #     "border, 1, 1, liner"
    #   #     "borderangle, 1, 40, liner, loop"
    #   #     "borderangle, 1, 100, linear, loop"
    #   #   ];
    #   # };
    #   # dwindle = {
    #   #   preserve_split = true;
    #   # };
    #   # master = {
    #   # };
    #   # gestures.gesture = [
    #   #   "3, horizontal, workspace"
    #   # ];
    #   # misc = {
    #   #   disable_hyprland_logo = true;
    #   # };
    #   #
    #   # env = [
    #   #   "HYPRCURSOR_THEME,Bibata-Modern-Classic"
    #   #   "HYPRCURSOR_SIZE,20"
    #   # ]
    #   # ++ for_profile "old" [
    #   #   "LIBVA_DRIVER_NAME,nvidia"
    #   #   "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    #   #   "NVD_BACKEND,direct"
    #   #   # Prefer igpu
    #   #   "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
    #   # ];
    #   #
    #   # # exec-once = [
    #   # #   # "cd ~/Documents/CodingProjects/mpd-rating/ && pnpm dev --host"
    #   # #   # "${config.lib.theme.source-folder}/scripts/music/rng"
    #   # #   "sudo systemctl start docker.service"
    #   # #   "[workspace 1 silent; monitor eDP-1] librewolf"
    #   # #   "[workspace 2 silent; monitor HDMI-A-1] kitty"
    #   # #   "[workspace 3 silent; monitor eDP-1] vesktop"
    #   # #   "[workspace 3 silent; monitor eDP-1] signal-desktop"
    #   # #   "[workspace 3 silent; monitor eDP-1] Telegram"
    #   # #   "[workspace 4 silent; monitor eDP-1] slack"
    #   # #   "[workspace 4 silent; monitor eDP-1] thunderbird"
    #   # #   "[workspace 4 silent; monitor eDP-1] karere"
    #   # # ];
    #   #
    #   # windowrule = [
    #   #   {
    #   #     name = "float-minecraft";
    #   #     "match:class" = "Minecraft.*";
    #   #     float = "on";
    #   #   }
    #   #   {
    #   #     name = "float-bevy";
    #   #     "match:class" = "shortlike";
    #   #     float = "on";
    #   #   }
    #   #   {
    #   #     name = "float-jetbrains-popup";
    #   #     "match:class" = "(jetbrains-)(.*)";
    #   #     "match:title" = "^win(.*)";
    #   #     "match:initial_title" = "win.*";
    #   #     float = "on";
    #   #     no_initial_focus = "on";
    #   #   }
    #   # ];
    #   #
    #   # device = [
    #   #   {
    #   #     # TODO: Script to switch between the two monitors
    #   #     # hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:output HDMI-A-1
    #   #     # hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:output eDP-1
    #   #     # Unfortunately, https://github.com/hyprwm/Hyprland/issues/5724
    #   #     name = "wdht1f01:00-2575:092e-stylus";
    #   #     output = "eDP-1";
    #   #   }
    #   # ];
    #   #
    #   # debug = {
    #   #   disable_logs = false;
    #   #   disable_time = false;
    #   #   enable_stdout_logs = true;
    #   # };
    # };
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

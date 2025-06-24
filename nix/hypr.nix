{
  pkgs,
  inputs,
  ...
}: let
  dbus-hyprland-environment = pkgs.writeTextFile {
    name = "dbus-hyprland-environment";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber pipewire-media-session xdg-desktop-portal xdg-desktop-portal-hyprland
    '';
  };
in {
  environment = {
    systemPackages = with pkgs; [
      dbus-hyprland-environment
      wayland
      glib
      grim
      grimblast
      slurp
      satty
      swappy
      wl-clipboard
      cliphist
      waybar
      swaylock
      swaylock-fancy
      wlr-randr
      hyprpicker
      hyprcursor
      hyprpaper
      gnome-system-monitor
    ];
    etc."greetd/environments".text = ''
      Hyprland
    '';
    variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      WLR_DRM_NO_ATOMIC = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      XCURSOR_SIZE = "16";
      NIXOS_OZONE_WL = "1";
      HYPRCURSOR_THEME = "Bibata-Modern-Classic";
      HYPRCURSOR_SIZE = "16";
    };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = {
      common.default = "*";
    };
  };

  services.greetd = {
    enable = true;
    vt = 3;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        user = "dooshii";
      };
      default_session = initial_session;
    };
  };

  services.gnome = {
    gnome-keyring.enable = true;
    sushi.enable = true;
  };

  programs.hyprland.enable = true;
}

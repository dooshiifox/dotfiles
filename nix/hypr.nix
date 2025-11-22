{
  lib,
  profile,
  pkgs,
  ...
}:
let
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
in
{
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
      wlr-randr
      hyprpicker
      gnome-system-monitor
      hyprland-qtutils
      aquamarine
    ];
    etc."greetd/environments".text = ''
      Hyprland
    '';
    variables = {
      __GLX_VENDOR_LIBRARY_NAME = lib.mkIf (profile == "old") "nvidia";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XCURSOR_SIZE = "20";
      NIXOS_OZONE_WL = "1";
      HYPRCURSOR_THEME = "Bibata-Modern-Classic";
      HYPRCURSOR_SIZE = "20";
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
    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = rec {
      initial_session = {
        # start Hyprland with a TUI login manager
        command =
          let
            # https://github.com/ratatui/ratatui/blob/c7c34980254e4ffe6416cb8e20ba2c49300948a3/ratatui-core/src/style/color.rs#L8
            colors = {
              time = "lightred";
              container = "black";
              border = "grey";
              text = "white";
              greet = "lightblue";
              prompt = "lightgreen";
              input = "lightred";
              action = "lightblue";
              button = "yellow";
            };
            themestr = lib.concatMapAttrsStringSep ";" (name: val: "${name}=${val}") colors;
          in
          "${pkgs.tuigreet}/bin/tuigreet --time --remember --prompt-padding 3 --asterisks --asterisks-char · --theme '${themestr}' --cmd Hyprland";
        user = "greeter";
      };
      default_session = initial_session;
    };
  };

  services.gnome = {
    gnome-keyring.enable = true;
    sushi.enable = true;
  };

  services.udisks2.enable = true;

  programs.hyprland.enable = true;
  services.blueman.enable = true;
}

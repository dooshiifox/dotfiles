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
  imports = [
    ./hyprland.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      dbus-hyprland-environment
      wayland
      glib
      grim
      slurp
      satty
      wl-clipboard
      wlr-randr
      hyprpicker
      hyprcursor
      swww
    ];
    etc."greetd/environments".text = ''
      Hyprland
    '';
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      inputs.xdg-portal-hyprland.packages.${pkgs.system}.default
    ];
    config = {
      common.default = "*";
    };
  };
}

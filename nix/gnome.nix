_: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.defaultSession = "gnome-xorg";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}

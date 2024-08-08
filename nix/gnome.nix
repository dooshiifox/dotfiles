_: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.defaultSession = "gnome-xorg";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}

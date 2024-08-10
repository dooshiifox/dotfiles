{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xorg.xdpyinfo
    xorg.xrandr
    autorandr
    dmenu
    acpi
    feh
    xclip
    maim
    flameshot
    ghc
  ];

  systemd.services.upower.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    displayManager = {
      defaultSession = "none+xmonad";
    };

    xserver = {
      enable = true;
      autorun = true;

      displayManager = {
        # startx.enable = true;
        # lightdm.enable = false;
        # lightdm.enable = true;
        # lightdm = {
        #   greeters.enso = {
        #     enable = true;
        #     blur = true;
        #     extraConfig = ''
        #       default-wallpaper=/home/dooshii/Pictures/wallpaper/xenia-dark.png
        #     '';
        #   };
        # };
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };

    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };
  };
}

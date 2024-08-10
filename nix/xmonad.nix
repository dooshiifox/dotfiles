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

  services = {
    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };

    displayManager = {
      defaultSession = "none+xmonad";
    };

    xserver = {
      enable = true;
      autorun = true;

      displayManager = {
        defaultSession = "none+xmonad";
        # startx.enable = true;
        # lightdm.enable = false;
        # lightdm.enable = true;
        lightdm = {
          greeters.enso = {
            enable = true;
            blur = true;
            extraConfig = ''
              default-wallpaper=/home/dooshii/Pictures/wallpaper/xenia-dark.png
            '';
          };
        };
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = builtins.readFile ./xmonad.hs;
        enableConfiguredRecompile = true;
      };
    };

    # dbus = {
    #   enable = true;
    #   packages = [pkgs.dconf];
    # };
    autorandr.enable = true;
  };
}

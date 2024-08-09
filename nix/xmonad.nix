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
    displayManager = {
      # defaultSession = "none+xmonad";
    };

    xserver = {
      enable = true;
      # autorun = true;

      displayManager = {
        startx.enable = true;
        lightdm.enable = false;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = builtins.readFile ./xmonad.hs;
      };
    };

    # dbus = {
    #   enable = true;
    #   packages = [pkgs.dconf];
    # };
    # autorandr.enable = true;
  };
}

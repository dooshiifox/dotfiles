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
    xserver = {
      enable = true;
      autorun = true;

      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+xmonad";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = builtins.readFile ./xmonad.hs;
      };
      windowManager.default = "xmonad";
    };

    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };
    autorandr.enable = true;
  };
}

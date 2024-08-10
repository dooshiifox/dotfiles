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
      # autorun = true;

      displayManager = {
        startx.enable = true;
        # lightdm.enable = false;
        # lightdm.enable = true;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = builtins.readFile ./xmonad.hs;
        enableConfiguredRecompile = true;
      };
    };

    # dunst = {
    #   enable = true;
    #   iconTheme = {
    #     name = "Adwaita";
    #     package = pkgs.gnome.adwaita-icon-theme;
    #     size = "16x16";
    #   };
    #   settings = {
    #     global = {
    #       monitor = 0;
    #       geometry = "600x50-50+65";
    #       shrink = "yes";
    #       transparency = 10;
    #       padding = 16;
    #       horizontal_padding = 16;
    #       line_height = 4;
    #       format = ''<b>%s</b>\b%b'';
    #     };
    #   };
    # };

    # dbus = {
    #   enable = true;
    #   packages = [pkgs.dconf];
    # };
    # autorandr.enable = true;
  };

  # programs.rofi = {
  #   enable = true;
  #   terminal = "${pkgs.alacritty}/bin/alacritty";
  # };
}

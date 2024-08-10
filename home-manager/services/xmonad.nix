{pkgs, ...}: {
  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
    };
  };

  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 300;
      lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
      xautolock.extraOptions = [
        "Xautolock.killer: systemctl suspend"
      ];
    };

    dunst = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = "16x16";
      };
      settings = {
        global = {
          monitor = 0;
          geometry = "600x50-50+65";
          shrink = "yes";
          transparency = 10;
          padding = 16;
          horizontal_padding = 16;
          line_height = 4;
          format = ''<b>%s</b>\b%b'';
        };
      };
    };

    picom = {
      enable = true;
      activeOpacity = 1.0;
      inactiveOpacity = 0.8;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      opacityRules = ["100:name *= '13lock'"];
      shadow = true;
      shadowOpacity = 0.75;
      # NVIDIA
      vSync = true;
      settings = {
        blur-background = true;
        unredir-if-possible = false;
        blur = {
          method = "gaussian";
          size = 10;
          deviation = 5.0;
        };
        corner-radius = 4;
      };
    };

    # dbus = {
    #   enable = true;
    #   packages = [pkgs.dconf];
    # };
    autorandr.enable = true;
  };
}

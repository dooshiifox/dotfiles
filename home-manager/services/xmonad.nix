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

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
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
          format = ''<b>%s</b>\n%b'';
        };
      };
    };

    picom = {
      enable = true;
      activeOpacity = 1.0;
      inactiveOpacity = 0.9;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      opacityRules = ["100:name *= 'betterlockscreen'"];
      shadow = true;
      shadowOpacity = 0.75;
      # NVIDIA
      vSync = true;
      settings = {
        blur-background = true;
        unredir-if-possible = false;
        blur = {
          method = "gaussian";
          size = 20;
          deviation = 10.0;
        };
        corner-radius = 12;

        # Disable blur on the screenshotter
        shadow-exclude = [
          "class_g = 'firefox' && argb"
          "name = 'maim'"
        ];
        blur-background-exclude = [
          "name = 'maim'"
        ];
      };
    };

    autorandr.enable = true;
  };
}

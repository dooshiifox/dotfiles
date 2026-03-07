{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    # https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/#configuration
    settings = {
      ipc = true; # Default but just to be sure. Allows usage over hyprctl
      wallpaper = [
        {
          monitor = "";
          path = builtins.toString config.lib.theme.wallpaper;
        }
      ];
    };
  };
}

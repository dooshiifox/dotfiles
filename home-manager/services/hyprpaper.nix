{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true; # Default but just to be sure. Allows usage over hyprctl
      preload = builtins.toString config.lib.theme.wallpaper;
      wallpaper = ", " + builtins.toString config.lib.theme.wallpaper;
    };
  };
}

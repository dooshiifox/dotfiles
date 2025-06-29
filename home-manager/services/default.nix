{
  mode,
  lib,
  ...
}: {
  imports =
    [
      ./mpd.nix
    ]
    ++ lib.optionals (mode == "hypr") [
      ./mako.nix
      ./hypridle.nix
      ./hyprpaper.nix
      ./hyprpolkitagent.nix
      ./hyprsunset.nix
      ./udiskie.nix
    ]
    ++ lib.optionals (mode == "xmonad") [./xmonad.nix];
}

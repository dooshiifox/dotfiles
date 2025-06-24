{
  mode,
  lib,
  ...
}: {
  imports =
    [
      ./eww.nix
      ./mpd.nix
    ]
    ++ lib.optionals (mode == "hypr") [
      ./mako.nix
      ./hypridle.nix
      ./hyprpaper.nix
      ./hyprpolkitagent.nix
      ./hyprsunset.nix
    ]
    ++ lib.optionals (mode == "xmonad") [./xmonad.nix];
}

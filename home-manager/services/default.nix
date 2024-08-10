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
    ++ lib.optionals (mode == "hypr") [./mako.nix]
    ++ lib.optionals (mode == "xmonad") [./xmonad.nix];
}

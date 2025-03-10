{
  mode,
  lib,
  ...
}: {
  imports =
    [
      ./vscode
      ./alacritty.nix
      ./bat.nix
      ./chromium.nix
      ./dconf.nix
      ./eww.nix
      ./eza.nix
      ./firefox.nix
      ./fish.nix
      ./gh.nix
      ./git.nix
      ./gtk.nix
      ./librewolf.nix
      ./mpv.nix
      ./obs-studio.nix
      ./ripgrep.nix
      ./rofi.nix
      ./thefuck.nix
      ./thunderbird.nix
      ./yt-dlp.nix
      ./zoxide.nix
    ]
    ++ lib.optionals (mode == "hypr") [
      ./hyprland.nix
      ./pywal.nix
    ];
}

{
  pkgs,
  PROJECT_ROOT,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${PROJECT_ROOT}/home-manager/programs/rofi.rasi";
  };
}

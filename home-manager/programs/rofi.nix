{
  pkgs,
  PROJECT_ROOT,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = "${PROJECT_ROOT}/home-manager/programs/rofi.rasi";
  };
}

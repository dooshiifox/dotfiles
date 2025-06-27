{
  pkgs,
  THEME,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = "${THEME.source-folder}/home-manager/programs/rofi.rasi";
  };
}

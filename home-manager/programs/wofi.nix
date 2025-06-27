{THEME, ...}: {
  programs.wofi = {
    enable = false;
    style = "@theme \"${THEME.source-folder}/home-manager/programs/wofi.rasi\"";
  };
}

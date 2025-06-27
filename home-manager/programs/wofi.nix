{THEME, ...}: {
  programs.wofi = {
    enable = true;
    style = "@theme \"${THEME.source-folder}/home-manager/programs/wofi.rasi\"";
  };
}

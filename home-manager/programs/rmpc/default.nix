{ config, ... }:
{
  # https://mynixos.com/home-manager/options/programs.rmpc
  programs.rmpc.enable = true;
  xdg.configFile."rmpc/themes/dooshii.ron".source =
    config.lib.file.mkOutOfStoreSymlink "${config.lib.theme.source-folder}/home-manager/programs/rmpc/theme.ron";
  xdg.configFile."rmpc/config.ron".source =
    config.lib.file.mkOutOfStoreSymlink "${config.lib.theme.source-folder}/home-manager/programs/rmpc/config.ron";
}

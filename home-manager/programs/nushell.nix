{ config, ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = config.programs.fish.shellAliases;
  };
}

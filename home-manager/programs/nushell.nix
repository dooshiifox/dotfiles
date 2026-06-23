{ config, ... }:
{
  programs.nushell = {
    enable = true;
    # nushell uses `;` instead of `&&` for shell concatenation
    shellAliases = builtins.mapAttrs (
      k: v: builtins.replaceStrings [ "&&" ] [ ";" ] v
    ) config.programs.fish.shellAliases;
  };
}

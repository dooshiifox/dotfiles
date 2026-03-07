{ inputs, pkgs, ... }:
{
  programs.plover = {
    enable = true;
    package = inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover.withPlugins (
      ps: with ps; [
      ]
    );

    settings = {
      "Machine Configuration" = {
        auto_start = true;
      };
      "Output Configuration".undo_levels = 100;
    };
  };
}

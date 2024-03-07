# A better terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
{
  PROJECT_ROOT,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      "," = "clear";
      "cat" = "bat";
      "celeste" = "ulimit -n 8192 && /home/dooshii/Documents/Games/Celeste/Celeste";
      "ewwr" = "eww kill && eww daemon & disown $1 && eww open bar";
      "i" = "${PROJECT_ROOT}/scripts/system/init";
      "jk" = "cd ..";
      "jkk" = "cd ../..";
      "jkkk" = "cd ../../..";
      "jkkkk" = "cd ../../../..";
      "jkkkkk" = "cd ../../../../..";
      "l" = "exa -la";
      "ll" = "exa -l";
      "ls" = "exa";
      "mrng" = "${PROJECT_ROOT}/scripts/music/rng";
      "w" = "code /home/dooshii/Documents/CodingProjects/pin/work";
      "x" = "exit";
      "ytdlmp3" = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\" --embed-thumbnail";
    };
    functions = {
      mkcd = {
        body = "mkdir -p $argv; cd $argv;";
      };
      fish_greeting = {
        # Echo whatever you want here
        body = "";
      };
    };
    shellInit = ''
      set PRISMA_SCHEMA_ENGINE_BINARY ${pkgs.prisma-engines}/bin/schema-engine
      set PRISMA_QUERY_ENGINE_BINARY ${pkgs.prisma-engines}/bin/query-engine
      set PRISMA_QUERY_ENGINE_LIBRARY ${lib.getLib pkgs.prisma-engines}/lib/libquery_engine.node
      set PRISMA_FMT_BINARY ${pkgs.prisma-engines}/bin/prisma-fmt
    '';
  };
}

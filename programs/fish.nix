# A better terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
{ PROJECT_ROOT, ... }:  {
  programs.fish = {
    enable = true;
    shellAliases = {
      "," = "clear";
      "cat" = "bat $argv";
      "celeste" = "ulimit -n 8192 && /home/dooshii/Documents/Games/Celeste/Celeste";
      "ewwr" = "eww kill && ewwm 0 && eww daemon & disown $1 && eww open bar";
      "i" = "${PROJECT_ROOT}/scripts/init.fish $argv";
      "jk" = "cd ..";
      "jkk" = "cd ../..";
      "jkkk" = "cd ../../..";
      "jkkkk" = "cd ../../../..";
      "jkkkkk" = "cd ../../../../..";
      "l" = "exa -la $argv";
      "ll" = "exa -l $argv";
      "ls" = "exa $argv";
      "mrng" = "${PROJECT_ROOT}/music/rng $argv";
      "w" = "code /home/dooshii/Documents/CodingProjects/pin/work";
      "x" = "exit";
      "ytdlmp3" = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\" --embed-thumbnail $argv";
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
  };
}
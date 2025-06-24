# A better terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
{PROJECT_ROOT, ...}: {
  imports = [
    ../../secrets/fish.nix
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      "," = "clear";
      "cat" = "bat";
      "celeste" = "ulimit -n 8192 && /home/dooshii/Documents/Games/Celeste/Celeste";
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
      "code" = "codium";
    };
    functions = {
      mkcd = {
        body = "mkdir -p $argv; cd $argv;";
      };
      fish_greeting = {
        # Echo whatever you want here
        body = "";
      };
      nixs = {
        # Opens firefox at https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={query}
        body = "firefox \"https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=$argv\"";
      };
      use = {
        # Uses the provided nix packages in a new shell
        body = "nix-shell --command fish -p $argv";
      };
      mrat = {
        body = "cd ~/Documents/CodingProjects/mpd-rating/ && pnpm dev --host";
      };
    };
  };
}

# A better terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
{THEME, ...}: {
  imports = [
    ../../secrets/fish.nix
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      "," = "clear";
      "cat" = "bat";
      "celeste" = "ulimit -n 8192 && /home/dooshii/Documents/Games/Celeste/Celeste";
      "i" = "${THEME.source-folder}/scripts/system/init";
      "jk" = "cd ..";
      "jkk" = "cd ../..";
      "jkkk" = "cd ../../..";
      "jkkkk" = "cd ../../../..";
      "jkkkkk" = "cd ../../../../..";
      "l" = "exa -la";
      "ll" = "exa -l";
      "ls" = "exa";
      "mrng" = "${THEME.source-folder}/scripts/music/rng";
      "w" = "code /home/dooshii/Documents/CodingProjects/pin/work";
      "x" = "exit";
      "q" = "exit";
      "e" = "nvim";
      "ytdlmp3" = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\" --embed-thumbnail";
      "code" = "codium";
    };

    # Causes slow Nix builds when set to true
    generateCompletions = false;

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
        body = "firefox-devedition \"https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=$argv\"";
      };
      nixo = {
        # Opens firefox at https://mynixos.com/search?q={query}
        body = "firefox-devedition \"https://mynixos.com/search?q=$argv\"";
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

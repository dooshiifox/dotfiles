# A better terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
{ config, ... }:
{
  imports = [
    ../../secrets/fish.nix
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      "," = "clear";
      "cat" = "bat";
      "celeste" = "ulimit -n 8192 && /home/dooshii/Documents/Games/Celeste/Celeste";
      "i" = "${config.lib.theme.source-folder}/scripts/system/init";
      "jk" = "cd ..";
      "jkk" = "cd ../..";
      "jkkk" = "cd ../../..";
      "jkkkk" = "cd ../../../..";
      "jkkkkk" = "cd ../../../../..";
      "l" = "exa -la";
      "ll" = "exa -l";
      "ls" = "exa";
      "mrng" = "${config.lib.theme.source-folder}/scripts/music/rng";
      "ni" = "${config.lib.theme.source-folder}/scripts/nix-rebuild";
      "clean-old-gens" = "${config.lib.theme.source-folder}/scripts/clean-old-gens";
      "w" = "nvim /home/dooshii/Documents/CodingProjects/pin/work";
      "todo" = "nvim /home/dooshii/Documents/obsidian/Todo.md";
      "o" = "nvim /home/dooshii/Documents/obsidian/";
      "x" = "exit";
      "q" = "exit";
      "e" = "nvim";
      "ytdlmp3" = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\" --embed-thumbnail";
      "code" = "codium";
    };

    # Causes slow Nix builds when set to true
    generateCompletions = false;

    functions = {
      mkcd = "mkdir -p $argv; cd $argv;";
      # Echo whatever you want here
      fish_greeting = "";
      # Opens firefox at https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={query}
      nixs = "firefox-devedition \"https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=$argv\"";
      # Opens firefox at https://mynixos.com/search?q={query}
      nixo = "firefox-devedition \"https://mynixos.com/search?q=$argv\"";
      # Uses the provided nix packages in a new shell
      use = "nix-shell --command fish -p $argv";
      mrat = "cd ~/Documents/CodingProjects/mpd-rating/ && pnpm dev --host";
      auto_activate_venv = {
        # https://alexwlchan.net/2023/fish-venv/
        onVariable = "PWD";
        body = ''
          # Get the top-level directory of the current Git repo (if any)
          set REPO_ROOT (git rev-parse --show-toplevel 2>/dev/null)

          # Case #1: cd'd from a Git repo to a non-Git folder
          #
          # There's no virtualenv to activate, and we want to deactivate any
          # virtualenv which is already active.
          if test -z \"$REPO_ROOT\"; and test -n \"$VIRTUAL_ENV\"
              deactivate
          end

          # Case #2: cd'd folders within the same Git repo
          #
          # The virtualenv for this Git repo is already activated, so there's
          # nothing more to do.
          if [ \"$VIRTUAL_ENV\" = \"$REPO_ROOT/.venv\" ]
              return
          end

          # Case #3: cd'd from a non-Git folder into a Git repo
          #
          # If there's a virtualenv in the root of this repo, we should
          # activate it now.
          if [ -d \"$REPO_ROOT/.venv\" ]
              source \"$REPO_ROOT/.venv/bin/activate.fish\" &>/dev/null
          end'';
      };
      auto_git_fetch = {
        # https://github.com/avimehenwal/git-refresh/blob/7e5f88b9cb27d5fba22bcca34689067a989f1a3a/init.fish
        onVariable = "PWD";
        body = ''
          set --local hasGit (find ./ -maxdepth 1 -type d -name .git -print)
          if test "$hasGit" = "./.git"
          		echo -e "\e[1m(git-refresh) - GIT repo detected\e[0m"
          		git pull --all --verbose
          end'';
      };
    };
  };
}

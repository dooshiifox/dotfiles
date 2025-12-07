# A better terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
{
  config,
  profile,
  if_secrets,
  ...
}:
{
  imports = if_secrets [
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
      "ni" = "${config.lib.theme.source-folder}/scripts/nix-rebuild ${profile}";
      "clean-old-gens" = "${config.lib.theme.source-folder}/scripts/clean-old-gens";
      "bcdl" = "${config.lib.theme.source-folder}/scripts/bcdl";
      "todo" = "nvim /home/dooshii/Documents/obsidian/Todo.md";
      "o" = "nvim /home/dooshii/Documents/obsidian/";
      "x" = "exit";
      "q" = "exit";
      "e" = "nvim";
      "ytdlmp3" = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\" --embed-thumbnail";
      "code" = "codium";
      "audio" = "GSK_RENDERER=gl pavucontrol";
      "payroll-time" = "/home/dooshii/Documents/CodingProjects/payroll-time/target/release/payroll-time";
    };
    interactiveShellInit = ''
      set fish_command_color blue
    '';

    # Causes slow Nix builds when set to true
    generateCompletions = true;

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
      flip.body = ''
        if test $(hyprctl monitors -j | jq '.[] | select(.name=="eDP-1") | .transform') = 0
        	hyprctl keyword monitor eDP-1,2880x1800@120,0x0,2,transform,2
        	hyprctl -r -- keyword input:touchdevice:transform 2
          hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:transform 2
        else
        	hyprctl keyword monitor eDP-1,2880x1800@120,0x0,2,transform,0
        	hyprctl -r -- keyword input:touchdevice:transform 0
          hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:transform 0
        end
      '';
    };
  };
}

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
      "," = "clear && printf \"\\e[H\\e[3J\"";
      "cat" = "bat";
      "catt" = "bat -ppp";
      "celeste" = "ulimit -n 8192 && /home/dooshii/Documents/Games/celeste/Celeste";
      "l" = "exa -la";
      "ll" = "exa -l";
      "mrng" = "${config.lib.theme.source-folder}/scripts/music/rng";
      "ni" = "${config.lib.theme.source-folder}/scripts/nix-rebuild ${profile}";
      "clean-old-gens" = "${config.lib.theme.source-folder}/scripts/clean-old-gens";
      "bcdl" = "${config.lib.theme.source-folder}/scripts/bcdl";
      "todo" = "nvim /home/dooshii/Documents/notes/Todo.md";
      "n" = "nvim /home/dooshii/Documents/notes/";
      "x" = "exit";
      "q" = "exit";
      "e" = "nvim";
      "audio" = "GSK_RENDERER=gl pavucontrol";
      "payroll-time" = "/home/dooshii/Documents/CodingProjects/payroll-time/target/release/payroll-time";
      "shh" = "makoctl mode -t do-not-disturb";

      # Theres a monitor above the internal laptop monitor.
      "monitorabove" =
        "hyprctl keyword monitor HDMI-A-1,1920x1080@60,0x0,1 && hyprctl keyword monitor eDP-1,2880x1800@120,0x1080,2 && systemctl --user restart waybar";

      # Git
      "go" = "git checkout"; # git checkOut
      "gob" = "git checkout -b"; # git checkOut branch
      "gundo" = "git reset HEAD~"; # git undo
      "gd" = "git pull"; # git download
      "gu" = "git push"; # git upload
    };

    # Causes slow Nix builds when set to true and also breaks git integration
    generateCompletions = false;

    functions = rec {
      mkcd = "mkdir -p $argv; cd $argv;";
      # Echo whatever you want here
      fish_greeting = ''
        set -gx fish_command_color blue
      '';
      nixs = "$BROWSER \"https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=$argv\"";
      nixo = "$BROWSER \"https://mynixos.com/search?q=$argv\"";
      # Uses the provided nix packages in a new shell
      use = "nix-shell --command fish -p $argv";
      gy = "git commit -m \"$argv\"";
      # mrat = "cd ~/Documents/CodingProjects/mpd-rating/ && pnpm dev --host";
      # Search for a file
      rgfile = "find . -iname \"*$argv*\" -print";
      # Rerun the last command
      t = "last_cmd=$(history | head -1) eval $last_cmd";
      te = t;
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

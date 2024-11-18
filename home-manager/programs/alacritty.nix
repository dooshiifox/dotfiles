# A fast terminal
# https://github.com/nix-community/home-manager/blob/master/modules/programs/alacritty.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        bright = {
          black = "#4e5154";
          blue = "#beeae4";
          cyan = "#bee5c8";
          green = "#d5eab4";
          magenta = "#efcbdd";
          red = "#f4babb";
          white = "#eff4f7";
          yellow = "#ead6ad";
        };

        cursor = {
          cursor = "#d5c4a1";
          text = "#1d2021";
        };

        indexed_colors = [
          {
            color = "#fe8019";
            index = 16;
          }
          {
            color = "#d65d0e";
            index = 17;
          }
          {
            color = "#3c3836";
            index = 18;
          }
          {
            color = "#504945";
            index = 19;
          }
          {
            color = "#bdae93";
            index = 20;
          }
          {
            color = "#ebdbb2";
            index = 21;
          }
        ];

        normal = {
          black = "#1d1f21";
          blue = "#7fbbb3";
          cyan = "#83c092";
          green = "#a7c080";
          magenta = "#d699b6";
          red = "#e67e80";
          white = "#d7e2ea";
          yellow = "#dbbc7f";
        };

        primary = {
          background = "#2b3339";
          foreground = "#d3c6aa";
        };
      };

      font = {
        normal.family = "DankMono Nerd Font";
        size = 11.0;
      };

      keyboard.bindings = [
        {
          action = "Paste";
          key = "V";
          mode = "~Vi";
          mods = "Control|Shift|Alt";
        }
      ];

      terminal.shell.program = "fish";

      window = {
        dynamic_title = true;
        title = "Alacritty";
      };
    };
  };
}

root@{
  pkgs,
  lib,
  wallpaper,
  ...
}:
let
  color-lib = (import ../helpers/color.nix) root;

  /**
    Imports a file with the `light`, `dark`, `shades`, `name`, `slug`, and
    `author` attributes, and produces a light and dark variant of the theme.
  */
  light-dark =
    file:
    multiple-schemes (import file) [
      "light"
      "dark"
    ];

  multiple-schemes =
    theme: schemes:
    builtins.listToAttrs (
      map (scheme: {
        name = scheme;
        value = with-defaults (
          theme
          // {
            variant = scheme;
            colors = {
              inherit (theme) shades;
            }
            // (theme.colors or { })
            // theme.${scheme};
          }
        );
      }) schemes
    );

  with-defaults =
    theme:
    # deep merge the defaults with the actual theme.
    # does not merge arrays, they get overwritten
    lib.attrsets.recursiveUpdate rec {
      inherit (color-lib)
        hexWithOpacity
        hexToRgbaString
        hexaToRgbaString
        withoutHash
        color-lerp
        ;

      source-folder = "/home/dooshii/nixos";
      inherit wallpaper;

      opacity = rec {
        # The background in some apps will be multiplicative with opacity.bg
        unfocused = 0.95;
        bg = 0.9;
        border = bg;
      };
      border-radius = 12;

      inherit (theme) variant;
      on-color = bg: color-lib.highestContrast theme.colors.bg theme.colors.fg bg;

      # Fonts get installed automatically, however different languages will
      # need to be declared manually in apps. In addition, some apps only support
      # one font.
      fonts = rec {
        sansSerif = {
          en = {
            package = pkgs.quicksand;
            name = "Quicksand";
          };
          jp = {
            package = pkgs.noto-fonts-cjk-sans;
            name = "Noto Sans JP";
          };
        };
        serif = {
          en = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Serif";
          };
          jp = {
            package = pkgs.noto-fonts-cjk-serif;
            name = "Noto Serif JP";
          };
        };
        monospace = {
          en = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMonoNL Nerd Font Mono";
          };
        };
        regular = sansSerif;

        symbols = {
          package = pkgs.nerd-fonts.symbols-only;
          name = "Symbols Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      colors =
        let
          light-mode-color-lerp =
            fn: into:
            builtins.mapAttrs (
              name: hex:
              if variant == "light" && !(lib.hasPrefix "bg" name) && !(lib.hasPrefix "fg" name) then
                (fn hex into 0.4)
              else
                hex
            ) theme.colors;
        in
        rec {
          # Required
          system = "base24";
          inherit (theme)
            name
            slug
            author
            variant
            ;

          fg-color = light-mode-color-lerp color-lib.darken-towards colors.fg;
          bg-color = light-mode-color-lerp color-lib.brighten-towards colors.bg;

          bg-opacity = hexWithOpacity theme.colors.bg opacity.bg;
          bg-raised-opacity = hexWithOpacity theme.colors.bg-raised opacity.bg;
          bg-highlight-opacity = hexWithOpacity theme.colors.bg-highlight opacity.bg;
          bg-inset-opacity = hexWithOpacity theme.colors.bg-inset opacity.bg;
          bg-inset2-opacity = hexWithOpacity theme.colors.bg-inset2 opacity.bg;
          border-opacity = hexWithOpacity theme.colors.border opacity.border;
          border-active-opacity = hexWithOpacity theme.colors.border-active opacity.border;
          accent-fg = on-color fg-color.accent;

          # Alias
          gray = theme.colors.grey;

          base00 = theme.colors.bg;
          base01 = theme.colors.bg-raised;
          base02 = theme.colors.bg-highlight;
          base03 = theme.colors.grey;
          base04 = theme.colors.fg-secondary;
          base05 = theme.colors.fg;
          base06 = theme.colors.fg-raised;
          base07 = theme.colors.fg-highlight;
          base08 = fg-color.red;
          base09 = fg-color.orange;
          base0A = fg-color.yellow;
          base0B = fg-color.green;
          base0C = fg-color.dark-cyan;
          base0D = fg-color.dark-blue;
          base0E = fg-color.magenta;
          base0F = fg-color.brown;
          base10 = theme.colors.bg-inset;
          base11 = theme.colors.bg-inset2;
          base12 = fg-color.pink;
          base13 = fg-color.cream;
          base14 = fg-color.lime;
          base15 = fg-color.cyan;
          base16 = fg-color.light-blue;
          base17 = fg-color.light-magenta;
        };
    } theme;
in
{
  slate = light-dark ./slate.nix;
}

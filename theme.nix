root@{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pow =
    base: exponent:
    if exponent > 1 then
      let
        x = pow base (exponent / 2);
        odd_exp = lib.trivial.mod exponent 2 == 1;
      in
      x * x * (if odd_exp then base else 1)
    else if exponent == 1 then
      base
    else if exponent == 0 && base == 0 then
      throw "undefined"
    else if exponent == 0 then
      1
    else
      throw "undefined";
  decToHexMap = [
    "0"
    "1"
    "2"
    "3"
    "4"
    "5"
    "6"
    "7"
    "8"
    "9"
    "a"
    "b"
    "c"
    "d"
    "e"
    "f"
  ];
  hexToDecMap = {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    "a" = 10;
    "b" = 11;
    "c" = 12;
    "d" = 13;
    "e" = 14;
    "f" = 15;
  };
  base16To10 = exponent: scalar: scalar * pow 16 exponent;
  hexCharToDec =
    hex:
    let
      lowerHex = lib.strings.toLower hex;
    in
    if builtins.stringLength hex != 1 then
      throw "Function only accepts a single character."
    else if hexToDecMap ? ${lowerHex} then
      hexToDecMap."${lowerHex}"
    else
      throw "Character ${hex} is not a hexadecimal value.";
  hexToDec =
    hex:
    let
      decimals = builtins.map hexCharToDec (lib.strings.stringToCharacters hex);
      decimalsAscending = lib.lists.reverseList decimals;
      decimalsPowered = lib.lists.imap0 base16To10 decimalsAscending;
    in
    lib.lists.foldl builtins.add 0 decimalsPowered;
  withoutHash = hex: lib.strings.stringAsChars (x: if x == "#" then "" else x) hex;
  hexToRgb =
    hex: rgbStartIndexes:
    let
      hexWithoutHash = withoutHash hex;
      hexList = builtins.map (x: builtins.substring x 2 hexWithoutHash) rgbStartIndexes;
      hexLength = builtins.stringLength hexWithoutHash;
      expectedLength = builtins.length rgbStartIndexes * 2;
    in
    if hexLength != expectedLength then
      throw ''
        Unsupported hex string length of ${builtins.toString hexLength}.
        Length must be exactly ${expectedLength}.
      ''
    else
      builtins.map hexToDec hexList;
  hexToRGBString =
    sep: hex:
    let
      inherit (builtins) map toString;
      hexInRGB = hexToRgb hex [
        0
        2
        4
      ];
      hexInRGBString = map toString hexInRGB;
    in
    lib.strings.concatStringsSep sep hexInRGBString;
  hexToRgbaString = hex: opacity: "rgba(${hexToRGBString "," hex},${builtins.toString opacity})";

  hexaToRgbaString =
    hex:
    let
      inherit (builtins) toString elemAt;
      rgba = hexToRgb hex [
        0
        2
        4
        6
      ];
    in
    "rgba(${toString (elemAt rgba 0)},${toString (elemAt rgba 1)},${toString (elemAt rgba 2)},${
      toString ((elemAt rgba 3) / 255.0)
    })";

  to2Hex =
    num255:
    let
      num =
        if num255 > 255 then
          255
        else if num255 < 0 then
          0
        else
          num255;
    in
    "${builtins.elemAt decToHexMap (num / 16)}${builtins.elemAt decToHexMap (num - (num / 16) * 16)}";
  hexWithOpacity = hex: opacity: "${hex}${to2Hex (builtins.ceil (opacity * 255))}";
in
rec {
  imports = [ inputs.base16.nixosModule ];

  config.lib.theme = rec {
    opacity = rec {
      unfocused = 0.95;
      bg = 0.9;
      border = bg;
    };
    border-radius = 12;
    # The background in some apps will be multiplicative with
    # background-opacity

    # These should be nerd fonts
    fonts = rec {
      sansSerif = {
        package = pkgs.quicksand;
        name = "Quicksand";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMonoNL Nerd Font Mono";
      };
      regular = sansSerif;
      symbols = {
        package = pkgs.nerd-fonts.symbols-only;
        name = "Symbols Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    source-folder = "/home/dooshii/nixos";
    wallpaper = root.wallpaper;

    colors = rec {
      variant = "dark";
      bg = "#07070a";
      bg-secondary = black;
      bg-tertiary = dark-grey;
      fg-secondary = "#b0c6ce";
      fg = "#ced9dd";

      # variant = "light";
      # bg = "#edf4f7";
      # bg-secondary = "#ced9dd";
      # bg-tertiary = "#b0c6ce";
      # fg-secondary = "#373b41";
      # fg = "#07070a";

      black = "#1f2024";
      dark-grey = "#373b41";
      grey = "#545b65";
      light-grey = "#95a7be";
      white = "#edf4f7";
      brown = "#ab4b25";
      red = "#f36b88";
      pink = "#EBA0AC";
      orange = "#FAB387";
      yellow = "#f5dd8b";
      cream = "#fce9ce";
      green = "#7fb86d";
      lime = "#A6E3A1";
      dark-cyan = "#66c4b7";
      cyan = "#91d7e3";
      dark-blue = "#8c9de7";
      light-blue = "#81a2be";
      magenta = "#C6A0F6";
      light-magenta = "#F5BDE6";

      border = dark-grey;
      border-active = light-grey;
      accent = light-blue;
      # Text on an accent background
      accent-fg = black;

      bg-opacity = hexWithOpacity bg opacity.bg;
      bg-secondary-opacity = hexWithOpacity bg-secondary opacity.bg;
      bg-tertiary-opacity = hexWithOpacity bg-tertiary opacity.bg;
      border-opacity = hexWithOpacity border opacity.border;
      border-active-opacity = hexWithOpacity border-active opacity.border;

      # Required
      system = "base24";
      name = "Custom Theme";
      slug = "custom-theme";
      author = "dooshii";

      # Aliases
      dark-gray = dark-grey;
      gray = grey;
      light-gray = light-grey;

      base00 = bg;
      base01 = black;
      base02 = dark-grey;
      base03 = grey;
      base04 = light-grey;
      base05 = fg-secondary;
      base06 = fg;
      base07 = white;
      base08 = red;
      base09 = orange;
      base0A = yellow;
      base0B = green;
      base0C = dark-cyan;
      base0D = dark-blue;
      base0E = magenta;
      base0F = brown;
      base10 = bg-secondary;
      base11 = bg-tertiary;
      base12 = pink;
      base13 = cream;
      base14 = lime;
      base15 = cyan;
      base16 = light-blue;
      base17 = light-magenta;
    };

    inherit hexWithOpacity;
    inherit hexToRgbaString;
    inherit hexaToRgbaString;
    inherit withoutHash;
  };

  config.scheme = config.lib.theme.colors;
}

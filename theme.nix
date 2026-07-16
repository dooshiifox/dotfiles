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
    rgbStartIndexes: hex:
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
  hexToRgb3 = hexToRgb [
    0
    2
    4
  ];
  hexToRgb4 = hexToRgb [
    0
    2
    4
    6
  ];
  hexToRGBString =
    sep: hex:
    let
      inherit (builtins) map toString;
      hexInRGB = hexToRgb3 hex;
      hexInRGBString = map toString hexInRGB;
    in
    lib.strings.concatStringsSep sep hexInRGBString;
  hexToRgbaString = hex: opacity: "rgba(${hexToRGBString "," hex},${builtins.toString opacity})";

  hexaToRgbaString =
    hex:
    let
      inherit (builtins) toString elemAt;
      rgba = hexToRgb4 hex;
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

  rgbToHex = rgb: lib.strings.concatStrings (builtins.map to2Hex rgb);

  /**
    Type abs :: Float -> Float
  */
  abs = num: if num < 0 then -num else num;
  powi = base: exponent: if exponent == 0 then 1 else base * (powi base (exponent - 1));
  rootimpl =
    base: root: x: iter:
    if iter == 0 then
      x
    else
      # newtons method to solve for f(x) = 0, where
      # f(x) = x^(root) - base
      # ie, x^(root) = base
      # thus f'(x) = root * x^(root - 1)
      let
        f = (powi x root) - base;
        fp = root * (powi x (root - 1));
        x_next = x - f / fp;
      in
      if abs (x - x_next) < 0.0000001 then x else rootimpl base root x_next (iter - 1);
  rooti = base: root: rootimpl base root 1.0 25;
  powf =
    base: fraction-numerator: fraction-denominator:
    powi (rooti base fraction-denominator) fraction-numerator;
  /**
    convert sRGB to linear RGB
  */
  linearize =
    num:
    let
      sign = if num < 0 then -1 else 1;
    in
    # raise to 2.4
    sign * powf (abs num) 12 5;
  lum =
    col:
    (linearize (builtins.elemAt col 0)) * 0.2126729
    + (linearize (builtins.elemAt col 1)) * 0.7151522
    + (linearize (builtins.elemAt col 2)) * 0.072175;
  fclamp = y: if y >= 0.022 then y else y + powf (0.022 - y) 14 10;
  contrastApca =
    bg: text:
    let
      lumTxt = lum text;
      lumBg = lum bg;
      yTxt = fclamp lumTxt;
      yBg = fclamp lumBg;
      isBlackOnWhite = yBg > yTxt;
      c =
        if abs (yBg - yTxt) < 0.0005 then
          0
        else if isBlackOnWhite then
          # yBg ^ 0.56 - yTxt ^ 0.57
          ((powf yBg 14 25) - (powf yTxt 57 100)) * 1.14
        else
          # yBg ^ 0.65 - yTxt ^ 0.62
          ((powf yBg 13 20) - (powf yTxt 31 50)) * 1.14;
      sapc =
        if abs c < 0.1 then
          0
        else if c > 0 then
          c - 0.027
        else
          c + 0.027;
    in
    sapc * 100;
  highestContrast =
    text1: text2: background:
    let
      text1vec = hexToRgb3 text1;
      text2vec = hexToRgb3 text2;
      bgvec = hexToRgb3 background;
    in
    if abs (contrastApca bgvec text1vec) < abs (contrastApca bgvec text2vec) then text2 else text1;

  cbrt = num: powf num 1 3;

  srbgToLinear =
    n:
    let
      abs = lib.abs n;
      linear = if abs <= 0.04045 then abs / 12.92 else ((abs + 0.055) / 1.055);
    in
    if n < 0 then -linear else linear;
  hexToOklab = 1;

  lerp =
    a: b: t:
    a * (1 - t) + (b * t);
  color-lerp =
    from-hex: to-hex: percentage:
    from-hex;
in
rec {
  imports = [ inputs.base16.nixosModule ];

  config.lib.theme = rec {
    opacity = rec {
      # The background in some apps will be multiplicative with opacity.bg
      unfocused = 0.95;
      bg = 0.9;
      border = bg;
    };
    border-radius = 12;

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

    source-folder = "/home/dooshii/nixos";
    inherit (root) wallpaper;

    on-color = bg: highestContrast colors.bg colors.fg bg;

    # mode = "dark";
    variant = "dark";

    light = rec {
      bg = shades.grey."200";
      bg-raised = shades.grey."100";
      bg-highlight = shades.grey."50";
      bg-inset = shades.grey."300";
      bg-inset2 = shades.grey."400";
      grey = shades.grey."600";
      fg-secondary = shades.grey."800";
      fg = shades.grey."900";
      fg-raised = shades.grey."950";
      fg-highlight = shades.grey."950";
      border = shades.grey."400";
      border-active = shades.grey."600";
      accent = cyan;

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
      light-blue = "#abc4fd";
      # TODO:
      magenta = "#C6A0F6";
      light-magenta = "#F5BDE6";
    };
    dark = rec {
      bg = shades.grey."950";
      bg-raised = shades.grey."900";
      bg-highlight = shades.grey."800";
      bg-inset = "#000000";
      bg-inset2 = "#000000";
      grey = shades.grey."400";
      fg-secondary = shades.grey."300";
      fg = shades.grey."200";
      fg-raised = shades.grey."100";
      fg-highlight = shades.grey."50";
      border = bg-highlight;
      border-active = grey;
      accent = light-blue;

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
      light-blue = "#abc4fd";
      # TODO:
      magenta = "#C6A0F6";
      light-magenta = "#F5BDE6";
    };

    shades = {
      grey = {
        "50" = "#ffffff";
        "100" = "#edf4f7";
        "200" = "#ced9dd";
        "300" = "#b0c6ce";
        "400" = "#95a7be";
        "600" = "#545b65";
        "800" = "#373b41";
        "900" = "#1f2024";
        "950" = "#07070a";
      };
    };

    active-theme = if variant == "light" then light else dark;

    colors = active-theme // {
      # Required
      system = "base24";
      name = "Custom Theme";
      slug = "custom-theme";
      author = "dooshii";
      inherit variant shades;

      bg-opacity = hexWithOpacity active-theme.bg opacity.bg;
      bg-raised-opacity = hexWithOpacity active-theme.bg-raised opacity.bg;
      bg-highlight-opacity = hexWithOpacity active-theme.bg-highlight opacity.bg;
      bg-inset-opacity = hexWithOpacity active-theme.bg-inset opacity.bg;
      bg-inset2-opacity = hexWithOpacity active-theme.bg-inset2 opacity.bg;
      border-opacity = hexWithOpacity active-theme.border opacity.border;
      border-active-opacity = hexWithOpacity active-theme.border-active opacity.border;
      accent-fg = on-color active-theme.light-blue;

      # Alias
      gray = active-theme.grey;

      base00 = active-theme.bg;
      base01 = active-theme.bg-raised;
      base02 = active-theme.bg-highlight;
      base03 = active-theme.grey;
      base04 = active-theme.fg-secondary;
      base05 = active-theme.fg;
      base06 = active-theme.fg-raised;
      base07 = active-theme.fg-highlight;
      base08 = active-theme.red;
      base09 = active-theme.orange;
      base0A = active-theme.yellow;
      base0B = active-theme.green;
      base0C = active-theme.dark-cyan;
      base0D = active-theme.dark-blue;
      base0E = active-theme.magenta;
      base0F = active-theme.brown;
      base10 = active-theme.bg-inset;
      base11 = active-theme.bg-inset2;
      base12 = active-theme.pink;
      base13 = active-theme.cream;
      base14 = active-theme.lime;
      base15 = active-theme.cyan;
      base16 = active-theme.light-blue;
      base17 = active-theme.light-magenta;
    };

    inherit hexWithOpacity;
    inherit hexToRgbaString;
    inherit hexaToRgbaString;
    inherit withoutHash;
  };

  config.scheme = config.lib.theme.colors;
}

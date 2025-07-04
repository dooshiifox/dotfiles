{lib, ...}: rec {
  # The background in some apps will be multiplicative with
  # background-opacity
  unfocused-opacity = 0.9;
  bg-opacity = 0.85;
  border-opacity = bg-opacity;
  border-radius = 12;

  # These should be nerd fonts
  monospace-font = "JetBrainsMonoNL Nerd Font Mono";
  regular-font = "Quicksand";
  nerd-font = "Symbols Nerd Font";
  source-folder = "/home/dooshii/nixos";
  wallpaper = "/home/dooshii/Pictures/wallpaper/jacato_float.png";

  # The color scheme - can be `light` or `dark`
  scheme = "dark";
  # The main background colour
  bg = "#07070a";
  # The primary text colour, for important text
  fg = "#c5c8c6";
  black = "#1f2024";
  # Used for borders and focused items
  gray = "#373b41";
  dark-red = "#a54242";
  # Used as an error colour
  red = "#cc6666";
  dark-green = "#8c9440";
  # Used as a success colour
  green = "#b5bd68";
  # Used as a warning colour
  dark-yellow = "#de935f"; # Frequently orange
  yellow = "#f0c674";
  dark-blue = "#5f819d";
  # Used as an info colour
  blue = "#81a2be";
  dark-purple = "#85678f";
  purple = "#b294bb";
  dark-cyan = "#5e8d87";
  cyan = "#8abeb7";
  # The secondary text colour, for less important text
  light-gray = "#95a7be";
  white = "#c2d2d6";

  pow = base: exponent:
    if exponent > 1
    then let
      x = pow base (exponent / 2);
      odd_exp = lib.trivial.mod exponent 2 == 1;
    in
      x
      * x
      * (
        if odd_exp
        then base
        else 1
      )
    else if exponent == 1
    then base
    else if exponent == 0 && base == 0
    then throw "undefined"
    else if exponent == 0
    then 1
    else throw "undefined";
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
  hexCharToDec = hex: let
    lowerHex = lib.strings.toLower hex;
  in
    if builtins.stringLength hex != 1
    then throw "Function only accepts a single character."
    else if hexToDecMap ? ${lowerHex}
    then hexToDecMap."${lowerHex}"
    else throw "Character ${hex} is not a hexadecimal value.";
  hexToDec = hex: let
    decimals = builtins.map hexCharToDec (lib.strings.stringToCharacters hex);
    decimalsAscending = lib.lists.reverseList decimals;
    decimalsPowered = lib.lists.imap0 base16To10 decimalsAscending;
  in
    lib.lists.foldl builtins.add 0 decimalsPowered;
  hexToRGB = hex: let
    rgbStartIndex = [0 2 4];
    hexWithoutHash = lib.strings.stringAsChars (x:
      if x == "#"
      then ""
      else x)
    hex;
    hexList = builtins.map (x: builtins.substring x 2 hexWithoutHash) rgbStartIndex;
    hexLength = builtins.stringLength hexWithoutHash;
  in
    if hexLength != 6
    then
      throw ''
        Unsupported hex string length of ${builtins.toString hexLength}.
        Length must be exactly 6.
      ''
    else builtins.map hexToDec hexList;
  hexToRGBString = sep: hex: let
    inherit (builtins) map toString;
    hexInRGB = hexToRGB hex;
    hexInRGBString = map toString hexInRGB;
  in
    lib.strings.concatStringsSep sep hexInRGBString;
  hexToRgbaString = hex: opacity: "rgba(${hexToRGBString "," hex},${builtins.toString opacity})";
  to2Hex = num255: let
    num =
      if num255 > 255
      then 255
      else if num255 < 0
      then 0
      else num255;
  in "${builtins.elemAt decToHexMap (num / 16)}${builtins.elemAt decToHexMap (num - (num / 16) * 16)}";
  hexWithOpacity = hex: opacity: "${hex}${to2Hex (builtins.ceil (opacity * 255))}";
}

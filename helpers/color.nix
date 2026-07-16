inputs@{ lib, ... }:
rec {
  math = (import ./math.nix) inputs;

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
  base16To10 = exponent: scalar: scalar * math.pow 16 exponent;
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

  rgbToHex = rgb: "#${lib.strings.concatStrings (builtins.map to2Hex rgb)}";

  /**
    convert sRGB to linear RGB
  */
  linearize =
    num:
    let
      sign = if num < 0 then -1 else 1;
    in
    # raise to 2.4
    sign * math.powf (math.abs num) 12 5;
  lum =
    col:
    (linearize (builtins.elemAt col 0)) * 0.2126729
    + (linearize (builtins.elemAt col 1)) * 0.7151522
    + (linearize (builtins.elemAt col 2)) * 0.072175;
  fclamp = y: if y >= 0.022 then y else y + math.powf (0.022 - y) 14 10;
  contrastApca =
    bg: text:
    let
      lumTxt = lum text;
      lumBg = lum bg;
      yTxt = fclamp lumTxt;
      yBg = fclamp lumBg;
      isBlackOnWhite = yBg > yTxt;
      c =
        if math.abs (yBg - yTxt) < 0.0005 then
          0
        else if isBlackOnWhite then
          # yBg ^ 0.56 - yTxt ^ 0.57
          ((math.powf yBg 14 25) - (math.powf yTxt 57 100)) * 1.14
        else
          # yBg ^ 0.65 - yTxt ^ 0.62
          ((math.powf yBg 13 20) - (math.powf yTxt 31 50)) * 1.14;
      sapc =
        if math.abs c < 0.1 then
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
    if math.abs (contrastApca bgvec text1vec) < math.abs (contrastApca bgvec text2vec) then
      text2
    else
      text1;

  # https://github.com/dkryaklin/colordx/blob/main/src/transfer.ts
  srgbToLinear =
    n:
    let
      abs = math.abs n;
      linear = if abs <= 0.04045 then abs / 12.92 else math.powf ((abs + 0.055) / 1.055) 24 10;
    in
    if n < 0 then -linear else linear;
  srgbFromLinear =
    n:
    let
      abs = math.abs n;
      encoded = if abs <= 0.0031308 then 12.92 * abs else 1.055 * (math.powf abs 10 24) - 0.055;
    in
    if n < 0 then -encoded else encoded;

  normalizeHue = math.mod 360;

  # OKLAB
  # https://github.com/dkryaklin/colordx/blob/main/src/colorModels/oklab.ts
  hexToOklab =
    hex:
    let
      rgb = hexToRgb3 hex;
      lsrgb = builtins.map (x: srgbToLinear (x / 255.0)) rgb;
    in
    (lsrgbToOklab lsrgb);
  lsrgbToOklab =
    lsrgb:
    let
      r = builtins.elemAt lsrgb 0;
      g = builtins.elemAt lsrgb 1;
      b = builtins.elemAt lsrgb 2;
      lv = math.cbrt (0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b);
      mv = math.cbrt (0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b);
      sv = math.cbrt (0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b);
    in
    [
      (0.2104542553 * lv + 0.793617785 * mv + -0.0040720468 * sv)
      (1.9779984951 * lv + -2.428592205 * mv + 0.4505937099 * sv)
      (0.0259040371 * lv + 0.7827717662 * mv + -0.808675766 * sv)
    ];
  oklabToRgb =
    oklab:
    let
      l = builtins.elemAt oklab 0;
      a = builtins.elemAt oklab 1;
      b = builtins.elemAt oklab 2;
    in
    if a == 0 && b == 0 then
      let
        v = math.powi l 3;
        srgb = lib.floor (srgbFromLinear (math.clamp v 0 1) * 255);
        clamped = math.clamp srgb 0 255;
      in
      [
        clamped
        clamped
        clamped
      ]
    else
      let
        l_ = l + 0.3963377774 * a + 0.2158037573 * b;
        m_ = l - 0.1055613458 * a - 0.0638541728 * b;
        s_ = l - 0.0894841775 * a - 1.291485548 * b;
        lv = math.powi l_ 3;
        mv = math.powi m_ 3;
        sv = math.powi s_ 3;
        r = 4.0767416613 * lv - 3.3077115904 * mv + 0.2309699287 * sv;
        g = -1.2684380041 * lv + 2.6097574007 * mv - 0.3413193963 * sv;
        bv = -0.0041960865 * lv - 0.7034186145 * mv + 1.7076147009 * sv;
      in
      [
        (math.clamp (lib.floor (srgbFromLinear (math.clamp r 0 1) * 255)) 0 255)
        (math.clamp (lib.floor (srgbFromLinear (math.clamp g 0 1) * 255)) 0 255)
        (math.clamp (lib.floor (srgbFromLinear (math.clamp bv 0 1) * 255)) 0 255)
      ];
  oklabToHex = oklab: rgbToHex (oklabToRgb oklab);

  # OKLCH
  # https://github.com/dkryaklin/colordx/blob/main/src/colorModels/oklch.ts
  oklchToOklab =
    oklch:
    let
      l = builtins.elemAt oklch 0;
      c = builtins.elemAt oklch 1;
      h = builtins.elemAt oklch 2;
    in
    [
      l
      (c * math.cos ((h * math.pi) / 180.))
      (c * math.sin ((h * math.pi) / 180.))
    ];

  hexToOklch =
    hex:
    let
      oklab = hexToOklab hex;
      l = builtins.elemAt oklab 0;
      a = builtins.elemAt oklab 1;
      b = builtins.elemAt oklab 2;
      c = math.sqrt (a * a + b * b);
      h = (math.atan2 b a) * 180. / math.pi;
    in
    [
      l
      c
      (if c < 0.000004 then 0 else normalizeHue h)
    ];
  oklchToHex = oklch: oklabToHex (oklchToOklab oklch);

  color-lerp =
    from-hex: to-hex: percentage:
    let
      from-oklch = hexToOklch from-hex;
      to-oklch = hexToOklch to-hex;
      lerped =
        let
          from-hue = builtins.elemAt from-oklch 2;
          to-hue = builtins.elemAt to-oklch 2;
          to-hue-alt = if to-hue > 180 then to-hue - 360 else to-hue + 360;
          to-hue-correct =
            if math.abs (from-hue - to-hue) < math.abs (from-hue - to-hue-alt) then to-hue else to-hue-alt;
        in
        [
          (math.lerp (builtins.elemAt from-oklch 0) (builtins.elemAt to-oklch 0) percentage)
          (math.lerp (builtins.elemAt from-oklch 1) (builtins.elemAt to-oklch 1) percentage)
          (math.lerp from-hue to-hue-correct percentage)
        ];
    in
    oklchToHex lerped;

  brightness-towards =
    darken-hex: towards-hex: percentage:
    let
      from-oklch = hexToOklch darken-hex;
      to-oklch = hexToOklch towards-hex;
      lerped = [
        # lerp the lightness from one to the other,
        # lerp the chroma from the current value to 1,
        # keep the current hue
        (math.lerp (builtins.elemAt from-oklch 0) (builtins.elemAt to-oklch 0) percentage)
        (math.lerp (builtins.elemAt from-oklch 1) 1 percentage)
        (builtins.elemAt from-oklch 2)
      ];
    in
    oklchToHex lerped;
}

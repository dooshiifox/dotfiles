rec {
  name = "Jacato Green";
  slug = "jacato-green";
  author = "dooshii";

  opacity = rec {
    # The background in some apps will be multiplicative with opacity.bg
    unfocused = 0.9;
    bg = 0.85;
    border = bg;
  };
  border-radius = 4;

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

    brown = "#885a3d";
    red = "#ff757e";
    pink = "#f6b1b2";
    orange = "#f5ae5e";
    yellow = "#f3df5a";
    cream = "#fde2cf";
    green = "#3e6829";
    lime = "#addd5d";
    dark-cyan = "#55afbf";
    cyan = "#74cfd1";
    dark-blue = "#79a5cb";
    light-blue = "#abc4fd";
    # TODO:
    magenta = "#c1a2ff";
    light-magenta = "#ff9dd0";
  };

  shades = {
    grey = {
      "50" = "#ffffff";
      "100" = "#eff4e7";
      "200" = "#d8e0d3";
      "300" = "#bfcabe";
      "400" = "#acb8ab";
      "600" = "#586656";
      "800" = "#3c4239";
      "900" = "#21231f";
      "950" = "#0f110e";
    };
  };
}

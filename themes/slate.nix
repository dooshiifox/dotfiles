rec {
  name = "Custom Theme";
  slug = "custom-theme";
  author = "dooshii";

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
}

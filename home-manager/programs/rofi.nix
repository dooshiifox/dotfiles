{
  pkgs,
  THEME,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    # theme = "${THEME.source-folder}/home-manager/programs/rofi.rasi";
    modes = ["drun"];
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      background = mkLiteral (THEME.hexWithOpacity THEME.bg THEME.bg-opacity);
      active = mkLiteral (THEME.hexWithOpacity THEME.gray THEME.bg-opacity);
      text = mkLiteral THEME.fg;
      secondary-text = mkLiteral THEME.light-gray;
    in {
      # Main
      window = {
        height = 512;
        width = 800;
        transparency = "real";
        fullscreen = false;
        enabled = true;
        cursor = "default";
        spacing = 0;
        padding = 0;
        border = 1;
        border-color = mkLiteral (THEME.hexWithOpacity THEME.light-gray THEME.border-opacity);
        border-radius = THEME.border-radius;
        background-color = mkLiteral "transparent";
      };

      mainbox = {
        enabled = true;
        spacing = 0;
        padding = 0;
        orientation = mkLiteral "vertical";
        children = ["inputbar" "listbox"];
        background-color = mkLiteral "transparent";
      };

      # Inputs
      inputbar = {
        enabled = true;
        spacing = 0;
        padding = 32;
        children = ["textbox-prompt-colon" "entry"];
        background-color = mkLiteral "transparent";
      };

      textbox-prompt-colon = {
        enabled = true;
        expand = false;
        str = "  ";
        padding = mkLiteral "12px 4px 0 0";
        text-color = text;
        background-color = background;
        border-radius = mkLiteral "12px 0px 0px 12px";
      };

      entry = {
        enabled = true;
        border-radius = mkLiteral "0 12px 12px 0";
        spacing = 12;
        padding = 12;
        text-color = text;
        cursor = mkLiteral "text";
        placeholder = "Search";
        background-color = background;
        placeholder-color = secondary-text;
      };

      # Lists
      listbox = {
        padding = 0;
        spacing = 0;
        orientation = mkLiteral "horizontal";
        children = ["listview"];
        background-color = background;
      };

      listview = {
        padding = 24;
        spacing = 8;
        enabled = true;
        columns = 2;
        lines = 3;
        cycle = true;
        dynamic = false;
        scrollbar = true;
        layout = mkLiteral "vertical";
        flow = mkLiteral "horizontal";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        cursor = "default";
        background-color = mkLiteral "transparent";
        text-color = text;
      };

      scrollbar = {
        background-color = background;
        handle-rounded-corners = true;
        handle-color = active;
      };

      button = {
        cursor = mkLiteral "pointer";
        border-radius = THEME.border-radius;
        background-color = background;
        text-color = text;
      };

      "button selected" = {
        background-color = active;
        text-color = text;
      };
      "button active" = {
        background-color = active;
        text-color = text;
      };

      # Elements
      element = {
        enabled = true;
        spacing = 0;
        padding = 8;
        cursor = mkLiteral "pointer";
        background-color = mkLiteral "transparent";
        text-color = secondary-text;
      };

      "element selected" = {
        background-color = active;
        text-color = text;
        border-radius = THEME.border-radius;
        text-transform = mkLiteral "bold";
      };

      element-icon = {
        size = 48;
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        border-radius = THEME.border-radius;
      };

      element-text = {
        vertical-align = mkLiteral "0.5";
        highlight = mkLiteral "underline";
        text-transform = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        padding = mkLiteral "0 0 0 32px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      # Error message
      error-message = {
        text-color = text;
        background-color = background;
        text-transform = mkLiteral "capitalize";
        children = ["textbox"];
      };

      textbox = {
        text-color = mkLiteral "inherit";
        background-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
      };
    };
  };
}

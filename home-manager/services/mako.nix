{THEMES, ...}: {
  services.mako = {
    enable = false;
    settings = {
      max-visible = 3;
      default-timeout = 5000;

      outer-margin = "12,12,0";
      anchor = "top-right";
      layer = "overlay";

      background-color = THEMES.hexWithOpacity THEMES.bg THEMES.bg-opacity;
      border-color = THEMES.hexWithOpacity THEMES.gray THEMES.border-opacity;
      border-size = 1;
      margin = "4,0,0,0";
      padding = 8;
      width = 500;
      height = 160;

      icons = true;
      max-icon-size = 64;
      icon-border-radius = 12;

      text-color = THEMES.fg;
      border-radius = 12;
      font = "${THEMES.regular-font} 14";
      markup = true;
      actions = true;
      on-button-left = "invoke-default-action";
      on-button-right = "dismiss";
      on-touch = "invoke-default-action";

      format = "<span font='10' color='${THEMES.light-gray}'>%a</span>\n<b>%s</b>\n<span font='2'> </span>\n<span font='12' color='${THEMES.light-gray}'>%b</span>";

      "urgency=low" = {
        border-color = THEMES.blue;
      };

      "urgency=high" = {
        border-color = THEMES.red;
        default-timeout = 0;
      };
    };
  };
}

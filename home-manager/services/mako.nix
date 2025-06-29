{THEME, ...}: {
  services.mako = {
    enable = true;
    settings = {
      max-visible = 3;
      default-timeout = 5000;

      outer-margin = "12,12,0";
      anchor = "top-right";
      layer = "overlay";

      background-color = THEME.hexWithOpacity THEME.bg THEME.bg-opacity;
      border-color = THEME.hexWithOpacity THEME.gray THEME.border-opacity;
      border-size = 1;
      margin = "4,0,0,0";
      padding = 8;
      width = 500;
      height = 160;

      icons = true;
      max-icon-size = 64;
      icon-border-radius = 12;

      text-color = THEME.fg;
      border-radius = THEME.border-radius;
      font = "${THEME.regular-font} 14";
      markup = true;
      actions = true;
      on-button-left = "invoke-default-action";
      on-button-right = "dismiss";
      on-touch = "invoke-default-action";

      format = "<span font='10' color='${THEME.light-gray}'>%a</span>\\n<b>%s</b>\\n<span font='2'> </span>\\n<span font='12' color='${THEME.light-gray}'>%b</span>";

      "urgency=low" = {
        border-color = THEME.blue;
      };

      "urgency=high" = {
        border-color = THEME.red;
        default-timeout = 0;
      };
    };
  };
}

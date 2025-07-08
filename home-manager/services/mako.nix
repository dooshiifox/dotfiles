{ config, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      max-visible = 3;
      default-timeout = 5000;

      outer-margin = "12,12,0";
      anchor = "top-right";
      layer = "overlay";

      background-color = config.lib.theme.colors.bg-opacity;
      border-color = config.lib.theme.colors.border-active-opacity;
      border-size = 1;
      margin = "4,0,0,0";
      padding = 8;
      width = 500;
      height = 160;

      icons = true;
      max-icon-size = 64;
      icon-border-radius = config.lib.theme.border-radius;

      text-color = config.lib.theme.colors.fg;
      border-radius = config.lib.theme.border-radius;
      font = "${config.lib.theme.fonts.regular.name} 14";
      markup = true;
      actions = true;
      on-button-left = "invoke-default-action";
      on-button-right = "dismiss";
      on-touch = "invoke-default-action";

      format = "<span font='10' color='${config.lib.theme.colors.fg-secondary}'>%a</span>\\n<b>%s</b>\\n<span font='2'> </span>\\n<span font='12' color='${config.lib.theme.colors.fg-secondary}'>%b</span>";

      "urgency=low" = {
        border-color = config.lib.theme.colors.dark-blue;
      };

      "urgency=high" = {
        border-color = config.lib.theme.colors.dark-red;
        default-timeout = 0;
      };
    };
  };
}

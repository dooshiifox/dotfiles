_: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "hyprctl dispatch dpms off"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        # 10 mins brightness decrease
        {
          timeout = 600;
          on-timeout = "hyprctl hyprsunset gamma 80";
          on-resume = "hyprctl hyprsunset gamma 100";
        }

        # 5 mins lock screen
        #{
        #  timeout = 300;
        #  on-timeout = "loginctl lock-session";
        #}

        # 5.5 mins screen off
        #{
        #  timeout = 330;
        #  on-timeout = "hyprctl dispatch dpms off";
        #  on-resume = "hyprctl dispatch dpms on && hyprctl hyprsunset gamma 100";
        #}

        # 25 mins brightness decrease further
        {
          timeout = 1500;
          on-timeout = "hyprctl hyprsunset gamma 50";
          on-resume = "hyprctl hyprsunset gamma 100";
        }

        # 30 mins suspend
        #{
        #  timeout = 1800;
        #  on-timeout = "systemctl suspend";
        #}
      ];
    };
  };
}

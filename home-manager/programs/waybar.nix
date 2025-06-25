# https://github.com/nix-community/home-manager/blob/master/modules/programs/waybar.nix
{THEME, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # height = 28; # Can be removed for auto-height
        margin-left = 8;
        margin-right = 8;
        margin-top = 4;
        margin-bottom = 0;
        spacing = 0;
        reload_style_on_change = true;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "mpd"
        ];
        modules-right = [
          # "idle_inhibitor";
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
          warp-on-scroll = false;
          format = "{name}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };

        "hyprland/window" = {
          format = "{}";
          tooltip = false;
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = "<span color='#ffb2a5'></span>   <b>$1</b>";
            "Mozilla Firefox" = "<span color='#ffb2a5'></span>   <b>Firefox</b>";
            "(.*) - VSCodium" = "<span color='#a5cfff'>󰨞</span>   <b>$1</b>";
            ".*?Discord.{3}(.*)" = "<span color='#a5b2ff'></span>   <b>$1</b>";
            "Kitty - (.*)" = "<span color='#ffa5e1'>󰄛</span>   <b>$1</b>";
            "(kitty|fish)" = "<span color='#ffa5e1'>󰄛</span>   <b>~</b>";
            "OBS.*? - (.*)" = "   <b>$1</b>";
            "(.*?)( - obsidian)? - Obsidian.*" = "<span color='#cca5ff'></span>   <b>$1</b>";
            "(.*) - Mozilla Thunderbird" = "<span color='#a5cfff'></span>   <b>$1</b>";
            ".*rofi.*" = "   <b>Rofi</b>";
            "(.*)" = "<b><i>$1</i></b>";
          };
          separate-outputs = true;
        };

        mpd = {
          format = "{stateIcon}    <b>{title}</b>   <span size='x-small'>{artist}</span>";
          tooltip-format = "{title}\n{album}\n{artist}";
          interval = 0.1;
          max-length = 90;
          state-icons = {
            playing = "";
            paused = "<small></small>";
            stopped = "<small></small>";
          };
          on-click = "mpc toggle";
        };

        # "idle_inhibitor" = {
        #     "format" = "{icon}";
        #     "format-icons" = {
        #         "activated" = "";
        #         "deactivated" = "";
        #     };
        # };
        pulseaudio = {
          format = "{icon}";
          tooltip-format = "{desc} - {volume}%";
          format-bluetooth = "{icon} <span size='xx-small'></span>";
          format-bluetooth-muted = " {icon} <span size='xx-small'></span>";
          format-muted = "";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = ["<span size='xx-small'> </span>" "<span size='xx-small'> </span>" "<span size='xx-small'> </span>"];
            default = ["" "" ""];
          };
          on-click = "pactl set-sink-mute $(pactl get-default-sink) toggle";
        };
        network = {
          interval = 1;
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-disconnected = "󰤮";
          format-ethernet = "";
          format-linked = "";
          tooltip-format = "{essid} @ {frequency}GHz @ {signalStrength}%\n{ipaddr}\n{bandwidthUpBytes} Upload / {bandwidthDownBytes} Download";
        };
        cpu = {
          interval = 1;
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            "<span color='${THEME.yellow}'></span>"
            "<span color='${THEME.dark-yellow}'></span>"
            "<span color='${THEME.red}'></span>"
          ];
          tooltip = true;
        };
        memory = {
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            "<span color='${THEME.yellow}'></span>"
            "<span color='${THEME.dark-yellow}'></span>"
            "<span color='${THEME.red}'></span>"
          ];
          tooltip-format = "{percentage}% - {used:0.1f}GiB / {total:0.1f}GiB";
          tooltip = true;
        };
        temperature = {
          interval = 10;
          critical-threshold = 105;
          format = "{icon}";
          format-critical = "<span class='${THEME.dark-red}'> {temperatureC}°C</span>";
          format-icons = [
            "" # 0
            "" # 5
            "" # 10
            "" # 15
            "" # 20
            "" # 25
            "" # 30
            "" # 35
            "" # 40
            "" # 45
            "" # 50
            "" # 55
            "" # 60
            "" # 65
            "" # 70
            "" # 75
            "" # 80
            "" # 85
            "<span color='${THEME.yellow}'></span>" # 90
            "<span color='${THEME.dark-yellow}'></span>" # 95
            "<span color='${THEME.red}'></span>" # 100
          ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          interval = 5;
          format = "{icon} <small>{capacity}%</small>";
          format-full = "{icon}";
          format-charging = "";
          format-plugged = "";
          format-alt = "{icon} <small>{capacity}% ({time})</small>";
          format-icons = ["" "" "" "" ""];
        };
        clock = {
          format = "<b>{:%H:%M</b>  <small>%a %e %B</small>} ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };

    style = "
* {
    font-family: ${THEME.regular-font}, ${THEME.nerd-font}, FontAwesome, Roboto, Helvetica, Arial,
        sans-serif;
    font-size: 15px;
    transition: background-color 0.2s ease-out;
}

window#waybar {
    color: ${THEME.hexToRgbaString THEME.light-gray 1};
    font-family: ${THEME.regular-font}, ${THEME.nerd-font}, feather;
    transition: background-color 0.5s;
    background: ${THEME.hexToRgbaString THEME.bg THEME.bg-opacity};
    border-radius: 12px;
    border: 1px solid ${THEME.hexToRgbaString THEME.gray THEME.border-opacity};
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#language,
#mpd {
    padding: 0 10px;
    border-radius: 12px;
}
#mpd {
    padding: 0 16px 0 12px;
}

#clock:hover,
#battery:hover,
#cpu:hover,
#memory:hover,
#disk:hover,
#temperature:hover,
#backlight:hover,
#network:hover,
#pulseaudio:hover,
#wireplumber:hover,
#custom-media:hover,
#tray:hover,
#mode:hover,
#idle_inhibitor:hover,
#scratchpad:hover,
#power-profiles-daemon:hover,
#language:hover,
#mpd:hover {
    background: ${THEME.hexToRgbaString THEME.gray 0.5};
}

#workspaces button {
    background: transparent;
    font-family: ${THEME.regular-font}, ${THEME.nerd-font}, feather;
    color: ${THEME.light-gray};
    border: none;
    border-radius: 8px;
    margin: 0 0;
    padding: 0px 4px;
}
#workspaces {
    padding: 4px;
}

#workspaces button.active {
    background: ${THEME.hexToRgbaString THEME.gray 0.5};
}

#workspaces button:hover {
    background: ${THEME.gray};
    color: ${THEME.fg};
    box-shadow: none;
}

#window {
    padding-left: 20px;
}

";
  };
}

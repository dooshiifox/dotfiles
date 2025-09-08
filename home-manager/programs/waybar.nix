# https://github.com/nix-community/home-manager/blob/master/modules/programs/waybar.nix
{ config, ... }:
{
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
          format = "{class} ///// {title}";
          tooltip = false;
          max-length = 50;
          rewrite = with config.lib.theme.colors; {
            "firefox-devedition ///// (.*) — (Mozilla Firefox|Firefox Developer Edition)" =
              "<span color='${pink}'></span>   <b>$1</b>";
            "firefox-devedition ///// (Mozilla Firefox|Firefox Developer Edition)" =
              "<span color='${pink}'></span>   <b>Firefox</b>";
            "codium ///// (.*) - VSCodium" = "<span color='${light-blue}'>󰨞</span>   <b>$1</b>";
            "vesktop ///// (.*?Discord.{3})?(.*)" = "<span color='${dark-blue}>'></span>   <b>$2</b>";
            "Kitty ///// (nvim|e) (.*)" = "<span color='${lime}'></span>   <b>$2</b>";
            "Kitty ///// (?!nvim |e )(.*)" = "<span color='${light-magenta}'>󰄛</span>   <b>$1</b>";
            "Kitty ///// (kitty|fish)" = "<span color='${light-magenta}'>󰄛</span>   <b>~</b>";
            "com.obsproject.Studio ///// OBS.*? - (.*)" = "   <b>$1</b>";
            "obsidian ///// (.*?)( - obsidian)? - Obsidian.*" = "<span color='${magenta}'></span>   <b>$1</b>";
            "thunderbird ///// (.*) - Mozilla Thunderbird" = "<span color='${dark-blue}'></span>   <b>$1</b>";
            "Rofi ///// rofi - .*" = "   <b>Rofi</b>";
            "nemo ///// (.*)" = "<span color='${orange}'></span>   <b>$1</b>";
            "io.bassi.Amberol ///// (.*)" = "<span color='${light-blue}'></span>   <b>$1</b>";
            "ymuse ///// ymuse" = "<span color='${dark-blue}'>󰎆</span>   <b>ymuse</b>";
            "org.prismlauncher.PrismLauncher ///// (.*)" = "<span color='${lime}'></span>   <b>$1</b>";
            "Minecraft(.*)///// (.*)" = "<span color='${lime}'>󰍳</span>   <b>$2</b>";
            "keymapp ///// (.*)" = "<span color='${lime}'>󰌌</span>   <b>$1</b>";
            "jetbrains-idea-ce ///// (.*)" = "<span color='${orange}'>󰬷</span>   <b>$1</b>";
            "steam ///// (.*)" = "   <b>$1</b>";
            "org.telegram.desktop ///// (.*)" = "<span color='${light-blue}'></span>  <b>$1</b>";
            "Postman ///// (.*)" = "<span color='${orange}'></span>  <b>$1</b>";
            "\\s*/////\\s*" = "<span color='${dark-blue}'></span>   <span color='${light-blue}'></span>";
            # TODO: home-manager generates the config in alphabetical order, meaning this
            # comes first i think. Find a way to make this come last.
            # "(.*)/////(.*)" = "$2  <span size='10px'>$1</span>";
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
            headphone = [
              "<span size='xx-small'> </span>"
              "<span size='xx-small'> </span>"
              "<span size='xx-small'> </span>"
            ];
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pactl set-sink-mute $(pactl get-default-sink) toggle";
        };
        network = {
          interval = 1;
          format-wifi = "{icon}";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-disconnected = "󰤮";
          format-ethernet = "";
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
            "<span color='${config.lib.theme.colors.yellow}'></span>"
            "<span color='${config.lib.theme.colors.orange}'></span>"
            "<span color='${config.lib.theme.colors.pink}'></span>"
          ];
          tooltip = true;
        };
        memory = {
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            "<span color='${config.lib.theme.colors.yellow}'></span>"
            "<span color='${config.lib.theme.colors.orange}'></span>"
            "<span color='${config.lib.theme.colors.pink}'></span>"
          ];
          tooltip-format = "{percentage}% - {used:0.1f}GiB / {total:0.1f}GiB";
          tooltip = true;
        };
        temperature = {
          interval = 10;
          critical-threshold = 105;
          format = "{icon}";
          format-critical = "<span class='${config.lib.theme.colors.red}'> {temperatureC}°C</span>";
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
            "<span color='${config.lib.theme.colors.yellow}'></span>" # 90
            "<span color='${config.lib.theme.colors.orange}'></span>" # 95
            "<span color='${config.lib.theme.colors.pink}'></span>" # 100
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
          format-charging = "";
          format-plugged = "";
          format-alt = "{icon} <small>{capacity}% ({time})</small>";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
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
    font-family: ${config.lib.theme.fonts.regular.name}, ${config.lib.theme.fonts.symbols.name}, FontAwesome, Roboto, Helvetica, Arial,
        sans-serif;
    font-size: 15px;
    transition: background-color 0.2s ease-out;
}

window#waybar {
    color: ${config.lib.theme.colors.fg-secondary};
    font-family: ${config.lib.theme.fonts.regular.name}, ${config.lib.theme.fonts.symbols.name}, feather;
    transition: background-color 0.5s;
    background: ${config.lib.theme.hexaToRgbaString config.lib.theme.colors.bg-opacity};
    border-radius: 12px;
    border: 1px solid ${config.lib.theme.hexaToRgbaString config.lib.theme.colors.border-opacity};
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
    background: ${config.lib.theme.hexToRgbaString config.lib.theme.colors.dark-grey 0.5};
}

#workspaces button {
    background: transparent;
    font-family: ${config.lib.theme.fonts.regular.name}, ${config.lib.theme.fonts.symbols.name}, feather;
    color: ${config.lib.theme.colors.fg-secondary};
    border: none;
    border-radius: 8px;
    margin: 0 0;
    padding: 0px 4px;
}
#workspaces {
    padding: 4px;
}

#workspaces button.active {
    background: ${config.lib.theme.hexToRgbaString config.lib.theme.colors.dark-grey 0.5};
}

#workspaces button:hover {
    background: ${config.lib.theme.colors.dark-grey};
    color: ${config.lib.theme.colors.fg};
    box-shadow: none;
}

#window {
    padding-left: 20px;
}

";
  };
}

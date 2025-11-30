# https://github.com/nix-community/home-manager/blob/master/modules/programs/waybar.nix
{ config, lib, ... }:
let
  window_icon =
    color: icon: title:
    "<span color='${color}'>${icon}</span>   <b>${title}</b>";
  window_icons_map = lib.mapAttrs' (
    name: val:
    let
      name_with_asterisk = if lib.strings.hasInfix "/////" name then name else name + " ///// (.*)";
      name_prioritised =
        if lib.strings.hasPrefix "(?!" name_with_asterisk then
          name_with_asterisk
        else
          (priority 9) + name_with_asterisk;
      value_string = if builtins.isFunction val then val "$1" else val;
    in
    lib.nameValuePair name_prioritised value_string
  );
  /**
    Lower number = more priority
    Technically this is lower ascii-codepoint but whatever
  */
  priority = index: "(?!${builtins.toString index})";
  window_icons =
    with config.lib.theme.colors;
    # https://www.nerdfonts.com/cheat-sheet
    # sleep 1 && hyprctl activewindow -j | jq '.initialClass + " ///// " + .initialTitle'
    window_icons_map {
      "firefox-devedition ///// (.*) — (Mozilla Firefox|Firefox Developer Edition)" =
        window_icon pink "";
      "firefox-devedition ///// (Mozilla Firefox|Firefox Developer Edition)" =
        window_icon pink ""
          "Firefox";
      "codium ///// (.*) - VSCodium" = window_icon light-blue "󰨞";
      "vesktop ///// (?:.*?Discord.{3})?(.*)" = window_icon dark-blue "";
      "${priority 1}Kitty ///// (?:nvim|e|ni) (.*)" = window_icon lime "";
      "${priority 1}Kitty ///// rmpc.*" = window_icon orange "󰎆" "rmpc";
      "${priority 1}Kitty ///// Yazi: (.*)" = window_icon yellow "󰇥";
      "${priority 1}Kitty ///// (kitty|fish)" = window_icon light-magenta "󰄛" "~";
      "Kitty ///// (.*)" = window_icon light-magenta "󰄛";
      "com.obsproject.Studio ///// OBS.*? - (.*)" = window_icon fg-secondary "";
      "obsidian ///// (.*?)( - obsidian)? - Obsidian.*" = window_icon magenta "";
      "thunderbird ///// (.*) - Mozilla Thunderbird" = window_icon dark-blue "";
      "Rofi ///// rofi - .*" = window_icon fg-secondary "" "Rofi";
      "nemo" = window_icon orange "";
      "io.bassi.Amberol" = window_icon light-blue "";
      "ymuse ///// ymuse" = window_icon dark-blue "󰎆" "ymuse";
      "org.prismlauncher.PrismLauncher" = window_icon lime "";
      "Minecraft(?:.*)" = window_icon lime "󰍳";
      "keymapp" = window_icon lime "󰌌";
      "jetbrains-idea-ce" = window_icon orange "󰬷";
      "steam" = window_icon fg-secondary "";
      "org.telegram.desktop" = window_icon light-blue "";
      "Postman" = window_icon orange "";
      "org.qbittorrent.qBittorrent" = window_icon light-blue "";
      "Electron ///// Antares SQL" = window_icon orange "󰆼" "Antares SQL";
      "krita ///// Krita" = window_icon magenta "" "Krita";
      "soffice" = window_icon fg-secondary "󰏆";
      "libreoffice-calc ///// (.*) — LibreOffice Calc" = window_icon lime "󰧷";
      "gcr-prompter ///// Unlock Login Keyring" = window_icon fg-secondary "" "Unlock Login Keyring";
      "chromium-browser ///// (.*) - Chromium" = window_icon dark-blue "";
      "\\s*/////\\s*" = "<span color='${dark-blue}'></span>   <span color='${light-blue}'></span>";
      "${priority "~"}(.*) ///// (.*)" = "$2     <span size='small' color='${light-gray}'>$1</span>";
    };
in
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
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "idle_inhibitor"
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
          rewrite = window_icons;
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
          on-click = "mpc --host /tmp/mpd_socket toggle";
          server = "/tmp/mpd_socket";
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
          format-charging = " <small>{capacity}%</small>";
          format-plugged = " <small>{capacity}%</small>";
          format-alt = "{icon} <small>{capacity}% ({time})</small>";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰛨";
            deactivated = "󰒲";
          };
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

{
  pkgs,
  config,
  ...
}:
{
  gtk =
    let
      extra-config = {
        gtk-application-prefer-dark-theme = if config.lib.theme.colors.variant == "light" then 0 else 1;
      };
    in
    rec {
      enable = true;

      gtk4.extraCss = ''
        * {
          color: ${config.lib.theme.colors.fg};
        }

        .background,
        contents {
          background-color: ${config.lib.theme.colors.bg-opacity};
        }
        .box,
        popover {
          background-color: transparent;
        }
        highlight {
          background-color: ${config.lib.theme.colors.fg};
        }
      '';
      gtk3.extraCss = gtk4.extraCss;

      gtk3.extraConfig = extra-config;
      gtk4.extraConfig = extra-config;

      iconTheme = {
        package = pkgs.candy-icons;
        name = "candy-icons";
      };

      font = {
        inherit (config.lib.theme.fonts.regular) package name;
        size = 11;
      };
    };
}

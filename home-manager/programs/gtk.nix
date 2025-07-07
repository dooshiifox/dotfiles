{
  pkgs,
  THEME,
  ...
}:
{
  gtk =
    let
      extra-config = {
        gtk-application-prefer-dark-theme = if THEME.scheme == "light" then 0 else 1;
      };
    in
    rec {
      enable = true;
      gtk4.extraCss = ''
        * {
          color: ${THEME.fg};
        }

        .background,
        contents {
          background-color: ${THEME.hexWithOpacity THEME.bg THEME.bg-opacity};
        }
        .box,
        popover {
          background-color: transparent;
        }
        highlight {
          background-color: ${THEME.fg};
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
        name = THEME.regular-font;
        size = 11;
      };
    };
}

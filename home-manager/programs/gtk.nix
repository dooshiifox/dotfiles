{
  pkgs,
  THEME,
  ...
}: {
  gtk = let
    prefer-dark-opts =
      if THEME.scheme == "light"
      then "gtk-application-prefer-dark-theme=0"
      else "gtk-application-prefer-dark-theme=1";
  in {
    enable = true;
    gtk4.extraCss = ''
      .background {
        background-color: ${THEME.hexWithOpacity THEME.bg THEME.bg-opacity};
      }
    '';
    gtk3.extraConfig = {
      Settings = ''
        ${prefer-dark-opts}
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        ${prefer-dark-opts}
      '';
    };

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

{pkgs, ...}: {
  gtk = {
    enable = true;
    # theme = {
    #   package = pkgs.flat-remix-gtk;
    #   name = "Flat-Remix-GTK-Grey-Darkest";
    # };

    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };

    font = {
      name = "Cantarell";
      size = 11;
    };
  };
}

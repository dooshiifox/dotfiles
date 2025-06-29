# Firefox web browser
# https://github.com/nix-community/home-manager/blob/master/modules/programs/firefox.nix
{pkgs, ...}: let
  mimeTypes = [
    "application/json"
    "application/pdf"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
    "application/xhtml+xml"
    "text/html"
    "text/xml"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/unknown"
    "x-scheme-handler/https"
  ];
in {
  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["firefox.desktop"];
    })
    mimeTypes);

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };
}

let
  mpv = "mpv.desktop";
  yazi = "yazi.desktop";
  nvim = "nvim.desktop";
  browser = "librewolf.desktop";
in
{
  # GET A FILETYPE
  # xdg-mime query filetype <file>
  #
  # LIST ALL DESKTOP FILES
  # nu -c "echo \$env.XDG_DATA_DIRS | split row ':' | where { (\$in | path type) == 'dir' } | each {cd \$in | glob **/*.desktop -l} | flatten | sort"

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/quicktime" = mpv;
      "video/mp4" = mpv;

      "text/markdown" = nvim;

      "image/png" = browser;
      "image/jpeg" = browser;
      "image/gif" = browser;

      "inode/directory" = yazi;

      "application/json" = browser;
      "application/pdf" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "text/xml" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/unknown" = browser;
      "x-scheme-handler/https" = browser;
    };
  };
}

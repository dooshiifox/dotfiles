# Music Player Daemon
# https://github.com/nix-community/home-manager/blob/master/modules/services/mpd.nix
{
  services.mpd = {
    enable = true;

    dataDir = ./mpd;
  };
}

# Music Player Daemon
# https://github.com/nix-community/home-manager/blob/master/modules/services/mpd.nix
{
  services.mpd = {
    enable = true;

    extraConfig = ''
      playlist_directory  "~/mpd/playlists"
      sticker_file        "~/mpd/sticker.sql";
      db_file             "~/mpd/database";
      state_file          "~/mpd/state";
    '';
  };
}

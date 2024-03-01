{
  pkgs,
  config,
  ...
}: let
  mpdPkg = pkgs.mpd;

  mpdmprisPkg = pkgs.mpd-mpris;
in {
  systemd.user.services.mpd = {
    enable = true;
    description = "Music Player Daemon";

    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];

    environment = "PATH=${config.home.profileDirectory}/bin";

    script = "${mpdPkg}/bin/mpd --no-daemon";
    serviceConfig = {
      Type = "notify";
    };
  };

  systemd.user.services.mpd-mpris = {
    enable = true;
    description = "mpd-mpris: An implementation of the MPRIS protocol for MPD";

    after = ["mpd.service"];
    requires = ["mpd.service"];
    wantedBy = ["default.target"];

    script = "${mpdmprisPkg}/bin/mpd-mpris -no-instance";
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}

{
  pkgs,
  config,
  ...
}: let
  mpdPkg = pkgs.mpd;

  mpdmprisPkg = pkgs.mpd-mpris;
in {
  # DONT FALL FOR THEIR LIES!!
  # This follows the HOME MANAGER way of doing things, not the NIXOS way
  # as described in the manual https://nixos.org/manual/nixos/stable/options.html#opt-systemd.services._name_
  systemd.user.services.mpd = {
    Unit = {
      Description = "Music Player Daemon";
      After = ["network.target" "sound.target"];
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      ExecStart = "${mpdPkg}/bin/mpd --no-daemon";
      Environment = "PATH=${config.home.profileDirectory}/bin";
      Type = "notify";
    };
  };

  systemd.user.services.mpd-mpris = {
    Unit = {
      Description = "mpd-mpris: An implementation of the MPRIS protocol for MPD";
      After = ["network.target" "sound.target"];
      Requires = ["mpd.service"];
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "5s";
      ExecStart = "${mpdmprisPkg}/bin/mpd-mpris -no-instance";
    };
  };
}

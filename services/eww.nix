{
  pkgs,
  config,
  ...
}: let
  pkg = pkgs.eww;
in {
  systemd.user.services.eww = {
    Unit = {
      Description = "EWW Daemon";
      # Kinda wait a bit maybe??
      After = ["network.target" "sound.target"];
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      # Auto-starts the daemon
      ExecStart = "${pkg}/bin/eww open bar";
      ExecStop = "${pkg}/bin/eww kill";
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}

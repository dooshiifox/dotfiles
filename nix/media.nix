{pkgs, ...}: {
  users.users.dooshii.extraGroups = ["multimedia"];

  users.groups.multimedia = {};
  systemd.tmpfiles.rules = [
    "d /data/media 0770 - multimedia - -"
  ];

  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
      group = "multimedia";
    };
    sonarr = {
      enable = true;
      openFirewall = true;
      group = "multimedia";
    };
    deluge = {
      enable = true;
      group = "multimedia";
      openFirewall = true;
      web = {
        enable = true;
        openFirewall = true;
      };
      # dataDir = "/data/media/torrent";
      declarative = true;
      # config = {
      #   enabled_plugins = ["Label"];
      #   outgoing_interface = "wg1";
      # };
      authFile = pkgs.writeText "deluge-auth" ''
        localclient:a7bef72a890:10
        andrew:password:10
        user3:anotherpass:5
      '';
    };
  };
}

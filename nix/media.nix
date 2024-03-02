{pkgs, ...}: {
  users.users.dooshii.extraGroups = ["multimedia"];

  users.groups.multimedia = {};
  systemd.tmpfiles.rules = [
    "d /data/media 0770 - multimedia - -"
  ];

  services = {
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
      web.enable = true;
      dataDir = "/data/media/torrent";
      declarative = true;
      config = {
        enabled_plugins = ["Label"];
        outgoing_interface = "wg1";
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient::10
        '';
      };
    };
  };
}

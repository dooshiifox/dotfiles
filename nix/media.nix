{pkgs, ...}: {
  users.users.dooshii.extraGroups = ["multimedia"];

  users.groups.multimedia = {};
  systemd.tmpfiles.rules = [
    "d /data/media 0770 - multimedia - -"
  ];

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
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
  };
}

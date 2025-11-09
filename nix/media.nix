{ lib, ... }:
{
  users.users.dooshii.extraGroups = [ "multimedia" ];

  users.groups.multimedia = { };
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
    readarr = {
      enable = true;
      openFirewall = true;
      group = "multimedia";
    };
  };
  systemd.services = {
    jellyfin.wantedBy = lib.mkForce [ "default.target" ];
    jellyfin.after = lib.mkForce [ "default.target" ];
    prowlarr.wantedBy = lib.mkForce [ "default.target" ];
    prowlarr.after = lib.mkForce [ "default.target" ];
    radarr.wantedBy = lib.mkForce [ "default.target" ];
    radarr.after = lib.mkForce [ "default.target" ];
    sonarr.wantedBy = lib.mkForce [ "default.target" ];
    sonarr.after = lib.mkForce [ "default.target" ];
    readarr.wantedBy = lib.mkForce [ "default.target" ];
    readarr.after = lib.mkForce [ "default.target" ];
  };
}

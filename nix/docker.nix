{ ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.users.dooshii.extraGroups = [ "docker" ];
}

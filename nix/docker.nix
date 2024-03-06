{...}: {
  virtualisation.docker.enable = true;
  users.users.dooshii.extraGroups = ["docker"];
}

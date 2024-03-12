{...}: {
  programs.adb.enable = true;
  users.users.dooshii.extraGroups = ["adbusers"];
}

{
  programs.adb.enable = true;
  users.users.dooshii.extraGroups = ["adbusers"];
  nixpkgs.config.android_sdk.accept_license = true;
}

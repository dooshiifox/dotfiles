# https://github.com/Ap6661/septabee-flake/blob/main/flake.nix
{ pkgs, lib, ... }:
let
  septabee-pkg = import ./package.nix { inherit pkgs lib; };
in
{
  # Add the initialization tool to system packages
  environment.systemPackages = [
    septabee-pkg
  ];

  security.wrappers.septabee = {
    owner = "root";
    group = "root";
    permissions = "u-rwx,g=rx,o=rx";
    capabilities = "cap_sys_nice+ep";
    source = "${septabee-pkg}/bin/septabee";
  };

  security.wrappers.septabee-sounds = {
    owner = "root";
    group = "root";
    permissions = "u-rwx,g=rx,o=rx";
    capabilities = "cap_sys_nice+ep";
    source = "${septabee-pkg}/bin/septabee-sounds";
  };
}

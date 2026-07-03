args@{ pkgs, ... }:
let
  procon2-init = import ./package.nix args;
in
{
  # Add the initialization tool to system packages
  environment.systemPackages = [
    procon2-init
    (pkgs.writeScriptBin "procon2-init" "${procon2-init}/bin/procon2-init")
  ];

  # Udev rules for Nintendo Pro Controller 2
  services.udev.extraRules = ''
    # Nintendo Pro Controller 2 (USB mode) - idVendor: 057e, idProduct: 2069
    SUBSYSTEM=="usb", ATTR{idVendor}=="057e", ATTR{idProduct}=="2069", MODE="0666", TAG+="uaccess"

    # Auto-initialize when plugged in
    SUBSYSTEM=="usb", ATTR{idVendor}=="057e", ATTR{idProduct}=="2069", ACTION=="add", RUN+="${procon2-init}/bin/procon2-init"
    SUBSYSTEM=="usb", ATTR{idVendor}=="057e", ATTR{idProduct}=="2069", ACTION=="add", RUN+="${pkgs.libnotify}/bin/notify-send 'ProCon 2 Connected'"
  '';

  # Ensure users are in the input group for gamepad access
  users.groups.input = {
    members = [ "dooshii" ];
  };
}

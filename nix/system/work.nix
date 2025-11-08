{ pkgs, ... }:
# https://github.com/NixOS/nixos-hardware/blob/master/asus/battery.nix
let
  p = pkgs.writeScriptBin "charge-upto" ''
    #!${pkgs.bash}/bin/bash
    echo ''${1:-100} > /sys/class/power_supply/BAT?/charge_control_end_threshold
  '';
  # Charging all the way can be bad for battery life
  chargeUpto = 90;
in
{
  # https://github.com/NixOS/nixos-hardware/blob/master/asus/zenbook/ux371/default.nix
  services.thermald.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  # boot.kernelParams = [ "i915.enable_guc=3" ];
  services.fstrim.enable = true;

  boot.initrd.kernelModules = [ "xe" ];
  hardware.graphics.extraPackages = with pkgs; [
    intel-vaapi-driver
    intel-ocl
    intel-media-driver
    intel-compute-runtime
    vpl-gpu-rt
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.intel-vaapi-driver
    driversi686Linux.intel-media-driver
  ];

  environment.systemPackages = [ p ];
  systemd.services.battery-charge-threshold = {
    wantedBy = [
      "local-fs.target"
      "suspend.target"
      "suspend-then-hibernate.target"
      "hibernate.target"
    ];
    after = [
      "local-fs.target"
      "suspend.target"
      "suspend-then-hibernate.target"
      "hibernate.target"
    ];
    description = "Set the battery charge threshold to ${toString chargeUpto}%";
    startLimitBurst = 5;
    startLimitIntervalSec = 1;
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
      ExecStart = "${pkgs.runtimeShell} -c 'echo ${toString chargeUpto} > /sys/class/power_supply/BAT?/charge_control_end_threshold'";
    };
  };
}

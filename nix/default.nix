# Defines NixOS settings.
# This file in particular handles imports, the user, and Nix packages.
{
  inputs,
  pkgs,
  profile,
  ...
}:
{
  imports = [
    ./copyparty.nix
    ./android.nix
    ./docker.nix
    ./games.nix
    ./nix-ld.nix
    ./media.nix
    ./system.nix
    ./hypr.nix
    # Include the results of the hardware scan.
    # https://nixos.wiki/wiki/Nix_Language:_Tips_%26_Tricks#Coercing_a_relative_path_with_interpolated_variables_to_an_absolute_path_.28for_imports.29
    (../. + "/hardware/${profile}.nix")
    (./. + "/system/${profile}.nix")
  ];

  users.users.dooshii = {
    isNormalUser = true;
    description = "kit fox";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    # User packages should be defined in home-manager
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "freeimage-unstable-2021-11-01"
    "dotnet-sdk-6.0.428"
    "dotnet-runtime-6.0.36"
    "aspnetcore-runtime-6.0.36"
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.firefox-addons.overlays.default
    inputs.copyparty.overlays.default
    inputs.neovim-nightly-overlay.overlays.default

    # https://lix.systems/add-to-config/
    (final: prev: {
      inherit (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];
  # https://lix.systems/add-to-config/
  nix.package = pkgs.lixPackageSets.stable.lix;

  environment.systemPackages = with pkgs; [
    vim
    wget
    lshw
    libnotify
    pkgs.dconf
    # inputs.agenix.packages."${system}".default

    # Hardware
    libratbag # Gaming mouse configuration
    g810-led # Logitech keyboard configuration
    xorg.xbacklight # Backlight control
    brightnessctl # Also backlight control
    acpi # Battery info

    # Encrypted drive
    cryptsetup
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

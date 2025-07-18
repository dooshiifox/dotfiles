# Defines NixOS settings.
# This file in particular handles imports, the user, and Nix packages.
{
  inputs,
  pkgs,
  lib,
  mode,
  ...
}:
{
  imports =
    [
      # Include the results of the hardware scan.
      ../hardware-configuration.nix
      ./android.nix
      ./docker.nix
      ./games.nix
      ./nix-ld.nix
      ./media.nix
      ./system.nix
    ]
    ++ lib.optionals (mode == "hypr") [ ./hypr.nix ]
    ++ lib.optionals (mode == "xmonad") [ ./xmonad.nix ]
    ++ lib.optionals (mode == "gnome-wayland") [ ./gnome-wayland.nix ]
    ++ lib.optionals (mode == "gnome") [ ./gnome.nix ];

  users.users.dooshii = {
    isNormalUser = true;
    description = "kit fox";
    extraGroups = [
      "networkmanager"
      "wheel"
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
    # (final: prev: {
    #   gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
    #     mutter = gnomePrev.mutter.overrideAttrs (old: {
    #       src = pkgs.fetchgit {
    #         url = "https://gitlab.gnome.org/vanvugt/mutter.git";
    #         # GNOME 45: triple-buffering-v4-45
    #         rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
    #         sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
    #       };
    #     });
    #   });
    # })
  ];

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
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

# https://github.com/TophC7/play.nix
{ pkgs, ... }: {
  # Process scheduler optimization
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };

  # Misc optimisation
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        inhibit_screensaver = 1;
        renice = 15;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        amd_performance_level = "high";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;

    protontricks = {
      enable = true;
      package = pkgs.protontricks;
    };

    # package = pkgs.steam.override {
    #   extraPkgs = with pkgs; [
    #     libxcursor
    #     libxi
    #     libxinerama
    #     libxscrnsaver
    #     stdenv.cc.cc.lib
    #     gamemode
    #     gperftools
    #     keyutils
    #     libkrb5
    #     libpng
    #     libpulseaudio
    #     libvorbis
    #     mangohud
    #   ];
    # };
    # extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # Steam alternative frontend
  environment.systemPackages = [
    (pkgs.lutris.override {
      extraPkgs =
        pkgs: with pkgs; [
          winePackages.waylandFull
          winetricks
          vulkan-tools
          xterm
        ];
    })
  ];
}

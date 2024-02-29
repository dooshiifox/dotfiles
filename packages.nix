{ config, pkgs, inputs, ... }:

{
  users.users.dooshii = {
    isNormalUser = true;
    description = "kit fox";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      ################
      # System
      ################
      baobab                     # GNOME pie chart disk usage
      candy-icons                # Modern desktop icons
      gnomeExtensions.pop-shell  # Pop_OS! extension stuff (like grid view)
      megasync                   # Backups
      eww                        # Custom bar at top of screen
      
      # Web browser
      firefox                 # Web browser
      firefox-devedition-bin  # Web browser with added developer

      # Social
      telegram-desktop    # Telegram client
      vesktop             # Discord + Vencord
      whatsapp-for-linux  # Whatsapp client


      ################
      # Developing
      ################

      # Code editor, allows for Nix configurations
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
            bbenoist.nix
        ];
      })
      jetbrains.clion  # C/C++ code editor
      
      # Android / iOS
      android-studio  # Android development
      android-tools   # Android development: Part 2
      flutter         # Mobile development

      # Rust
      rustup       # Rust downloader and toolchain switcher
      cargo-audit  # Audit for security vulnerabilities

      # Javascript
      nodejs_21          # Javascript runtime; also provided npm
      nodePackages.pnpm  # Faster, less disk space npm

      # C/C++
      cmake  # Makefile support
      
      # Modding
      avalonia-ilspy  # Decompile C#

      # Git
      gitg  # Visual git viewer
      gh    # Github cli

      # Misc
      docker          # Containerization
      docker-compose  # Multiple containerization (docker-compose.yml support)


      ################
      # Terminal
      ################
      fish       # A better shell
      alacritty  # Terminal
      
      # Commands
      autojump  # `cd` but better
      bat       # `cat` but better
      ripgrep   # `grep` but better
      curl      # Transferring files
      neofetch  # Info about your system
      thefuck   # Corrects previous commands (i.e. you forgot `sudo`)
      tokei     # Count lines of code
      websocat  # Connect to websockets for development
      wmctrl    # Interact with X window managers


      ################
      # Media
      ################
      audacity  # Ugly audio editor
      kdenlive  # Ugly video editor
      krita     # Ugly image editor
      blender   # Not as ugly 3d modeling

      amberol     # Simple audio player
      blanket     # Pleasant sounds :3
      eartag      # Music metadata editor
      ffmpeg      # Command-line audio & video manipulation
      helvum      # Pipe audio and connect up inputs and outputs
      playerctl   # Interact with MPRIS-compatible programs from the command line
      mpc-cli     # Interact with MPD from the command line
      mpd         # Music player daemon
      mpd-mpris   # Implements MPRIS for MPD (MPRIS is a standardised protocal)
      ymuse       # MPD front-end
      obs-studio  # Record your desktop
      obsidian    # Markdown editor
      mpv         # Video & audio player
      vlc         # Video & audio player

      # Piracy
      qbittorrent  # Torrent downloader
      prowlarr     # Torrent index manager
      radarr       # Movie downloader


      ################
      # Games
      ################
      cubiomes-viewer  # Minecraft biome viewer
      prismlauncher    # Minecraft launcher
      steam            # Hub for games
      protontricks     # Steam's Proton helpers
      wine             # Window compatibility
      winetricks       # Wine helpers
      # TODO: fix
      # inputs.ow-mod-man.packages.x86_64-linux.owmods-gui
      # inputs.ow-mod-man.packages.x86_64-linux.owmods-cli
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    lshw
    libnotify
    git
  ];
}
{
  config,
  pkgs,
  inputs,
  PROJECT_ROOT,
  ...
}: {
  imports = [
    ./programs
    ./services
  ];

  home.username = "dooshii";
  home.homeDirectory = "/home/dooshii";
  xdg.userDirs.enable = true;

  home.sessionVariables = {
    BROWSER = "firefox-developer-edition";
    EDITOR = "code";
    NIX_CONFIG = PROJECT_ROOT;
  };

  home.packages = with pkgs; [
    ################
    # System
    ################
    baobab # GNOME pie chart disk usage
    candy-icons # Modern desktop icons
    megasync # Backups

    # FIXME: Prevent manual installs of these things.
    # Ensure you enable these in GNOME Extensions
    # With Pop Shell, disable mouse stacking
    # Can't customize keybinds with Pop Shell yet: https://github.com/NixOS/nixpkgs/issues/92265
    gnomeExtensions.pop-shell # Pop_OS! extension stuff (like grid view)
    # Not ported to GNOME 45 yet
    # gnomeExtensions.rounded-window-corners # Rounded window corners
    gnomeExtensions.pano # Global clipboard manager
    # Not ported to GNOME 45 yet
    # gnomeExtensions.hide-top-bar # Remove stinky top bar eww
    # Just doesn't work.
    # gnomeExtensions.gsconnect # KDE Connect for Gnome. Connect to your phone!
    gnomeExtensions.color-picker # Color picker
    gnomeExtensions.unite

    # Social
    telegram-desktop # Telegram client
    vesktop # Discord + Vencord
    whatsapp-for-linux # Whatsapp client

    # Hardware
    libratbag # Gaming mouse configuration
    g810-led # Logitech keyboard configuration

    ################
    # Developing
    ################

    jetbrains.clion # C/C++ code editor

    # Android / iOS
    android-studio # Android development
    android-tools # Android development: Part 2
    flutter # Mobile development

    # Rust
    rustup # Rust downloader and toolchain switcher
    cargo-audit # Audit for security vulnerabilities

    # Javascript
    nodejs_21 # Javascript runtime; also provides npm
    nodePackages.pnpm # Faster, less disk space npm

    # Python
    (python311.withPackages
      (ps:
        with ps; [
          pygobject3
          colorthief
          mpd2
        ]))

    # C/C++
    cmake # Makefile support

    # Nix
    alejandra # Format nix files, used by ni

    # Modding
    avalonia-ilspy # Decompile C#

    # Git
    gitg # Visual git viewer

    # Misc
    docker # Containerization
    docker-compose # Multiple containerization (docker-compose.yml support)

    ################
    # Terminal
    ################
    curl # Transferring files
    neofetch # Info about your system
    tokei # Count lines of code
    websocat # Connect to websockets for development
    wmctrl # Interact with X window managers
    bc # Arbitrary precision math
    jq # JSON processor

    ################
    # Media
    ################
    audacity # Ugly audio editor
    kdenlive # Ugly video editor
    krita # Ugly image editor
    blender # Not as ugly 3d modeling

    amberol # Simple audio player
    blanket # Pleasant sounds :3
    eartag # Music metadata editor
    ffmpeg # Command-line audio & video manipulation
    helvum # Pipe audio and connect up inputs and outputs
    playerctl # Interact with MPRIS-compatible programs from the command line
    obsidian # Markdown editor
    vlc # Video & audio player
    pamixer # Pulseaudio cli mixer

    # FIXME: `mpd` and `mpd-mpris` are also provided as home-manager services,
    # however I couldn't get them to read my stickers or persistently keep
    # their state.
    # However, I did create home-manager systemd services for them in
    # `./services/mpd.nix`
    mpd # Music Player Daemon
    mpd-mpris # Implement MPRIS protocal for MPD
    ymuse # MPD front-end
    mpc-cli # Interact with MPD from the command line

    # Piracy
    qbittorrent # Torrent downloader
    prowlarr # Torrent index manager
    radarr # Movie downloader

    ################
    # Games
    ################
    cubiomes-viewer # Minecraft biome viewer
    prismlauncher # Minecraft launcher
    steam # Hub for games
    protontricks # Steam's Proton helpers
    wine # Window compatibility
    winetricks # Wine helpers
    # TODO: fix
    inputs.ow-mod-man.packages.x86_64-linux.owmods-gui
    inputs.ow-mod-man.packages.x86_64-linux.owmods-cli
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

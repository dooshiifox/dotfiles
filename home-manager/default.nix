{
  config,
  pkgs,
  inputs,
  lib,
  PROJECT_ROOT,
  ...
}: {
  imports = [
    ./programs
    ./services
    ./secrets.nix
  ];

  home.username = "dooshii";
  home.homeDirectory = "/home/dooshii";
  xdg = {
    userDirs.enable = true;
    # Portals defined in `nix/wayland.nix`
  };

  home.sessionVariables = {
    BROWSER = "firefox-developer-edition";
    EDITOR = "code-insiders";
    NIX_SRC = PROJECT_ROOT;
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  home.packages = with pkgs; [
    ################
    # System
    ################
    baobab # GNOME pie chart disk usage
    megasync # Backups
    tor-browser-bundle-bin # i wanna buy my antiandrogens please

    # FIXME: Prevent manual installs of these things.
    # Ensure you enable these in GNOME Extensions
    # With Pop Shell, disable mouse stacking
    # Can't customize keybinds with Pop Shell yet: https://github.com/NixOS/nixpkgs/issues/92265
    gnomeExtensions.pop-shell # Pop_OS! extension stuff (like grid view)
    gnomeExtensions.pano # Global clipboard manager
    # Not ported to GNOME 45 yet
    # gnomeExtensions.rounded-window-corners # Rounded window corners
    # gnomeExtensions.hide-top-bar # Remove stinky top bar eww
    # Just doesn't work.
    # gnomeExtensions.gsconnect # KDE Connect for Gnome. Connect to your phone!
    gnomeExtensions.color-picker # Color picker
    gnomeExtensions.unite
    gettext # Compiling hide-top-bar
    glib # ^^^
    glib.dev # ^^^
    gnome.gnome-tweaks # Customize GNOME

    # Social
    telegram-desktop # Telegram client
    vesktop # Discord + Vencord
    whatsapp-for-linux # Whatsapp client

    # Hardware
    libratbag # Gaming mouse configuration
    g810-led # Logitech keyboard configuration
    xorg.xbacklight # Backlight control
    brightnessctl # Also backlight control
    acpi # Battery info

    # Networking
    openssl # SSL/TLS cryptography library

    # Fonts
    nerdfonts
    nerd-font-patcher
    quicksand
    cantarell-fonts
    # TODO: Port this over
    # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=nerd-fonts-inter
    # For now, manually install.

    ################
    # Developing
    ################

    jetbrains.clion # C/C++ code editor
    jetbrains.idea-community-bin # Java code editor
    postman # API testing
    php83 # PHP runtime

    # Android / iOS
    android-studio # Android development
    android-tools # Android development: Part 2
    flutter # Mobile development

    # Rust
    rustup # Rust downloader and toolchain switcher
    cargo-audit # Audit for security vulnerabilities
    pkg-config # Compiling openssl-sys crate
    sqlite # Compiling libsqlite3-sys crate

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
          requests
          eyed3
        ]))

    # Haskell (important for xmonad)
    ghc
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server
    haskellPackages.hoogle
    haskellPackages.fourmolu
    haskellPackages.cabal-fmt

    # C/C++
    cmake # Makefile support
    gnumake # Supplies `make`
    # gcc # Provides `gcc` and `cc`. Also required for Rust.
    clang # Provides `clang` and `clang++`
    libcxx # Provides important things for clang I think
    libcxx.dev # ^

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
    zip # `zip` command
    unzip # `unzip` command
    psmisc # `fuser` command
    pciutils # `lspci` command
    patchelf # Modify ELF headers to make some stuff work on NixOS

    filezilla # FTP GUI client

    ################
    # Media
    ################
    audacity # Ugly audio editor
    kdenlive # Ugly video editor
    krita # Ugly image editor
    blender # Not as ugly 3d modeling
    reaper # DAW

    amberol # Simple audio player
    blanket # Pleasant sounds :3
    eartag # Music metadata editor
    ffmpeg # Command-line audio & video manipulation
    helvum # Pipe audio and connect up inputs and outputs
    playerctl # Interact with MPRIS-compatible programs from the command line
    obsidian # Markdown editor
    vlc # Video & audio player
    pulseaudio # Audio server
    pamixer # Pulseaudio cli mixer

    libreoffice # Office suite

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
    # Other packages can be found in nix/media.nix

    ################
    # Games
    ################
    godot_4 # Game engine # TODO: Upgrade to mono version when thats added
    love # 2D game engine
    (callPackage ./olympus {}) # Celeste mod loader
    cubiomes-viewer # Minecraft biome viewer
    prismlauncher # Minecraft launcher
    ferium # Minecraft mod manager
    steam # Hub for games
    steam-run # Use dynamically linked games
    protontricks # Steam's Proton helpers
    wine # Window compatibility
    winetricks # Wine helpers
    inputs.ow-mod-man.packages.x86_64-linux.owmods-gui
    inputs.ow-mod-man.packages.x86_64-linux.owmods-cli
    ns-usbloader # Nintendo Switch homebrew manager
    joycond # Switch Pro controller and joycon support
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

{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./programs
    ./services
  ];

  home.username = "dooshii";
  home.homeDirectory = "/home/dooshii";
  xdg = {
    enable = true;
    userDirs.enable = true;
    # Portals defined in `nix/wayland.nix`
  };

  home.sessionVariables = {
    BROWSER = "firefox-devedition";
    NIX_SRC = config.lib.theme.source-folder;
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    XDG_CONFIG_HOME = "/home/dooshii/.config";
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.libglvnd
      pkgs.pulseaudio
      "/run/opengl-driver"
      "/run/opengl-driver-32"
      pkgs.ocl-icd
    ];
    LIBGL_DRIVERS_PATH = "${pkgs.mesa}/lib:${pkgs.mesa}/lib/dri";
    __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    ################
    # System
    ################
    egl-wayland
    xwayland
    hyprutils
    nemo-with-extensions
    cryptsetup

    # Ensure you enable these in GNOME Extensions
    # With Pop Shell, disable mouse stacking
    # Can't customize keybinds with Pop Shell yet: https://github.com/NixOS/nixpkgs/issues/92265
    # gnomeExtensions.pop-shell # Pop_OS! extension stuff (like grid view)
    # gnomeExtensions.pano # Global clipboard manager
    # gnomeExtensions.rounded-window-corners-reborn # Rounded window corners
    # gnomeExtensions.hide-top-bar # Remove stinky top bar eww
    # gnomeExtensions.gsconnect # KDE Connect for Gnome. Connect to your phone!
    # gnomeExtensions.color-picker # Color picker
    # gnomeExtensions.unite
    # gnome-tweaks # Customize GNOME

    # Social
    telegram-desktop # Telegram client
    wasistlos # Whatsapp client
    slack # Slack client

    # Basic services
    protonvpn-gui
    protonmail-desktop
    proton-pass
    gnome-calculator
    keymapp # Keyboard

    # Networking
    openssl # SSL/TLS cryptography library

    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-sans
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    nerd-fonts.space-mono
    nerd-font-patcher
    quicksand
    cantarell-fonts
    gnome-characters
    # TODO: Port this over
    # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=nerd-fonts-inter
    # For now, manually install.

    ################
    # Developing
    ################

    postman # API testing

    # Rust
    rustup # Rust downloader and toolchain switcher
    cargo-audit # Audit for security vulnerabilities
    pkg-config # Compiling openssl-sys crate
    sqlite # Compiling libsqlite3-sys crate
    cargo-flamegraph # Performance graphs for rust projects
    mold # Faster compiler

    # Javascript
    nodejs_22 # Javascript runtime; also provides npm
    nodePackages.pnpm # Faster, less disk space npm

    # PHP
    php84 # PHP runtime
    php84Packages.composer # PHP package installer

    # Python
    python312 # Latest stable Python
    python312Packages.dbus-python

    # C/C++
    cmake # Makefile support
    gnumake # Supplies `make`
    # gcc # Provides `gcc` and `cc`. Also required for Rust.
    clang # Provides `clang` and `clang++`
    libcxx # Provides important things for clang I think
    libcxx.dev # ^

    # Java
    javaPackages.compiler.openjdk25
    gradle # Java development
    jetbrains.idea-community-bin

    # Modding
    avalonia-ilspy # Decompile C#

    # Git
    gitg # Visual git viewer
    git-crypt # Git encryption

    # Databases
    mysql84 # Database client
    antares # Database viewer
    dbeaver-bin # Another database viewer

    # Neovim LSPs and formatters and linters and such
    astro-language-server
    bash-language-server
    black # Python formatter
    blade-formatter
    python312Packages.debugpy # Debug protocol for python
    dockerfile-language-server
    docker-compose-language-service
    eslint
    hadolint # Dockerfile linter
    intelephense # PHP, freemium
    nixfmt-rfc-style # Official formatter, replacing alejandra
    nil # Nix language server
    vscode-langservers-extracted # HTML, CSS, some others too

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
    unrar-free # `unrar-free` command (extract RAR files)
    psmisc # `fuser` command
    pciutils # `lspci` command
    patchelf # Modify ELF headers to make some stuff work on NixOS
    tldr # Simplified man pages
    tree # Recursive ls
    uutils-coreutils-noprefix # rust coreutils replacement
    xh # Better `curl`
    dust # Better `du`
    dua # Interactive `du`
    hyperfine # Benchmark tool
    just # Command runner
    htop # Performance
    btop # Also performance
    inxi # System settings
    bluetui # Bluetooth manager
    delta # Better git differ

    kitty # Terminal

    xvfb-run # Fixing OpenGL issues
    mesa-demos # Fixing OpenGL issues

    filezilla # FTP GUI client

    ################
    # Media
    ################
    audacity # Ugly audio editor
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
    pulseaudio # Audio server
    pamixer # Pulseaudio cli mixer
    pavucontrol # Audio controller

    libreoffice # Office suite

    ymuse # MPD front-end
    mpc # Interact with MPD from the command line
    cava # music visualizer
    lrcget # LRCLIB frontend
    nicotine-plus # Soulseek client

    # Piracy
    qbittorrent # Torrent downloader
    # Other packages can be found in nix/media.nix

    ################
    # Games
    ################
    godot-mono # Game engine
    love # 2D game engine
    olympus # Celeste mod loader
    lumafly # Hollow Knight mod loader
    cubiomes-viewer # Minecraft biome viewer
    (prismlauncher.override {
      jdks = [
        javaPackages.compiler.openjdk25
      ];
    })
    ocl-icd
    ferium # Minecraft mod manager
    steam-run # Use dynamically linked games
    mangohud # Computer usage overlay. `mangohud %command%` in Steam
    protonup-ng # ProtonGE. Use `protonup -d "~/.steam/root/compatibilitytools.d/"` to install GE
    lutris # Steam but for Humble Bundle too
    wine # Window compatibility
    winetricks # Wine helpers
    # inputs.ow-mod-man.packages.x86_64-linux.owmods-gui # Outer Wilds mod loader
    # inputs.ow-mod-man.packages.x86_64-linux.owmods-cli # Outer Wilds mod loader
    # ns-usbloader # Nintendo Switch homebrew manager
    joycond # Switch Pro controller and joycon support
    cemu # Wii-U emulator
    joycond-cemuhook # Motion control support
    archipelago # Randomiser
    dolphin-emu # Wii / Gamecube emulator
    ryubing # Switch emulator
    wl-clicker # autoclicker
    azahar # 3DS emulator
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

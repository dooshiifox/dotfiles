# https://github.com/Mic92/dotfiles/blob/759b7ee0badfe3b2658c87e995c23b8ef5add8ab/nixosModules/fhs-compat.nix#L11
{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.nix-ld.enable = lib.mkDefault true;
  programs.nix-ld.libraries = with pkgs;
    [
      acl
      attr
      bzip2
      dbus
      expat
      fontconfig
      freetype
      fuse3
      icu
      libnotify
      libsodium
      libssh
      libunwind
      libusb1
      libuuid
      nspr
      nss
      stdenv.cc.cc
      util-linux
      zlib
      zstd
    ]
    ++ lib.optionals (config.hardware.graphics.enable) [
      pipewire
      cups
      libxkbcommon
      pango
      mesa
      libdrm
      # libglvnd
      libpulseaudio
      atk
      cairo
      alsa-lib
      at-spi2-atk
      at-spi2-core
      gdk-pixbuf
      glib
      gtk3
      libGL
      libappindicator-gtk3
      # libglvnd
      vulkan-loader
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxkbfile
      xorg.libxshmfence
    ];
}

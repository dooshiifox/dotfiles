# https://github.com/Ap6661/septabee-flake/blob/main/flake.nix
{ pkgs, lib, ... }:
let
  depends = with pkgs; [
    libpng
    vulkan-loader
    freetype
    pipewire
    libx11
    stdenv.cc.cc.lib
    lilv
    zstd
    ncurses
    wayland
    libxkbcommon
  ];
  version = "yeet-44";
in
pkgs.stdenv.mkDerivation {
  name = "septabee-${version}";
  inherit version;
  src = pkgs.fetchurl {
    url = "https://septabee.nekoweb.org/important_stuff/SEPTABEE_DOWNLOADS/version_B/septabee_linux_B_T2.7z";
    sha256 = "sha256-OMnbRBTku8yi4b3Ay7d70EbB/e2Qh+PfzK2O8qRFoaA=";
  };

  nativeBuildInputs = with pkgs; [
    p7zip
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = depends;

  unpackPhase = ''
    runHook preUnpack
    7z x "$src"
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin" 
    cp -r ./linux/* "$out/bin/"
    runHook postInstall
  '';

  postFixup = ''
    wrapProgram "$out/bin/septabee" \
      --chdir "$out" \
      --run "
        data_home=\"\''\${XDG_DATA_HOME:-\$HOME/.local/share}\"
        abi_dir=\"\$data_home/Septabee/llvm-stuffs/abi-8\"

        mkdir -p \"\$abi_dir\"
      "
  '';

  meta = with lib; {
    description = "weird DAW";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}

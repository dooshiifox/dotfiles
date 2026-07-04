# ProCon2 - Nintendo Switch 2 Pro Controller USB initializer
# https://github.com/TophC7/mix.nix/blob/ccb310fdbf1547fd35a472eb9ceb21a9d5f890b4/packages/procon2-init/default.nix
{ lib, pkgs, ... }:
let
  inherit (pkgs)
    python3
    libusb1
    makeWrapper
    libnotify
    ;

  pythonEnv = python3.withPackages (
    ps: with ps; [
      pyusb
    ]
  );
in
python3.pkgs.buildPythonApplication {
  pname = "procon2-init";
  version = "0.1.0";

  src = ./.;

  format = "other";

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [
    pythonEnv
    libusb1
    libnotify
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    # Copy the Python script
    cp procon2-init.py $out/bin/procon2-init.py

    # Create executable wrapper
    cat > $out/bin/procon2-init << 'EOF'
    #!${pythonEnv}/bin/python3
    import sys
    import os
    sys.path.insert(0, os.path.dirname(__file__))
    exec(open(os.path.join(os.path.dirname(__file__), 'procon2-init.py')).read())
    EOF

    chmod +x $out/bin/procon2-init

    # Wrap to ensure libusb is found at runtime
    wrapProgram $out/bin/procon2-init \
      --prefix LD_LIBRARY_PATH : "${libusb1}/lib" \
      --prefix PATH : "${pythonEnv}/bin"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Initializer for Nintendo Switch 2 Pro Controller";
    longDescription = ''
      Sends initialization sequence to Nintendo Switch 2 Pro Controller
      to enable HID input on Linux. Based on reverse engineering of the
      controller's USB protocol by https://github.com/HandHeldLegend
    '';
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ tophc7 ];
  };
}

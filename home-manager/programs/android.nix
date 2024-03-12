# Requires overlay defined in `nix/default.nix` and flake from
# `flake.nix` to be used.
{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.android-nixpkgs.hmModule
  ];

  android-sdk = {
    enable = true;

    # Optional; default path is "~/.local/share/android".
    path = "${config.home.homeDirectory}/.android/sdk";

    packages = sdk:
      with sdk; [
        build-tools-30-0-3
        cmdline-tools-latest
        emulator
        platforms-android-33
        platform-tools
        sources-android-34
        tools
        ndk-23-1-7779620
      ];
  };
}

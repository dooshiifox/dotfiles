# Requires overlay defined in `nix/default.nix` and flake from
# `flake.nix` to be used.
{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.android-nixpkgs.hmModule
  ];

  # home.sessionVariables = {
  #   GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${config.android-sdk.packages.build-tools-33-0-0}/aapt2";
  # };

  # android-sdk = {
  #   enable = true;

  #   # Optional; default path is "~/.local/share/android".
  #   path = "${config.home.homeDirectory}/.android/sdk";

  #   packages = sdk:
  #     with sdk; [
  #       build-tools-30-0-3
  #       build-tools-33-0-0
  #       cmdline-tools-latest
  #       emulator
  #       platforms-android-33
  #       platform-tools
  #       sources-android-34
  #       tools
  #       ndk-23-1-7779620
  #       cmake-3-22-1
  #     ];
  # };
}

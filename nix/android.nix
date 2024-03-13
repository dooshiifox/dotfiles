{pkgs, ...}: let
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/mobile/androidenv/compose-android-packages.nix
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = ["30.0.3" "33.0.0"];
    platformVersions = ["33"];
    # abiVersions = ["armeabi-v7a" "arm64-v8a"];
    includeEmulator = true;
    ndkVersions = ["23.1.7779620"];
    includeNDK = true;
    cmakeVersions = ["3.22.1"];
    includeSources = true;
  };
  androidSdk = androidComposition.androidsdk;
in {
  programs.adb.enable = true;
  users.users.dooshii.extraGroups = ["adbusers"];
  nixpkgs.config.android_sdk.accept_license = true;

  environment.sessionVariables = {
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/31.0.0/aapt2";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
  };
  environment.systemPackages = with pkgs; [
    androidSdk
  ];
}

{...}: let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = ["30.0.3" "33.0.0"];
    platformVersions = ["33"];
    abiVersions = ["armeabi-v7a" "arm64-v8a"];
  };
  androidSdk = androidComposition.androidsdk;
in {
  programs.adb.enable = true;
  users.users.dooshii.extraGroups = ["adbusers"];

  environment.sessionVariables = {
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/31.0.0/aapt2";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
  };
}

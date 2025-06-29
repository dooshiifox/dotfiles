# Records the screen
# https://github.com/nix-community/home-manager/blob/master/modules/programs/obs-studio.nix
{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };
}

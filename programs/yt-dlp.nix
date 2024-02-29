# Downloads content from YouTube and other sources.
# https://github.com/nix-community/home-manager/blob/master/modules/programs/yt-dlp.nix
{
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
    };
  };
}
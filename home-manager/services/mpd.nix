{ ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/dooshii/Music";
    extraConfig = ''
      audio_output {
      	type "pipewire"
      	name "My PipeWire Output"
      }
    '';
    dataDir = "/home/dooshii/.local/share/mpd";
    # user = "userRunningPipeWire";
  };
  services.mpd-mpris.enable = true;
}

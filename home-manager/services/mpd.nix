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
    # user = "userRunningPipeWire";
  };
  services.mpd-mpris.enable = true;
}

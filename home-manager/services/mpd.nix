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
      audio_output {
      	type   "fifo"
      	name   "my_fifo"
      	path   "/tmp/mpd.fifo"
      	format "44100:16:2"
      }
    '';
    dataDir = "/home/dooshii/.local/share/mpd";
    network = {
      listenAddress = "/tmp/mpd_socket";
    };
    # user = "userRunningPipeWire";
  };
  services.mpd-mpris = {
    enable = true;
    mpd = {
      useLocal = false; # defaults to true, causes it to not work cause we use sockets
      host = "/tmp/mpd_socket";
      network = "unix";
    };
  };
  home.sessionVariables = {
    MPD_HOST = "/tmp/mpd_socket";
  };
}

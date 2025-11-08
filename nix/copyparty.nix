{ config, has_secrets, ... }:
{
  services.copyparty = {
    enable = has_secrets;

    settings = {
      # IP
      i = "0.0.0.0";
      # Port
      p = 3210;
    };

    accounts = {
      dooshii.passwordFile = "${config.lib.theme.source-folder}/secrets/copyparty.dooshii.txt";
    };

    volumes = {
      "/" = {
        path = "/data";
        # Permissions
        # https://github.com/9001/copyparty/?tab=readme-ov-file#accounts-and-volumes
        access = {
          r = "*";
          A = [ "dooshii" ];
        };
        flags = {
          # Rescan files every 60 seconds
          # https://github.com/9001/copyparty/?tab=readme-ov-file#file-indexing
          scan = 60;
          # Indexing of files and song tags. Allows searching
          # https://github.com/9001/copyparty/?tab=readme-ov-file#file-indexing
          e2dsa = true;
          e2ts = true;
          # Announces fileserver on file explorers
          # https://github.com/9001/copyparty/?tab=readme-ov-file#zeroconf
          z = true;
        };
      };

      "/obsidian" = {
        path = "/home/dooshii/Documents/obsidian/";
        access = {
          A = [ "dooshii" ];
        };
        flags = {
          scan = 60;
          e2dsa = true;
          e2ts = true;
        };
      };
    };
  };
}

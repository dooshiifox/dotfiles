{ config, ... }:
{
  services.copyparty = {
    enable = true;

    settings = {
      i = "0.0.0.0";
      p = 3210;
    };

    accounts = {
      dooshii.passwordFile = "${config.lib.theme.source-folder}/secrets/copyparty.dooshii.txt";
    };

    volumes = {
      "/" = {
        path = "/data";
        access = {
          r = "*";
          A = [ "dooshii" ];
        };
        flags = {
          scan = 60;
        };
      };
    };
  };
}

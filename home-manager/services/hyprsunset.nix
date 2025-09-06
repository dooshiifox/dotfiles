_: {
  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "8:00";
          identity = true;
        }
        {
          time = "20:00";
          temperature = 3500;
          # gamma = 0.8;
        }
      ];
    };
  };
}

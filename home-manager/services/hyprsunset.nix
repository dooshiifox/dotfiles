_: {
  services.hyprsunset = {
    enable = true;
    transitions = {
      sunrise = {
        calendar = "*-*-* 08:00:00";
        requests = [
          ["identity"]
        ];
      };
      sunset = {
        calendar = "*-*-* 20:00:00";
        requests = [
          ["temperature" "3500"]
        ];
      };
    };
  };
}

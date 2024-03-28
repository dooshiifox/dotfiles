{...}: {
  services.greetd = {
    enable = true;

    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "dooshii";
      };
      default_session = initial_session;
    };
  };
}

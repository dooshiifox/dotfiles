{
  programs.steam = {
    enable = true;
    # Optimisations for displays
    # `gamescope %command%` in Steam
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };
  # Performance daemon
  # `gamemoderun %command%` in Steam
  programs.gamemode.enable = true;
}

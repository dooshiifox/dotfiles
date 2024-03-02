# Dotfiles

My system uses NixOS. This configuration assumes:

-   You've symlinked `flake.lock` and `flake.nix` inside `/etc/nixos/`
-   You've copied `programs/vscode/theme` to `~/.vscode/extensions/`
-   You've set up your mail config in `scripts/local/mailsconf.py`
-   You've set up your weather config in `scripts/local/weatherconf`
-   You've downloaded some images to use in the eww weather & time box in `eww/assets`. Files are of the format `weather_{num}{d/n}.jpg`.
    -   `d/n` is for day and night.
    -   `01` - Sunny
    -   `02` - Few clouds
    -   `03` - Scattered clouds
    -   `04` - Broken clouds
    -   `09` - Shower rain
    -   `10` - Rain
    -   `11` - Thunderstorm
    -   `13` - Snow
    -   `50` - Misty
    -   [Source](https://openweathermap.org/weather-conditions)
-   You've configured `$HOME/Videos/downloads` to be owned by the `multimedia` group.
    -   `sudo chown -R multimedia:multimedia $HOME/Videos/downloads`
    -   `sudo chmod -R g+w $HOME/Videos/downloads`

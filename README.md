# Dotfiles

My system uses NixOS. This configuration assumes you've symlinked `flake.lock` and `flake.nix` inside `/etc/nixos/`

Secrets are set up using `git-crypt`, and can be stored in `secrets`. [This article](https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/) is a good resource for learning more.

> Personal note: To decrypt from the secret key you stored in Dashlane, save it as `secret-key-base64`, `base64 --decode ./secret-key-base64 > ./secret-key-decoded`, then `git-crypt unlock ./secret-key-decoded`

## Post-install

Download and patch the `Inter` font.

```
wget https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip
unzip -d Inter Inter-4.0.zip
nerd-font-patcher --variable-width-glyphs -q -c -out "patched/" Inter/InterVariable.ttf
nerd-font-patcher --variable-width-glyphs -q -c -out "patched/" Inter/InterVariable-Italic.ttf
mv patched/* ~/.local/share/fonts
fc-cache -f -v
rmdir patched
rm -r Inter
rm Inter-4.0.zip
```

Do a similar thing with `Dank Mono`, which I cannot share for legal reasons.

Copy a profile image to `~/.face`.

Copy `home-manager/programs/vscode/theme` to `~/.vscode/extensions/`

Please note that I'm new to Nix! If you have any improvements, please educate me!

## Notes

### Clean-up old packages

Run `./clean-old-gens.sh`

### Environment variables

The `NIX_SRC` env variable is set to where the config is built in `/nix/store/...`. You can use this to e.g. reference scripts in `./scripts` from other places.

## Todo

- Fix occasional FPS drops
- Fix theming
    - Window titles
    - Make app themes consistent with each other
        - kitty
        - vesktop
        - firefox
        - vscodium
        - Rofi
        - nemo
    - Notifications
- Fix build times
- Fix boot time
- Fix sleep mode

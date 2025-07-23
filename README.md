# Dotfiles

My system uses NixOS. This configuration assumes you've symlinked `flake.lock` and `flake.nix` inside `/etc/nixos/`

Secrets are set up using `git-crypt`, and can be stored in `secrets`. [This article](https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/) is a good resource for learning more.

> Personal note: To decrypt from the secret key you stored in Dashlane, save it as `secret-key-base64`, `base64 --decode ./secret-key-base64 > ./secret-key-decoded`, then `git-crypt unlock ./secret-key-decoded`

## Notes

### Update flake inputs

Run `nix flake update`

### Clean-up old packages

Run `./scripts/clean-old-gens`

### Clean up other parts of the system

`dua interactive /` will create an interactive disk-usage analyzer.

#### `/var/log`

```sh
sudo journalctl --rotate
sudo journalctl --vacuum-time=2d
```

#### `/var/lib/systemd/coredump/`

```sh
# This should be safe but I'm unsure
sudo rm /var/lib/systemd/coredump/*
```

### Environment variables

The `NIX_SRC` env variable is set to where the config is built in `/nix/store/...`. You can use this to e.g. reference scripts in `./scripts` from other places.

## Todo

- Fix occasional FPS drops
- Fix theming
  - Window titles
  - Make app themes consistent with each other
    - vesktop?
    - vscodium?
    - gnome
      - nemo
      - firefox
      - https://mynixos.com/home-manager/option/gtk.gtk4.extraCss
      - https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
- Fix build times
- Fix boot time
- Fix sleep mode

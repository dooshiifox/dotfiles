# Dotfiles

My system uses NixOS. This configuration assumes you've symlinked `flake.lock` and `flake.nix` inside `/etc/nixos/`

Secrets are set up using `git-crypt`, and can be stored in `secrets`. [This article](https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/) is a good resource for learning more.

## Install script-ish

This is untested in its entirety. Take it one line at a time

```sh
profile="mynewprofile"
nmtui # Connect to an internet connection
nix-shell -p neovim git
git clone https://github.com/dooshiifox/dotfiles.git nixos
cd dotfiles
sudo mv /etc/nixos/hardware-configuration.nix hardware/"$profile".nix
sudo rm /etc/nixos/configuration.nix
sudo ln -s /home/$(whoami)/nixos/flake.nix /etc/nixos/flake.nix
sudo ln -s /home/$(whoami)/nixos/flake.lock /etc/nixos/flake.lock

nvim flake.nix # Configure flake.nix to have the new profile.
# Disable secrets! Pointing to an invalid wallpaper is fine

git add .
sudo nixos-rebuild switch --flake ".#$profile" --show-trace

# Once logged in...

# The Nix language server will fail to install without these
rustup toolchain install nightly
rustup default nightly

# Copy the decryption key from ProtonPass
cd nixos
wl-paste > secret-key-base64
base64 --decode ./secret-key-base64 ./secret-key-decoded
git-crypt unlock ./secret-key-decoded
rm ./secret-key-base64 ./secret-key-decoded
nvim flake.nix # Enable secrets for this profile

# Download a new wallpaper and provide it for the profile
nvim flake.nix

ni # Reload the new config

# Once you add the SSH keys
e /home/dooshii/nixos/.git/config # set `url = git@github.com:dooshiifox/dotfiles.git`
```

## Notes

### Update flake inputs

Run `sudo nix flake update`

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
  - gnome
    - nemo
    - firefox
    - https://mynixos.com/home-manager/option/gtk.gtk4.extraCss
    - https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
- Fix build times
- Fix boot time
- Fix sleep mode

## Windows Dual Booting Failing?

https://www.reddit.com/r/archlinux/comments/yes44f/psa_disable_vmd_on_an_intel_laptop_if_you_have/

root@{ pkgs, inputs, ... }:
let
  themes = import ./themes root;

  # v THIS IS THE LINE YOU WANT TO EDIT
  theme = themes.green.dark;
  # ^ THAT IS THE LINE YOU WANT TO EDIT
  #
  # should we find out a way to put this as part of `flake.nix` profiles?
in
{
  imports = [
    inputs.base16.nixosModule
  ];
  config.lib.theme = theme;
  config.scheme = theme.colors;
}

{
  description = "dooshii's NixOS flake.";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/7611b2aec43814158708aec23bd4b20709dacaab";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # VSCode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/1a1442e13dc1730de0443f80dcf02658365e999a";
    # Outer Wilds mod manager
    ow-mod-man = {
      url = "github:ow-mods/ow-mod-man/c15a09abb379f16c9d39652c8e3768fe2179d6eb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hypr-dynamic-cursors = {
    #   url = "github:VirtCode/hypr-dynamic-cursors";
    #   inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    # "gnome", "gnome-wayland", "hypr", "xmonad"
    mode = "hypr";
    THEME = import ./theme.nix {
      inherit inputs;
      inherit (nixpkgs) lib;
    };
  in {
    nixosConfigurations.dooshii = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit mode;
        inherit THEME;
      };
      modules = [
        ./nix

        # make home-manager as a module of nixos so that
        # home-manager configuration will be deployed automatically
        # when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hmbackup";

          home-manager.users.dooshii.imports = [
            ./home-manager
          ];

          # Optionally, use home-manager.extraSpecialArgs to pass arguments
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit mode;
            inherit THEME;
          };
        }
      ];
    };
  };
}

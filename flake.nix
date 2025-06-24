{
  description = "dooshii's NixOS flake.";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/f771eb40";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # VSCode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/dcfd2c7fb29ed73c284c5c1528ae1a08b2f8d2e2";
    # Outer Wilds mod manager
    ow-mod-man = {
      url = "github:ow-mods/ow-mod-man/594c9de8c067fa9c70baa0835acb3f4fa23b2a56";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    # "gnome", "gnome-wayland", "hypr", "xmonad"
    mode = "hypr";
    PROJECT_ROOT = builtins.toString ./.;
  in {
    nixosConfigurations.dooshii = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      # Enable accessing `inputs` in config files
      specialArgs = {
        inherit inputs;
        inherit mode;
        inherit PROJECT_ROOT;
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
          home-manager.backupFileExtension = "backup";

          home-manager.users.dooshii.imports = [
            ./home-manager
          ];

          # Optionally, use home-manager.extraSpecialArgs to pass arguments
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit mode;
            inherit PROJECT_ROOT;
          };
        }
      ];
    };
  };
}

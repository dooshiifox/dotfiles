{
  description = "dooshii's NixOS flake.";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # VSCode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # Outer Wilds mod manager
    ow-mod-man = {
      url = "github:ow-mods/ow-mod-man";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprcursor.url = "github:hyprwm/hyprcursor";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
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
  }: {
    nixosConfigurations.dooshii = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Enable accessing `inputs` in config files
      specialArgs = {
        inherit inputs;
        "PROJECT_ROOT" = builtins.toString ./.;
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

          home-manager.users.dooshii.imports = [
            ./home-manager
            inputs.hyprland.homeManagerModules.default
            inputs.hypridle.homeManagerModules.default
            inputs.hyprlock.homeManagerModules.default
          ];

          # Optionally, use home-manager.extraSpecialArgs to pass arguments
          home-manager.extraSpecialArgs = {
            inherit inputs;
            "PROJECT_ROOT" = builtins.toString ./.;
          };
        }
      ];
    };
  };
}

{
  description = "dooshii's NixOS flake.";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # VSCode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # Outer Wilds mod manager
    # ow-mod-man = {
    #   url = "github:ow-mods/ow-mod-man";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16 = {
      url = "github:SenchoPens/base16.nix";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
    };
    plover-flake.url = "github:openstenoproject/plover-flake";
    copyparty.url = "github:9001/copyparty";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      optionals = condition: list: if condition then list else [ ];
      for_profile =
        current_profile: profiles: list:
        if builtins.isString profiles then
          optionals (profiles == current_profile) list
        else
          optionals (builtins.any (p: p == current_profile) list);
      build =
        {
          profile,
          has_secrets,
          wallpaper,
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              profile
              has_secrets
              wallpaper
              ;
            for_profile = for_profile profile;
            if_secrets = optionals has_secrets;
          };
          modules = [
            ./theme.nix
            ./nix
            inputs.copyparty.nixosModules.default

            # make home-manager as a module of nixos so that
            # home-manager configuration will be deployed automatically
            # when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hmbackup";

              home-manager.users.dooshii.imports = [
                inputs.plover-flake.homeManagerModules.plover
                inputs.nixcord.homeModules.nixcord
                ./theme.nix
                ./home-manager
              ];

              # Optionally, use home-manager.extraSpecialArgs to pass arguments
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  profile
                  has_secrets
                  wallpaper
                  ;
                for_profile = for_profile profile;
                if_secrets = optionals has_secrets;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations.old = build {
        profile = "old";
        has_secrets = true;
        wallpaper = /home/dooshii/Pictures/wallpaper/jacato_float.png;
      };
      nixosConfigurations.work = build {
        profile = "work";
        has_secrets = true;
        wallpaper = /home/dooshii/Pictures/2022-apraug-ko.png;
      };
    };
}

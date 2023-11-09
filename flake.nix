{
  description = "Jenya NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
    system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        "default" = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          modules = [
            ./hosts/laptop
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.jenya = import ./home;
                extraSpecialArgs = specialArgs;
              };
            }
          ];
        };
        "base" = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          modules = [
            ./hosts/laptop
          ];
        };
      };
    };
}

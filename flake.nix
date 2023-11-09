{
  description = "Jenya NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
    nixosConfigurations = {

      "default" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            system = system;
            config.allowUnfree = true;
          };
        };

        modules = [
          ./hosts/laptop

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.jenya = import ./home;
          }
        ];
      };
      "base" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            system = system;
            config.allowUnfree = true;
          };
        };
        
        modules = [
          ./hosts/laptop

        ];
      };
    };
  };
}

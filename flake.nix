{
  description = "Jenya NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        "laptop-full" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./nixos
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.jenya = import ./home;
                extraSpecialArgs.inputs = inputs;
              };
            }
          ];
        };
        "laptop-minimal" = nixpkgs.lib.nixosSystem {
          modules = [
            ./nixos
          ];
        };
      };
    };
}

{
  description = "Jenya NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        "laptop-full" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/laptop
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.jenya = import ./home;
              };
            }
          ];
        };
        "laptop-minimal" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/laptop
          ];
        };
        # "tv-full" = nixpkgs.lib.nixosSystem {
        #   inherit system;
        #   inherit specialArgs;
        #   modules = [
        #     ./hosts/tv
        #     home-manager.nixosModules.home-manager
        #     {
        #       home-manager = {
        #         useGlobalPkgs = true;
        #         useUserPackages = true;

        #         users.tv = import ./home;
        #         extraSpecialArgs = specialArgs;
        #       };
        #     }
        #   ];
        # };
        "tv-minimal" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/tv
          ];
        };
      };
    };
}

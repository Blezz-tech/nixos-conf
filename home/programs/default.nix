{ config
, pkgs
, ...
}: {
  imports = [
    ./common.nix
    ./git.nix
    ./steam.nixs
    ./vscodium.nix
    #  ./browsers.nix
    #  ./media.nix
    #  ./xdg.nix
  ];
}

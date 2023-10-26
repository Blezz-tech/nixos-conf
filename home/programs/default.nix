{ config
, pkgs
, ...
}: {
  imports = [
    ./git.nix
    #  ./browsers.nix
     ./common.nix
    #  ./media.nix
    #  ./vscodium.nix
    #  ./xdg.nix
  ];
}

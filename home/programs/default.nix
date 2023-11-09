{ config
, pkgs
, ...
}: {
  imports = [
    ./common.nix
    ./git.nix
    ./steam.nix
    ./vscodium.nix
    #  ./browsers.nix
    #  ./media.nix
    #  ./xdg.nix
  ];
}

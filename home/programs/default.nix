{ config
, pkgs
, ...
}: {
  imports = [
    ./common.nix
    ./git.nix
    # ./vscodium.nix
    # ./browsers.nix
    # ./media.nix
    # ./xdg.nix
  ];
}

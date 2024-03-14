{ config
, pkgs
, ...
}: {
  imports = [
    ./common.nix
    ./git.nix
    # ./neovim.nix
    # ./browsers.nix
    # ./media.nix
    # ./xdg.nix
  ];
}

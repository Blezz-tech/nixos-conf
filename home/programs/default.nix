{ config
, pkgs
, ...
}: {
  imports = [
    ./git.nix
    #  ./browsers.nix
    #  ./common.nix
    #  ./media.nix
    #  ./vscode.nix
    #  ./xdg.nix
  ];
}

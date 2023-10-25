{ config, ... }: {
  imports = [
    ./starship.nix
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your cusotm bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      myViewConf = "nvim ~/nixos-conf";
      myEditConf = "nvim ~/nixos-conf";
      myBuildSystem = "sudo nixos-rebuild switch --show-trace --flake ~/nixos-conf#default";
    };
  };

}

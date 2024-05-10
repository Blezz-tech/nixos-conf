{
  imports = [
    ./starship.nix
    ./alacritty.nix
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
      myErrors = "journalctl -p 3 -xb";

      myBuildSystem = "sudo nixos-rebuild switch --show-trace --flake ~/nixos-conf#laptop";
      myBuildHome = "home-manager switch --flake ~/nixos-conf";
      myBuildAll = "myBuildSystem ; myBuildHome";

      myDeleteSystem = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system";
      myDeleteHome = "nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager";
      myDeleteAll = "myDeleteSystem ; myDeleteHome";

      myClear = ''
        sudo nix store gc
        sudo nix store optimise
      '';
      myClearHistory = ''
        sudo journalctl --rotate
        sudo journalctl --vacuum-time=1s
      '';
      myPasswordGenerator = "pwgen -c 30";

      Desktop = "cd ~/system/desktop";
      Downloads = "cd ~/downloads";
      Images = "cd ~/media/images";
      Documents = "cd ~/system/documents";
      Videos = "cd ~/media/videos";
      Music = "cd ~/media/music";
      # Public   = "~/system/public";
      # Template = "~/system/templates";
    };
  };
}

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
      myConf = "cd ~/nixos-conf";
      myViewConf = "cd myConf && nvim .";
      myBuildSystem = "sudo nixos-rebuild switch --show-trace --flake ~/nixos-conf#laptop-full";
      myErrors = "journalctl -p 3 -xb";
      myGit = "~/git-repos";
      myGenerations = "nix profile history --profile /nix/var/nix/profiles/system";
      myDeleteGenerations = ''
        sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
        nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager
      '';
      myClear = ''
        sudo nix store gc
        sudo nix store optimise
      '';
      myClearHistory = ''
        sudo journalctl --rotate
        sudo journalctl --vacuum-time=1s
      '';
      myServicesOption = "nixos-option services";

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

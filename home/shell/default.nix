{ config, ... }: {
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
      myViewConf = "nvim ~/nixos-conf";
      myEditConf = "nvim ~/nixos-conf";
      myBuildSystem = "sudo nixos-rebuild switch --show-trace --flake ~/nixos-conf#default";
      myClearAll = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system";
      myCheckErrors = "journalctl -p 3 -xb";
      myGit = "cd ~/git-repos";
      myGenerations = "nix profile history --profile /nix/var/nix/profiles/system";
      myDeleteGenerations = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system";

      Downloads = "cd ~/Загрузки";
      Images = "cd ~/Изображения";
      Documents = "cd ~/Документы";
      Videos = "cd ~/Видео";
      Music = "cd ~/Музыка";
      # Public = "cd ~/Общедоступные";
      # Template = "cd ~/Шаблоны";
    };
  };
}

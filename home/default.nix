{
  imports = [
    ./programs
    ./shell
    ./XDG
    # ./fcitx5
  ];

  home.username = "jenya";
  home.homeDirectory = "/home/jenya";
  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}

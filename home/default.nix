{
  imports = [
    ./programs
    ./shell
    ./XDG
    # ./fcitx5
  ];

  home.username = "jenya";
  home.homeDirectory = "/home/jenya";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

{
  imports = [
    ./programs
    ./shell
    ./XDG
    # ./fcitx5
  ];

  home.username = "jenya";
  home.homeDirectory = "/home/jenya";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}

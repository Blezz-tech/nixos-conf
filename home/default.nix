{ config, pkgs, ... }:

{

  imports = [
   # ./fcitx5
   # ./i3
    ./programs
   # ./rofi
   ./shell
  ];


  # basic configuration of git, please change to your own
  #programs.git = {
  #  enable = true;
  #  userName = "blezz-tech";
  #  userEmail = "markus.jenya04@yandex.ru";
  #};


  home.username = "jenya";
  home.homeDirectory = "/home/jenya";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      env.WINIT_X11_SCALE_FACTOR = "1.0";
      font = {
        size = 10.0;
        normal.family = "Hack";
        bold.family = "Hack";
        italic.family = "Hack";
        bold_italic.family = "Hack";
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

{ pkgs
, ...
}: {
  # home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;

    userName = "blezz-tech";
    userEmail = "markus.jenya04@yandex.ru";
  };
}

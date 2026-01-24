{ pkgs
, ...
}:
let
  myPHPWithExtensions = pkgs.php83.withExtensions ({ enabled, all }: enabled ++ [
    all.bcmath
    all.tokenizer
    all.curl
    all.gd
    all.intl
    all.mbstring
    all.zip
    all.sqlite3
    all.pdo_mysql
    all.mysqli
    all.redis # Для Redis
  ]);
  myComposerWithPHPExtensions = myPHPWithExtensions.packages.composer;
in
{

  # programs.helix.enable = true;

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Breeze-Dark";
  #     package = pkgs.kdePackages.breeze-gtk;
  #   };
  # };

  programs.chromium = {
    enable = true;
    package = pkgs.vivaldi;
    commandLineArgs = [
      # "--disable-features=AllowQt"
      "--enable-blink-features=MiddleClickAutoscroll"

      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
  };

  # programs.chromium = {
  #   enable = true;
  #   package = pkgs.vivaldi;
  #   commandLineArgs = [
  #     "--disable-features=AllowQt"
  #     "--enable-blink-features=MiddleClickAutoscroll"
  #   ];
  # };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Packages that should be installed to the user profile.

  home.packages = with pkgs; [
    dbeaver-bin
    # nextcloud-client

    poppler-utils

    # jetbrains.idea-community

    # QSoft
    nodejs

    # myPHPWithExtensions
    # myComposerWithPHPExtensions

    # openssl

    # LaTeX
    (texliveMedium.withPackages (
      ps: with ps; [
        fontspec
        polyglossia
        amsmath
        hyphen-russian
        standalone
        luatex85
        pgfplots
        lastpage
        noto
        lm-math
        enumitem
        paralist
        tikz-3dplot
        asana-math
        stix2-otf
      ]
    ))

    pdf2svg

    # Torrent
    qbittorrent

    # Скачивание видео с ютуба
    yt-dlp

    # Альтернатива Postman'у
    # postman
    # insomnia

    # 3D редакторы
    # blender

    # Музыкальные редакторы
    # musescore

    # Месседжеры
    # discord-canary
    telegram-desktop

    # Редакторы epub
    # sigil

    # Графические редакторы
    # gimp
    inkscape
    krita
    drawio

    # Текстовые редакторы
    # kdePackages.kate
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US

    # onlyoffice-bin_latest

    # Запись видео и потоковое вещание
    # obs-studio

    # Игры
    prismlauncher
    # cataclysm-dda
    # cmatrix
    # keeperrl
    # minetest
    # wesnoth
    # openspades
    # airshipper

    # kdePackages.kolf
    # kdePackages.kmahjongg
    # kdePackages.knights
    # kdePackages.knavalbattle
    # kdePackages.kmines
    # kdePackages.picmi
    # kdePackages.ksudoku
    # kdePackages.kpat

    # kdePackages.ksirk
    # kdePackages.kajongg
    # kdePackages.kwordquiz

    # На сортировку
    (python3.withPackages (python-pkgs: [
      python-pkgs.pandas
      python-pkgs.requests
      # python-pkgs.jupyter
      python-pkgs.matplotlib
      python-pkgs.pandas
      # python-pkgs.scikit-learn
      python-pkgs.pylatex
    ]))
    google-chrome
    ffmpeg-full
    rar
    unrar-free
    # goldendict-ng
    sqlitebrowser
    # fd
    parsec-bin
    # gcc
    # geogebra6
    # gnumake
    # nushell
    # pandoc
    # unityhub
    # cachix
    # age
    # sops
    # imagemagick
    # zoom-us
    # omegat

    loco
    obsidian
    sea-orm-cli
    v2rayn
    cargo
    rustc
    rust-analyzer
    clang
    mold
    nixpkgs-fmt
    nixd
    # go-task
    # cargo-make
    # tiled
    # pdfarranger
    # ihp-new
    # vengi-tools
    # ldtk
    # easyocr
    # rhvoice
    # speechd
    # figma-linux
    # ventoy-full
    # appimage-run
    # crow-translate
    # element-desktop
    # ocrmypdf
    # stack
    # nheko
    # kdePackages.neochat
    # fractal
    tor-browser
    # kalzium
    # rustdesk
    vesktop
    # freetube
    (bottles.override {
      removeWarningPopup = true;
    })
    # ghc
    # mysql-workbench
    # zeal

    typst
    typstyle
    typst-live
    tinymist


    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # uwufetch
    # neofetch
    # nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    # jq # A lightweight and flexible command-line JSON processor
    # yq-go # yaml processer https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    # fzf # A command-line fuzzy finder

    # networking tools
    # mtr # A network diagnostic tool
    # iperf3
    # dnsutils # `dig` + `nslookup`
    # ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    # nmap # A utility for network discovery and security auditing
    # ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    # hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # Не нужно
    # github-desktop
    # cmake
  ];
}

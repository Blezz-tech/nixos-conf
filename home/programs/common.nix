{ pkgs
, config
, ...
}: {

  # programs.helix.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # LaTeX
    # texlive.combined.scheme-full
    pdf2svg

    # Torrent
    qbittorrent

    # Скачивание видео с ютуба
    yt-dlp

    # Альтернатива Postman'у
    insomnia

    # 3D редакторы
    blender

    # Музыкальные редакторы
    # musescore

    # Месседжеры
    discord
    telegram-desktop

    # Редакторы epub
    # sigil

    # Графические редакторы
    gimp
    inkscape
    krita
    drawio

    # Текстовые редакторы
    kate
    # libreoffice
    onlyoffice-bin
    neovim

    # Браузеры
    vivaldi

    # Запись видео и потоковое вещание
    # obs-studio

    # Игры
    prismlauncher
    # cataclysm-dda
    cmatrix
    # keeperrl
    # minetest
    wesnoth
    # openspades
    airshipper
    
    libsForQt5.kolf
    libsForQt5.kmahjongg
    libsForQt5.knights
    libsForQt5.knavalbattle
    libsForQt5.kmines
    libsForQt5.picmi
    libsForQt5.ksudoku
    libsForQt5.kpat

    # libsForQt5.ksirk
    # libsForQt5.kajongg
    # libsForQt5.kwordquiz

    # На сортировку
    python3
    nodejs
    # jetbrains.pycharm-community
    sqlitebrowser

    nixpkgs-fmt
    nixd
    # go-task
    # cargo-make
    gnumake
    nushellFull
    pandoc
    # tiled
    unityhub
    # pdfarranger
    ihp-new
    cachix
    # vengi-tools
    # ldtk
    # easyocr
    # rhvoice
    # speechd
    # figma-linux
    ventoy-full
    # appimage-run
    age
    sops
    imagemagick
    crow-translate
    zoom-us
    element-desktop
    omegat
    # poppler_utils
    # ocrmypdf
    # stack
    nheko
    libsForQt5.neochat
    fractal
    tor-browser
    # kalzium

    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # uwufetch
    neofetch
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

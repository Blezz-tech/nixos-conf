{ pkgs
, ...
}:
{
  programs.kdeconnect.enable = true;

  # programs.java.enable = true;

  # services.mysql.enable = true;
  # services.mysql.package = pkgs.mysql84;

  # services.redis.servers."" = {
  #   enable = true;
  # };

  # programs.npm.enable = true;

  programs.nix-ld.enable = false;
  programs.nix-ld.libraries = with pkgs; [
    SDL
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    SDL_image
    SDL_mixer
    SDL_ttf
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    bzip2
    cairo
    cups
    curlWithGnuTls
    dbus
    dbus-glib
    desktop-file-utils
    e2fsprogs
    expat
    flac
    fontconfig
    freeglut
    freetype
    fribidi
    fuse
    fuse3
    gdk-pixbuf
    glew110
    glib
    gmp
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer
    gtk2
    harfbuzz
    icu
    keyutils.lib
    libGL
    libGLU
    libappindicator-gtk2
    libcaca
    libcanberra
    libcap
    libclang.lib
    libdbusmenu
    libdrm
    libgcrypt
    libgpg-error
    libidn
    libjack2
    libjpeg
    libmikmod
    libogg
    libpng12
    libpulseaudio
    librsvg
    libsamplerate
    libthai
    libtheora
    libtiff
    libudev0-shim
    libusb1
    libuuid
    libvdpau
    libvorbis
    libvpx
    libxcrypt-legacy
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    p11-kit
    pango
    pixman
    python3
    speex
    stdenv.cc.cc
    tbb
    udev
    vulkan-loader
    wayland
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXft
    xorg.libXi
    xorg.libXinerama
    xorg.libXmu
    xorg.libXrandr
    xorg.libXrender
    xorg.libXt
    xorg.libXtst
    xorg.libXxf86vm
    xorg.libpciaccess
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    xorg.xkeyboardconfig
    xz
    zlib
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_default_ttl" = 65;
  };

  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  nixpkgs.config.permittedInsecurePackages = [ ];


  nix = {
    optimise.automatic = true;

    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    settings.substituters = [
      # "https://cache.nixos.org/"
    ];
    settings.trusted-substituters = [
      # "https://digitallyinduced.cachix.org"
    ];
    settings.trusted-public-keys = [
      # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
    ];


    gc.automatic = true;
    gc.dates = "daily";
    gc.options = "--delete-older-than 14d";
  };

  imports = [
    ./hardware-configuration.nix
    ./services
  ];

  i18n = {
    supportedLocales = [ "all" ];
    defaultLocale = "ru_RU.UTF-8";

    extraLocaleSettings = {
      LANG = "ru_RU.UTF-8";
      LC_CTYPE = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
      LC_COLLATE = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_MESSAGES = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_ALL = "ru_RU.UTF-8";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # proxy.default = "http://127.0.0.1:10808";
    # proxy.allProxy = "socks5://127.0.0.1:10808";
    # proxy.noProxy = "localhost,127.0.0.0/8,::1";

    # wireless.enable = true;
  };

  # xdg_open should work in steam_run this way… well it’s not 
  # https://github.com/NixOS/nixpkgs/issues/160923
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  time.timeZone = "Europe/Moscow";

  services.desktopManager.plasma6.enable = true;
  # environment.plasma6.excludePackages = with pkgs; [
  #   kdePackages.konsole
  # ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];

    # desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    xkb.layout = "us,ru";
    xkb.variant = "";
  };

  services.displayManager = {
    defaultSession = "plasma";
    sddm.wayland.enable = true;
    # sddm.enable = true;
    autoLogin = {
      enable = false;
      user = "jenya";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Enable CUPS to print documents.
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };

  # scanning
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.hplipWithPlugin
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  services.printing = {
    enable = true;
    drivers = [
      pkgs.foomatic-db
      pkgs.ghostscript
      pkgs.foomatic-filters

      pkgs.gutenprint # — Drivers for many different printers from many different vendors.
      pkgs.gutenprintBin # — Additional, binary-only drivers for some printers.
      pkgs.hplipWithPlugin # — Drivers for HP printers, with the proprietary plugin. Use NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup' to add the printer, regular CUPS UI doesn't seem to work.
      pkgs.postscript-lexmark # — Postscript drivers for Lexmark
      # pkgs.samsung-unified-linux-driver # — Proprietary Samsung Drivers
      # pkgs.splix # — Drivers for printers supporting SPL (Samsung Printer Language).
      # pkgs.brlaser # — Drivers for some Brother printers
      # pkgs.brgenml1lpr #  — Generic drivers for more Brother printers [1]
      # pkgs.brgenml1cupswrapper  # — Generic drivers for more Brother printers [1]
      # pkgs.cnijfilter2 # — Drivers for some Canon Pixma devices (Proprietary driver)

      pkgs.cups-filters
      pkgs.cups-browsed
    ];
  };

  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.jenya = {
      isNormalUser = true;
      description = "jenya";
      extraGroups = [
        "networkmanager"
        "wheel"
        "wireshark"
        "docker"
        "scanner"
        "lp"
      ];
      packages = [ ];
    };
  };

  programs.zsh.enable = true;

  # Чтобы не было ошибок
  programs.dconf.enable = true;

  programs.partition-manager.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # programs.wireshark.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # alacritty

    xdg-utils
    git
    wget
    curl
    chromium
    firefox
    vscode
    wireshark
    pwgen
    keepassxc
    parted
    kdePackages.yakuake
    code-cursor

    home-manager

    steam-run
    lutris

    # Аудио видео проигрыватели
    vlc

    # Диспеер раздеов дисков
    kdePackages.partitionmanager

    # Для KDE (Информация о система)
    aha
    clinfo
    # eglinfo
    # glxinfo # mesa-demos
    vulkan-tools
    wayland-utils

    # Для vivaldi
    kdePackages.kdialog

    blezz-pkgs.discord-krisp-patcher
  ];

  fonts.packages = with pkgs; [
    # nerdfonts
    font-awesome
    # scientifica

    # Шрифты paratype
    paratype-pt-sans
    paratype-pt-mono
    paratype-pt-serif

    # Шрифты terminus
    terminus_font

    # Шрифты noto
    noto-fonts
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # Шрифты windows
    corefonts
    vista-fonts

    # Замена шрифтов Windows
    liberation_ttf

    # Mono
    hack-font
  ];

  # nix helper
  programs.nh.enable = true;
  programs.nh.flake = "/home/jenya/nixos-conf";


  environment.variables.EDITOR = "nvim";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  services.v2raya.enable = false;

  # programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 443 22 ];
  # networking.firewall.allowedUDPPorts = [ ];
  # networking.firewall.enable = true;

  system.stateVersion = "23.05";

  nixpkgs.overlays = [
    (final: prev: {
      prismlauncher-unwrapped = prev.prismlauncher-unwrapped.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (final.fetchpatch {
            url = "https://gist.githubusercontent.com/Blezz-tech/bc9acc9d02e4eb77c4a0b407f589da26/raw/a413cb08d722bda5b91a1d6ace78c9699ce86588/0001-fix-online-account.patch";
            sha256 = "0qygn2jx8iv7ac12bd1wxph3ha1mya4z8i5s3d7rhyzcgv122l5i";
          })
        ];
      });
    })
    (self: super: {
      blezz-pkgs = {
        zapret = pkgs.zapret.overrideAttrs (prev: {
          postInstall = (prev.postInstall or "") + ''
            mkdir -p $out/files/
            cp -r $src/files/fake/ $out/files/
          '';
        });

        discord-krisp-patcher =
          pkgs.writers.writePython3Bin "discord-krisp-patcher"
            {
              libraries = with pkgs.python3Packages; [
                capstone
                pyelftools
              ];
              flakeIgnore = [
                "E501" # line too long (82 > 79 characters)
                "F403" # 'from module import *' used; unable to detect undefined names
                "F405" # name may be undefined, or defined from star imports: module
              ];
            }
            (builtins.readFile ./pkgs/discord-krisp-patcher/main.py);
        # Script get from: https://pastebin.com/raw/8tQDsMVd

        zdyPackages =
          let
            versions = [
              { name = "1_7_2b"; zdy_version = "1.7.2b"; zdy_hash = "sha256-59kG0UA+zUkpL/ZOwjSEpOlGJspgI8bQapxdv/FvzX8="; }
              { name = "1_8_0"; zdy_version = "1.8.0"; zdy_hash = "sha256-GgDxB2GFnQizvY2kiBs7E9lgvxn4KwxRcOZBAeUXCPk="; }
            ];
          in
          builtins.listToAttrs (map
            (v: {
              name = v.name;
              value = pkgs.callPackage ./pkgs/zapret-discord-youtube {
                zdy_version = v.zdy_version;
                zdy_hash = v.zdy_hash;
              };
            })
            versions);
      };
    })
  ];
}

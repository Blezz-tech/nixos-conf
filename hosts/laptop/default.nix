# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma5.enable = true;

    displayManager = {
      sddm.enable = true;
      # defaultSession = "none+xmonad";

      # Autologin
      autoLogin = {
        enable = true;
        user = "jenya";
      };
    };


    # Configure keymap in X11
    layout = "us,ru";
    xkbVariant = "";

  #   windowManager.xmonad = {
  #     # enable = true;
  #     # enableContribAndExtras = true;
  #     # config = builtins.readFile ./xmonad.hs;
  #     extraPackages = haskellPackages: [
  #       haskellPackages.xmonad
  #       haskellPackages.xmonad-contrib
  #       haskellPackages.xmonad-extras
  #     ];
  #   };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenya = {
    isNormalUser = true;
    description = "jenya";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Для работы стима
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Чтобы не было ошибок
  programs.dconf.enable = true;

  programs.partition-manager.enable = true;

  #programs.java.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    home-manager
    google-chrome
    gnumake
    nushell
    pandoc

    # Программирование

    ## Системы сборки
    cmake

    ## R
    #rstudioWrapper

    ## СУБД
    sqlitebrowser

    ## Android
    android-studio

    ## Игровые движки
    godot_4

    ## haskell
    stack
    haskell-language-server
    ghc

    ## PHP
    php

    ## Node JS
    nodejs

    ## Python
    python3

    ## Rust 
    cargo
    rustc
    rustfmt
    rustup
    nixpkgs-fmt

    ## C
    clang

    # Игры
    prismlauncher
    steam
    steam-run
    jdk8
    jdk17
    cataclysm-dda
    cmatrix

    # Диспеер раздеов дисков
    partition-manager

    # Шрифты
    noto-fonts
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    noto-fonts-emoji
    corefonts
    vistafonts
  ];

  environment.variables.EDITOR = "vim";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    noto-fonts-emoji
    corefonts
    vistafonts
  ];

  #nixpkgs.overlays = [
  #  (final: prev: {
  #    yandex-browser = prev.yandex-browser.override {
  #      version = "23.7.1.1148-1";
  #       src = fetchurl {
  #       url = "http://repo.yandex.ru/yandex-browser/deb/pool/main/y/${pname}-beta/${pname}-beta_${version}_amd64.deb";
  #       sha256 = "";
  #      };
  #    }
  #  })
  #];

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
    ports = [ 231 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

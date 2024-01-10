# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config
, pkgs
, ...
}:

{

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "jenya" ];
  };

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;



  networking = {
    hostName = "nixos"; # hostname
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
  };

  # xdg_open should work in steam_run this way… well it’s not 
  # https://github.com/NixOS/nixpkgs/issues/160923
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n = {
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

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    videoDrivers = [ "amdgpu" ];

    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma5.enable = true;

    displayManager = {
      sddm.enable = true;
      # defaultSession = "plasmawayland";

      # Autologin
      autoLogin = {
        enable = true;
        user = "jenya";
      };

      # Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;
    };


    # Configure keymap in X11
    layout = "us,ru";
    xkbVariant = "";
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

  # services.paperless = {
  #   enable = true;
  # };

  services = {
    gitea = {
      settings.server = {
        # PROTOCOL = "https";
        # DOMAIN = "gitea.blezz-tech.ru";
        ROOT_URL = "https://gitea.blezz-tech.ru:3000/";
        
        HTTP_ADDR = "192.168.31.97";
        HTTP_PORT = 3000;
      };
      enable = true;
      lfs.enable = true;
    };


    # gitea-actions-runner.instances = {
    #   "test" = {
    #     token = "";
    #     enable = true;

    #   };
    # };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenya = {
    isNormalUser = true;
    description = "jenya";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    packages = [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Чтобы не было ошибок
  programs.dconf.enable = true;

  programs.partition-manager.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.wireshark.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xdg_utils
    git
    vim
    wget
    curl
    chromium
    firefox
    vscode
    wireshark
    pwgen

    # nix LSP
    nixd
    # qemu

    home-manager

    steam-run
    lutris

    # Аудио видео проигрыватели
    vlc

    # Диспеер раздеов дисков
    partition-manager
  ];

  fonts.packages = with pkgs; [
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
    noto-fonts-emoji

    # Шрифты windows
    corefonts
    vistafonts
  ];

  environment.variables.EDITOR = "vim";

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
    ports = [ 22 231 ];
    settings.PasswordAuthentication = true;
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

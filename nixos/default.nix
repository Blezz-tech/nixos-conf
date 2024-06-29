{ pkgs
, ...
}:
{

  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_default_ttl" = 65;
  # };

  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  nixpkgs.config.permittedInsecurePackages = [ ];


  nix = {
    optimise.automatic = true;

    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    trusted-users = [ "root" "jenya" ];


    gc.automatic = true;
    gc.dates = "daily";
    gc.options = "--delete-older-than 14d";
  };

  imports = [
    ./hardware-configuration.nix
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
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.konsole
  ];

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
      enable = true;
      user = "jenya";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenya = {
    isNormalUser = true;
    description = "jenya";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    packages = [ ];
  };


  # Чтобы не было ошибок
  programs.dconf.enable = true;

  programs.partition-manager.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.wireshark.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty

    xdg_utils
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

    home-manager

    steam-run
    lutris

    # Аудио видео проигрыватели
    vlc

    # Диспеер раздеов дисков
    partition-manager
  ];

  fonts.packages = with pkgs; [
    nerdfonts
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
    noto-fonts-emoji

    # Шрифты windows
    corefonts
    vistafonts

    # Замена шрифтов Windows
    liberation_ttf

    # Mono
    hack-font
  ];

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

  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 443 22 ];
  # networking.firewall.allowedUDPPorts = [ ];
  # networking.firewall.enable = true;

  system.stateVersion = "23.05";
}

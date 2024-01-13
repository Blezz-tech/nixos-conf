{ config
, pkgs
, ...
}:
let
  hostname = "blezz-tech.ru";
in
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow electron for obsidian
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "jenya" ];
  };

  imports = [
    ./hardware-configuration.nix
    ../../share/default.nix
  ];

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

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];

    desktopManager.plasma5.enable = true;
    displayManager = {
      sddm.enable = true;
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

  users.users.nginx.extraGroups = [ "acme" ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "blezz-tech+markus.jenya04@yandex.ru";
    defaults.dnsProvider = "regru";
    defaults.credentialsFile = "/var/lib/secrets/acme/acme.secret";
    # defaults.validMinDays = 60;
    defaults.enableDebugLogs = true;
    defaults.dnsResolver = "194.58.117.15";

    certs.${hostname} = {
      extraDomainNames = [ "*.${hostname}" ];
      group = "nginx";
    };
  };

  services = {

    paperless = {
      enable = true;
      port = 3221;
    };

    gitea = {
      enable = true;
      lfs.enable = true;

      settings.server.HTTP_PORT = 3220;
    };
    
    # kavita = {
    #   enable = true;
    #   port = 3222;
    #   ipAdresses = ["127.0.0.1"];
    #   tokenKeyFile = "/var/lib/secrets/kavita/kavita.secret";
    # };

    nginx = {
      enable = true;
      enableReload = true;

      # statusPage = true;

      serverTokens = false;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts =
        let
          def-cfg = cfg: cfg // {
            forceSSL = true;
            enableACME = false;
            useACMEHost = "${hostname}";
          };
        in
        {
          "gitea.${hostname}" = def-cfg {
            locations."/".proxyPass = "http://localhost:3220";
          };

          "paperless.${hostname}" = def-cfg {
            locations."/".proxyPass = "http://localhost:3221";
          };

          # "kavita.${hostname}" = def-cfg {
          #   locations."/".proxyPass = "http://localhost:3222";
          # };

          "${hostname}" = def-cfg {
            locations."/".root = "/var/lib/blezz-tech.ru";
            locations."/".index = "index.html";
          };

          "*.${hostname}" = def-cfg {
            globalRedirect = hostname;
          };
        };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenya = {
    isNormalUser = true;
    description = "jenya";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    packages = [ ];
  };


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

    nixd
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
    ports = [ 231 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;

  system.stateVersion = "23.05";
}

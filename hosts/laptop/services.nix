{ config
, pkgs
, ...
}:
let
  hostname = "blezz-tech.ru";
in
{

  # users.users.nginx.extraGroups = [ "acme" ];

  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "blezz-tech+markus.jenya04@yandex.ru";
  #   defaults.dnsProvider = "regru";
  #   defaults.credentialsFile = "/var/lib/secrets/acme/acme.secret";
  #   # defaults.validMinDays = 60;
  #   defaults.enableDebugLogs = true;
  #   defaults.dnsResolver = "194.58.117.15";

  #   certs.${hostname} = {
  #     extraDomainNames = [ "*.${hostname}" ];
  #     group = "nginx";
  #   };
  # };

  services = {

    # gitea = {
    #   enable = true;
    #   lfs.enable = true;

    #   settings.server.HTTP_PORT = 3220;
    # };

    # paperless = {
    #   enable = true;
    #   port = 3221;
    # };

    # kavita = {
    #   enable = true;
    #   port = 3222;
    #   ipAdresses = ["127.0.0.1"];
    #   tokenKeyFile = "/var/lib/secrets/kavita/kavita.secret";
    # };

    # photoprism = {
    #   enable = true;
    #   port = 3223;
    #   originalsPath = "${config.services.photoprism.storagePath}/data/photos";
    #   passwordFile = "/var/lib/secrets/photoprism/photoprism.secret";
    # };

    # vaultwarden = {
    #   enable = true;
    #   config = {
    #     ROCKET_ADDRESS = "127.0.0.1";
    #     ROCKET_PORT = 3224;
    #   };
    # };

    nginx = {
      # enable = true;
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
          # "gitea.${hostname}" = def-cfg {
          #   locations."/".proxyPass = "http://localhost:3220";
          # };

          # "paperless.${hostname}" = def-cfg {
          #   locations."/".proxyPass = "http://localhost:3221";
          # };

          # "kavita.${hostname}" = def-cfg {
          #   locations."/".proxyPass = "http://localhost:3222";
          # };

          # "photoprism.${hostname}" = def-cfg {
          #   locations."/".proxyPass = "http://localhost:3223";
          # };

          # "vaultwarden.${hostname}" = def-cfg {
          #   locations."/".proxyPass = "http://localhost:3224";
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
}
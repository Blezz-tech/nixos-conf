{
  imports = [
    ./zapret.nix
  ];

  services.postgresql = {
    enable = true;
  };
}

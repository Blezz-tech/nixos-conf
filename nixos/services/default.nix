{
  imports = [
    ./zapret.nix
  ];

  services.postgresql = {
    enable = false;
  };
}

{ pkgs
, inputs
, ...
}: {
  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;

  #   defaultEditor = true;
  #   plugins = [

  #   ];
  # };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.gruvbox.enable = true;
    plugins.lightline.enable = true;
  };

}

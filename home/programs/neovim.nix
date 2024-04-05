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

    plugins = {
      # lightline.enable = true;
      barbar.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      fzf-lua.enable = true;
      lsp = {
        enable = true;
      };
      # lsp.servers.efm = {
      #   enable = true;
      # };
      # lsp-format = {
      #   enable = true;
      #   lspServersToEnable = [ "efm" ];
      # };
      # efmls-configs.enable = true;
      neo-tree = {
        enable = true;
      };
      telescope.enable = true;
    };
  };

}

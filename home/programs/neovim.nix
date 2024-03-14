{ pkgs
, ...
}: {


  programs.nixvim = {
    enable = true;

    colorschemes.gruv.enable = true;
    plugins.lightline.enable = true;
  };
}

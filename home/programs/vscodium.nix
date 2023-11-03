{ config
, pkgs
, home-manager
, nix-vscode-extensions
, ...
}:

{

  # if use vscode in wayland, uncomment this line
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # userSettings = {
    #   workbench.sideBar.location = "right";
    #   haskell.manageHLS = "PATH";
    #   "[html]" = {
    #     editor.defaultFormatter = "vscode.html-language-features";
    #   };
    #   "[jsonc]" = {
    #     editor.defaultFormatter = "vscode.json-language-features";
    #   };
    #   git.confirmSync = false;
    #   git.enableSmartCommit = true;
    #   "[javascript]" = {
    #     editor.defaultFormatter = "esbenp.prettier-vscode";
    #   };
    #   "[typescript]" = {
    #     editor.defaultFormatter = "vscode.typescript-language-features";
    #   };
    #   "telemetry.telemetryLevel" = "off";
    #   editor = {
    #     renderWhitespace = "all";
    #     fontFamily = "Hack";
    #     fontLigatures = false;
    #     formatOnSave = false;
    #     minimap.enabled = false;
    #   };
    # };

    # userSettings = {
    # "breadcrumbs.enabled" = true;
    # "workbench.fontAliasing" = "antialiased";
    # "files.trimTrailingWhitespace" = true;
    # "workbench.editor.enablePreview" = false;
    # "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    # };
    
    # extensions = with pkgs.vscode-extensions; [
    #   redhat.vscode-xml
    #   esbenp.prettier-vscode
    #   james-yu.latex-workshop
    #   justusadam.language-haskell
    #   haskell.haskell
    #   ms-ceintl.vscode-language-pack-ru
    #   jnoortheen.nix-ide

    #   # kumar-harsh.graphql-for-vscode
    #   # formulahendry.auto-complete-tag
    #   # christian-kohler.npm-intellisense
    #   # yandeu.five-server
    #   # rangav.vscode-thunder-client
    # ];
  };
}

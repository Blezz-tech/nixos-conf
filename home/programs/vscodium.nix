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
    userSettings = {
      workbench.sideBar.location = "right";
      haskell.manageHLS = "PATH";
      editor.minimap.enabled = false;
      "[html]" = {
        editor.defaultFormatter = "vscode.html-language-features";
      };
      "[jsonc]" = {
        editor.defaultFormatter = "vscode.json-language-features";
      };
      git.confirmSync = false;
      git.enableSmartCommit = true;
      "[javascript]" = {
        editor.defaultFormatter = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        editor.defaultFormatter = "vscode.typescript-language-features";
      };
    };
    # userSettings = {
    # "editor.renderWhitespace" = "all";
    # "files.autoSave" = "onFocusChange";
    # "editor.rulers" = [ 80 120 ];
    # "telemetry.enableTelemetry" = false;
    # "telemetry.enableCrashReporter" = false;
    # "editor.tabSize" = 2;
    # "files.exclude" = { "**/node_modules/**" = true; };
    # "editor.formatOnSave" = false;
    # "breadcrumbs.enabled" = true;
    # "editor.useTabStops" = false;
    # "editor.fontFamily" = "JetBrainsMono Nerd Font";
    # "editor.fontSize" = 16;
    # "editor.fontLigatures" = true;
    # "editor.lineHeight" = 20;
    # "workbench.fontAliasing" = "antialiased";
    # "files.trimTrailingWhitespace" = true;
    # "editor.minimap.enabled" = false;
    # "workbench.editor.enablePreview" = false;
    # "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    # };
    extensions = with pkgs.vscode-extensions; [
      redhat.vscode-xml
      esbenp.prettier-vscode
      james-yu.latex-workshop
      justusadam.language-haskell
      haskell.haskell
      ms-ceintl.vscode-language-pack-ru
     # jnoortheen.nix-ide
      # kumar-harsh.graphql-for-vscode
      # formulahendry.auto-complete-tag
      # christian-kohler.npm-intellisense
      # yandeu.five-server
      # rangav.vscode-thunder-client
    ];
  };
}

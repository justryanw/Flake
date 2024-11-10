{ pkgs, lib, config, rootConfig, ... }: {
  options = {
    modules.vscode.enable = lib.mkEnableOption "Enable vscode";
  };

  config = lib.mkIf (config.modules.vscode.enable && rootConfig.modules.graphics.enable) {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        mkhl.direnv
        vscodevim.vim
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        ms-vscode-remote.remote-ssh
        zhuangtongfa.material-theme
      ];

      userSettings = {
        editor = {
          fontFamily = "'Droid Sans Mono', 'monospace', monospace";
          lineNumbers = "relative";
          wordWrap = "on";
          minimap.enabled = false;
          tabSize = 2;
        };

        direnv = {
          restart.automatic = false;
          status.showChangesCount = false;
        };

        terminal.integrated = {
          allowChords = false;
          fontFamily = "DroidSansM Nerd Font";
          sendKeybindingsToShell = true;
        };

        git = {
          autofetch = true;
          repositoryScanMaxDepth = -1;
          enableSmartCommit = true;
        };

        nix = {
          enableLanguageServer = true;
          serverPath = "nixd";
        };

        html.format.wrapLineLength = 0;
        workbench.colorTheme = "One Dark Pro Darker";
        files.autoSave = "afterDelay";
        typescript.updateImportsOnFileMove.enabled = "always";
        explorer.confirmDragAndDrop = false;
        rust-analyzer.lens.enable = false;
      };
    };
  };
}

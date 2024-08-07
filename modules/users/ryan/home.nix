name: { pkgs, lib, config, ... } @ inputs: {
  config = lib.mkIf config.enabledUsers.${name}.enable {
    home-manager.users.${name} = { ... }: {
      work.enable = true;

      home.packages = with pkgs.gnomeExtensions; [
        appindicator
        systemd-manager
        caffeine
        grand-theft-focus
        vitals
      ];

      programs = {
        git = {
          userName = "Ryan Walker";
          userEmail = "ryanjwalker2001@gmail.com";
        };

        vscode = {
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
              serverSettings.nixd.formatting.command = "nixpkgs-fmt";
            };

            remote.SSH.remotePlatform = {
              inspired = "windows";
            };

            html.format.wrapLineLength = 0;
            workbench.colorTheme = "One Dark Pro Darker";
            files.autoSave = "afterDelay";
            typescript.updateImportsOnFileMove.enabled = "always";
            explorer.confirmDragAndDrop = false;
            rust-analyzer.lens.enable = false;
          };
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
          config = builtins.fromTOML ''
            [global]
            hide_env_diff = true
          '';
        };
      };

      dconf.settings = {
        "org/gnome/shell" = {
          # nix eval nixpkgs#gnomeExtensions.<name>.extensionUuid
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "systemd-manager@hardpixel.eu"
            "caffeine@patapon.info"
            "grand-theft-focus@zalckos.github.com"
            "docker@stickman_0x00.com"
            "Vitals@CoreCoding.com"
          ];
        };
      };
    };
  };
}

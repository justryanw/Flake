name: {
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.users.${name}.enable {
    home-manager.users.${name} = {...}: {
      modules = {
        work.enable = lib.mkDefault true;
        vscode.enable = lib.mkDefault true;
      };

      programs = {
        zed-editor = {
          enable = true;
          installRemoteServer = true;
          userSettings = let
            font = "FiraCode Nerd Font Mono";
          in {
            vim_mode = true;
            hard_tabs = true;
            relative_line_numbers = true;
            autosave = "on_focus_change";
            auto_update = false;
            installRemoteServer = true;
            buffer_font_family = font;
            buffer_font_size = 16;
            ui_font_family = font;
            ui_font_size = 18;
            terminal.font_family = font;
            tabs = {
              file_icons = true;
              git_status = true;
            };
            theme = {
              dark = "One Dark";
              light = "One Light";
            };
            extensions = ["nix"];
            languages = {
              Nix = {
                language_servers = [
                  "nixd"
                  "nil"
                ];
                formatter.external.command = "${pkgs.alejandra}/bin/alejandra";
              };
              TypeScript.prettier.allowed = false;
            };
            language_models.ollama = {
              api_url = "http://127.0.0.1:11434";
              available_models = [
                {
                  name = "deepseek-coder-v2:16b";
                  display_name = "Deepseek Coder v2 16B";
                  max_tokens = 6144;
                }
              ];
            };
            assistant = {
              version = "2";
              default_model = {
                provider = "ollama";
                model = "deepseek-coder-v2:16b";
              };
            };
          };
        };

        git = {
          userName = "Ryan Walker";
          userEmail = "ryanjwalker2001@gmail.com";
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
          config = builtins.fromTOML ''
            [global]
            hide_env_diff = true
          '';
        };

        yazi = {
          enable = true;
        };
      };

      home.packages = with pkgs.gnomeExtensions; [
        appindicator
        systemd-manager
        caffeine
        grand-theft-focus
        vitals
      ];

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

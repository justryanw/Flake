name: {
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.users.${name}.enable {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "bak";
      extraSpecialArgs = {
        rootConfig = config;
      };

      users.${name} = {...}: {
        imports = [../../home];

        config = {
          home.stateVersion = config.system.stateVersion;

          programs = {
            starship.enable = true;

            zsh = {
              enable = true;
              history.size = 1000;
              autosuggestion.enable = true;
              syntaxHighlighting.enable = true;
              shellAliases = {
                la = "ls -A";
                sys = "sudo systemctl";
                usr = "systemctl --user";
                disks = "df -h -x tmpfs -x efivarfs -x devtmpfs";
                bios = "systemctl reboot --firmware-setup";
                self = "yggdrasilctl getself";
                peers = "yggdrasilctl getpeers";
                follow = "journalctl -fu";
              };
              initContent = ''
                bindkey '^E' autosuggest-accept
              '';
            };

            carapace.enable = true;

            git = {
              enable = true;
              extraConfig = {
                pull.rebase = true;
                rebase.autoStash = true;
                submodule.recurse = true;
                push.recurseSubmodules = "on-demand";
              };
              aliases = {
                a = "!git add -A";
                ac = "!git add -A && git commit";
                acm = "!git add -A && git commit -m";
              };
            };

            ssh = {
              enable = true;
              matchBlocks = {
                github = {
                  user = "git";
                  hostname = "github.com";
                };

                nixbuild.hostname = "eu.nixbuild.net";
              };
            };

            helix = {
              enable = true;
              package = pkgs.evil-helix;
              defaultEditor = true;
              settings = {
                theme = "onedark";
                editor = {
                  line-number = "relative";
                  cursor-shape = {
                    insert = "bar";
                    normal = "block";
                    select = "underline";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

{ state, pkgs, ... }: {
  home.stateVersion = state;

  programs = {

    zsh = {
      enable = true;
      history.size = 1000;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        la = "ls -A";
        bios = "systemctl reboot --firmware-setup";
        self = "yggdrasilctl getself";
        peers = "yggdrasilctl getpeers";
      };
    };

    starship = {
      enable = true;
    };

    helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor = {
          line-number = "relative";
          cursor-shape.insert = "bar";
        };
      };
      languages = {
        language-server.nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        language = [{
          name = "nix";
          auto-format = true;
          language-servers = [ "nixd" ];
          formatter.command = "nixpkgs-fmt";
        }];
      };
    };

    git = {
      enable = true;
      userName = "Ryan Walker";
      userEmail = "ryanjwalker2001@gmail.com";
      extraConfig = {
        pull.rebase = false;
      };
      aliases = {
        acm = "!git add -A && git commit -m";
      };
    };

  };
}

{ state, pkgs, ... }: {
  home.stateVersion = state;

  programs = {

    zsh = {
      enable = true;
      history.size = 1000;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        shell = "nix develop -c $SHELL";
        la = "ls -A";
        bios = "systemctl reboot --firmware-setup";
        self = "yggdrasilctl getself";
        peers = "yggdrasilctl getpeers";
        list = "nix-store -q --references /var/run/current-system/sw | cut -d'-' -f2-";
        listAll = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
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

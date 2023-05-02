{ pkgs, ... }: {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    firefox
    monero-gui
    teams
    rnix-lsp
    fragments
    ckan
  ];

  programs = {

    zsh = {
      enable = true;
      shellAliases = {
        e = "cd ~/Flake && hx flake.nix";
        sys = "sudo systemctl";
        logs = "sudo journalctl -fu";
        la = "ls -A";
      };
      history.size = 1000;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
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
          cursor-shape = {
            insert = "bar";
          };
        };
      };
      languages = [
        {
          name = "nix";
          language-server = {
            command = "nil";
          };
          formatter = {
            command = "nixpkgs-fmt";
          };
        }
      ];
    };

    git = {
      enable = true;
      userName = "Ryan Walker";
      userEmail = "ryanjwalker2001@gmail.com";
      aliases = {
        acm = "!git add -A && git commit -m";
      };
    };

  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

}

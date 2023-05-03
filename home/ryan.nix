{ pkgs, ... }: {

  home.packages = with pkgs; [
    firefox
    monero-gui
    teams
    fragments
  ];

  programs = {

    zsh = {
      shellAliases = {
        e = "cd ~/Flake && hx flake.nix";
        sys = "sudo systemctl";
        logs = "sudo journalctl -fu";
        la = "ls -A";
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

  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

}

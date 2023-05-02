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
        e = "hx ~/Flake/flake.nix";
        switch = "sudo nixos-rebuild switch --flake .#ryan";
        sys = "sudo systemctl";
        logs = "sudo journalctl -fu";
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
    };

    git = {
      enable = true;
      userName = "Ryan Walker";
      userEmail = "ryanjwalker2001@gmail.com";
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

{ pkgs, ... }: {
  home.stateVersion = "22.11";
  programs = {

    zsh = {
      enable = true;
      shellAliases = {
        sys = "systemctl";
       logs = "journalctl -fu";
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
    };

  };
}

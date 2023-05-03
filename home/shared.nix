{ state, ... }: {
  home.stateVersion = state;

  programs = {

    zsh = {
      enable = true;
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
          cursor-shape.insert = "bar";
        };
      };
      languages = [{
        name = "nix";
        language-server.command = "nil";
        formatter.command = "nixpkgs-fmt";
      }];
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
}

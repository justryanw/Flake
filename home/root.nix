{ pkgs, ... }: {
  home.stateVersion = "22.11";
  programs = {
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

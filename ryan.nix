{ configs, pkgs, ... }: {
  home-manager.users.ryan = { pkgs, ... }: {
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
      firefox
      monero-gui
      teams
      rnix-lsp
    ];

    programs.bash.enable = true;
    
    programs.helix = {
      enable = true;
      settings = {
        theme = "onedark";
      };
    };

    programs.git = {
      enable = true;
      userName = "Ryan Walker";
      userEmail = "ryanjwalker2001@gmail.com";
    };

    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

  };
}

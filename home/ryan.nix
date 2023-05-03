{ pkgs, ... }: {

  home.packages = with pkgs; [
    firefox
    monero-gui
    teams
    fragments
  ];

  programs = {

    zsh.shellAliases = {
      e = "cd ~/Flake && hx flake.nix";
      sys = "sudo systemctl";
      logs = "sudo journalctl -fu";
      la = "ls -A";
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

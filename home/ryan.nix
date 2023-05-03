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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/shell".favourite-apps = [ ];
    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences".num-workspaces = 3;
    "org/gnome/desktop/peripherals/mouse" = {
      speed = 0.5;
      accel-profile = "flat";
      natural-scroll = false;
    };
  };
}

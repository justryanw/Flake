{ pkgs, ... }: {

  home.packages = with pkgs; [
    firefox
    monero-gui
    teams
    fragments
    whatip
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
    "org/gnome/desktop/wm/keybindings" = {
      toggle-fullscreen = [ "<Alt>f" ];
      minimize = [ "<Alt>s" ];
      maximize = [ "<Alt>w" ];
      begin-move = [ "<Alt>e" ];
      begin-resize = [ "<Alt>r" ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Alt>a" ];
      toggle-tiled-right = [ "<Alt>d" ];
    };
    "org/gtk/settings/file-chooser".clock-format = "12h";
  };
}

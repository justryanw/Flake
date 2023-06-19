{ pkgs, ... }: {

  home.packages = (with pkgs; [
    firefox
    monero-gui
    teams
    fragments
    whatip
    gnome.gnome-tweaks
    celluloid
    libreoffice
    hunspell
    hunspellDicts.en_GB-large
    evince
    discord
    signal-desktop
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
  ]);

  programs = {

    zsh = {
      shellAliases = {
        e = "cd ~/Flake && hx flake.nix";
        sys = "sudo systemctl";
        usr = "systemctl --user";
        logs = "sudo journalctl -fu";
        la = "ls -A";
        u = "cd ~/Flake && nix flake update && s";
      };
      envExtra = ''eval "$(direnv hook zsh)"'';
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        mkhl.direnv
        vscodevim.vim
        rust-lang.rust-analyzer
        ms-vscode-remote.remote-ssh
        zhuangtongfa.material-theme
      ];
      userSettings = {
        "terminal.integrated.allowChords" = false;
        "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace";
        "terminal.integrated.fontFamily" = "DroidSansM Nerd Font";
        "workbench.colorTheme" = "One Dark Pro Darker";
        "files.autoSave" = "afterDelay";
        "git.enableSmartCommit" = true;
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "git.autofetch" = true;
        "explorer.confirmDragAndDrop" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [
                "nixpkgs-fmt"
              ];
            };
          };
        };
        "rust-analyzer.lens.enable" = false;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
      clock-show-weekday = true;
    };
    "org/gnome/desktop/calendar".show-weekdate = true;
    "org/gnome/shell" = {
      favourite-apps = [ ];
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
      disabled-extensions = [ ];
    };
    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
      dynamic-workspaces = false;
      attach-modal-dialogs = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 3;
      button-layout = "appmenu:minimize,maximize,close";
    };
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
    "org/gnome/desktop/input-sources".xkb-options = ["caps:escape"];
  };
}

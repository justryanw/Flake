{ pkgs, ... }: {

  home.packages = (with pkgs; [
    firefox
    monero-gui
    # teams
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
    goverlay
    gnome-frog
    gnome-extension-manager
    pdfarranger
    gtop
    piper
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    systemd-manager
    caffeine
    coverflow-alt-tab
    # tophat
    grand-theft-focus
  ]);

  programs = {

    mangohud = {
      enable = true;
      enableSessionWide = false;
    };

    zsh = {
      shellAliases = {
        e = "cd ~/Flake && hx flake.nix";
        sys = "sudo systemctl";
        usr = "systemctl --user";
        logs = "sudo journalctl -fu";
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
        tamasfe.even-better-toml
        ms-vscode-remote.remote-ssh
        zhuangtongfa.material-theme
      ];

      userSettings = {
        "direnv.restart.automatic" = false;
        "direnv.status.showChangesCount" = false;
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
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [
                "nixpkgs-fmt"
              ];
            };
          };
        };
        "rust-analyzer.lens.enable" = false;
        "terminal.integrated.sendKeybindingsToShell" = true;
        "remote.SSH.remotePlatform" = {
          "inspired" = "windows";
        };
        "git.repositoryScanMaxDepth" = -1;
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
    "org/gnome/shell" = {
      favourite-apps = [ ];
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "systemd-manager@hardpixel.eu"
        "caffeine@patapon.info"
        "CoverflowAltTab@palatis.blogspot.com"
        # "tophat@fflewddur.github.io"
        "grand-theft-focus@zalckos.github.com"
      ];
      disabled-extensions = [ ];
    };
    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
      dynamic-workspaces = false;
      attach-modal-dialogs = true;
      edge-tiling = true;
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
      toggle-fullscreen = [ "<Super>f" ];
      minimize = [ "<Super>s" ];
      maximize = [ "<Super>w" ];
      begin-move = [ "<Super>e" ];
      begin-resize = [ "<Super>r" ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Super>a" ];
      toggle-tiled-right = [ "<Super>d" ];
    };
    "org/gnome/shell/keybindings" = {
      toggle-application-view = [];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      mic-mute = [ "<Super>AudioMute" ];
    };
    "org/gnome/desktop/background" = {
      picture-uri = ''file://${pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath}'';
      picture-uri-dark = ''file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'';
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = false;
    };
    "org/gnome/desktop/calendar".show-weekdate = true;
    "org/gtk/settings/file-chooser".clock-format = "12h";
    "org/gnome/desktop/input-sources".xkb-options = [ "caps:escape" ];
    "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
  };
}

{ pkgs, ... }: {

  home.packages = (with pkgs; [
    firefox
    monero-gui
    teams-for-linux
    fragments
    whatip
    gnome-tweaks
    celluloid
    libreoffice
    hunspell
    hunspellDicts.en_GB-large
    evince
    vesktop
    signal-desktop
    gnome-frog
    gnome-extension-manager
    pdfarranger
    gtop
    piper
    zed-editor
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    systemd-manager
    caffeine
    # coverflow-alt-tab
    # tophat
    grand-theft-focus
    vitals
  ]);

  programs = {

    mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        fps_limit = 120;
        preset = 2;
      };
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
        editor = {
          fontFamily = "'Droid Sans Mono', 'monospace', monospace";
          lineNumbers = "relative";
          wordWrap = "on";
          minimap.enabled = false;
          tabSize = 2;
        };

        direnv = {
          restart.automatic = false;
          status.showChangesCount = false;
        };

        terminal.integrated = {
          allowChords = false;
          fontFamily = "DroidSansM Nerd Font";
          sendKeybindingsToShell = true;
        };

        git = {
          autofetch = true;
          repositoryScanMaxDepth = -1;
          enableSmartCommit = true;
        };

        nix = {
          enableLanguageServer = true;
          serverPath = "${pkgs.nixd}/bin/nixd";
          serverSettings.nixd.formatting.command = "nixpkgs-fmt";
        };

        remote.SSH.remotePlatform = {
          inspired = "windows";
        };

        html.format.wrapLineLength = 0;
        workbench.colorTheme = "One Dark Pro Darker";
        files.autoSave = "afterDelay";
        typescript.updateImportsOnFileMove.enabled = "always";
        explorer.confirmDragAndDrop = false;
        rust-analyzer.lens.enable = false;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = builtins.fromTOML ''
        [global]
        hide_env_diff = true
      '';
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
      # nix eval nixpkgs#gnomeExtensions.<name>.extensionUuid
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "systemd-manager@hardpixel.eu"
        "caffeine@patapon.info"
        # "CoverflowAltTab@palatis.blogspot.com"
        # "tophat@fflewddur.github.io"
        "grand-theft-focus@zalckos.github.com"
        "docker@stickman_0x00.com"
        "Vitals@CoreCoding.com"
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
      toggle-application-view = [ ];
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


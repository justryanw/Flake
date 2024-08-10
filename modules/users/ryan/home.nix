name: { pkgs, lib, config, ... } @ inputs: {
  config = lib.mkIf config.modules.users.${name}.enable {
    home-manager.users.${name} = { ... }: {
      modules = {
        work.enable = lib.mkDefault true;
        vscode.enable = lib.mkDefault true;
      };

      programs = {
        git = {
          userName = "Ryan Walker";
          userEmail = "ryanjwalker2001@gmail.com";
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

      home.packages = with pkgs.gnomeExtensions; [
        appindicator
        systemd-manager
        caffeine
        grand-theft-focus
        vitals
      ];

      dconf.settings = {
        "org/gnome/shell" = {
          # nix eval nixpkgs#gnomeExtensions.<name>.extensionUuid
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "systemd-manager@hardpixel.eu"
            "caffeine@patapon.info"
            "grand-theft-focus@zalckos.github.com"
            "docker@stickman_0x00.com"
            "Vitals@CoreCoding.com"
          ];
        };
      };
    };
  };
}

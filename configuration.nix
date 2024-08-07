{ pkgs, ... } @ inputs: {
  imports = [ ./modules ];

  config = {
    boot = {
      initrd.kernelModules = [ "amdgpu" ];
      plymouth.enable = true;
    };
    
    bootloader.grub.enable = true;

    nix.settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    services = {
      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
        displayManager.gdm = {
          enable = true;
          autoSuspend = false;
        };
        videoDrivers = [ "amdgpu" ];
      };
    };

    programs = {
      zsh.enable = true;

      nh.enable = true;

      nix-ld = {
        enable = true;
        package = pkgs.nix-ld-rs;
      };

      steam = {
        enable = true;
        gamescopeSession.enable = true;
        package = pkgs.steam.override {
          extraEnv = {
            MANGOHUD = true;
          };
        };
      };

      gamemode.enable = true;
    };

    hardware.pulseaudio.enable = true;

    environment = {
      pathsToLink = [ "/share/zsh" ];

      systemPackages = with pkgs; [
        nixd
        nixpkgs-fmt
        git
      ];
    };
  };
}

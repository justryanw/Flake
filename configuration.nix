{ pkgs, lib, ... } @ inputs: {
  imports = [ ./modules ];

  config = {
    modules = {
      grub.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault true;
      gnome.enable = lib.mkDefault true;
    };

    nix.settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs.config.allowUnfree = true;

    security = {
      sudo.wheelNeedsPassword = false;
    };

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    programs = {
      zsh.enable = true;

      nh.enable = true;

      nix-ld = {
        enable = true;
        package = pkgs.nix-ld-rs;
      };
    };

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      openFirewall = false;
    };

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

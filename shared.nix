{ pkgs, state, ... }: {
  system.stateVersion = state;

  time.timeZone = "Europe/London";
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      xkbVariant = "";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    openssh.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.zsh.enable = true;
  programs.steam.enable = true;

  users.defaultUserShell = pkgs.zsh;

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];

    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      epiphany
    ]) ++ (with pkgs.gnome; [
      totem
      cheese
      yelp
    ]);

    systemPackages = with pkgs; [
      tldr
      nil
      nixpkgs-fmt
    ];
  };

  networking = {
    hosts = {
      "192.168.0.5" = [ "work" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" ];
}

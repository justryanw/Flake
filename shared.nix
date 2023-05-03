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

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  boot = {
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
        fontSize = 24;
        extraEntries = ''
          menuentry 'System setup' $menuentry_id_option 'uefi-firmware' {
            fwsetup
          }
        '';
      };

    };


    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
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

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.ryan = {
      isNormalUser = true;
      description = "Ryan";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    dconf.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];

    systemPackages = (with pkgs; [
      tldr
      nil
      nixpkgs-fmt
    ]) ++ (with pkgs.gnomeExtensions; [
      appindicator
    ]);

    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      epiphany
    ]) ++ (with pkgs.gnome; [
      totem
      cheese
      yelp
    ]);
  };

  networking = {
    hosts = {
      "192.168.0.5" = [ "work" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" ];
}

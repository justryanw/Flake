{ pkgs, ... } @ inputs:
let
  users = [ "ryan" "helen" ];
in
{
  imports = [
    ./hosts/desktop/hardware-configuration.nix
    ./users/ryan
    ./users/helen
  ];

  boot = {
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        extraEntries = ''
          menuentry 'System setup' $menuentry_id_option 'uefi-firmware' {
            fwsetup
          }
        '';
      };
    };
  };

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
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      videoDrivers = [ "amdgpu" ];
    };
  };

  programs = {
    zsh.enable = true;

    nh = {
      enable = true;
      flake = "/home/ryan/new-flake";
    };

    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;
  };

  hardware.pulseaudio.enable = true;

  # users.users.${user} = import ./users/ryan inputs;
  #   packages = with pkgs; [
  #     vscode
  #     bitwarden-desktop
  #     vesktop
  #   ];
  # };

  environment = {
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      nixd
      nixpkgs-fmt
      git
    ];
  };

  networking.hostName = "desktop";

  system.stateVersion = "23.05";
}

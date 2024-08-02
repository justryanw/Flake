{ config, pkgs, ... }:
let
  user = "ryan";
in
{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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
      };
  };

  programs = {
    zsh.enable = true;
    nh.enable = true;

    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };

  hardware.pulseaudio.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      vscode
    ];
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    
    systemPackages = with pkgs; [
      nixd
      nixpkgs-fmt
      git
    ];
  };

  system.stateVersion = "23.05";
}

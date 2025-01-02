{ ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  hardware.flirc.enable = true;

  networking.hostName = "laptop";
  system.stateVersion = "22.11";

  services.xserver.displayManager.gdm.enable = false;

  jovian.steam = {
    enable = true; 
    autoStart = true;
    desktopSession = "gnome";
    user = "ryan";
  };

}

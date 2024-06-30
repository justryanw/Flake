{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  networking = {
    hostName = "Laptop";
    
    networkmanager.unmanaged = [ "wlp3s0f3u1" ];
  };

  services.fwupd.enable = true;
}

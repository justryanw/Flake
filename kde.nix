{ configs, pkgs, ... }:

{
  services.xserver = {
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    unzip
  ];
}

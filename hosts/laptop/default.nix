{...}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    steamos.enable = false;
    hyprland.enable = false;
    nixbuild.enable = true;
    sql.enable = true;
  };

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  hardware.flirc.enable = true;

  networking.hostName = "laptop";
  system.stateVersion = "22.11";
}

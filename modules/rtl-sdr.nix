{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gqrx
    sdrpp
  ];
  hardware.rtl-sdr.enable = true;
  users.users.ryan.extraGroups = [ "plugdev" ];
}

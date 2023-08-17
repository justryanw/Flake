{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    rtl-sdr
    gqrx
  ];
  hardware.rtl-sdr.enable = true;
  users.users.ryan.extraGroups = [ "plugdev" ];
}

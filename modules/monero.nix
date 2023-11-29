{ pkgs, ... }: {
  systemd.services."monero".wantedBy = pkgs.lib.mkForce [ ];

  services.monero = {
    enable = true;
  };
}

{ pkgs, ... }: {
  systemd.services."xmrig".wantedBy = pkgs.lib.mkForce [ ];
  
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = true;
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "pool.hashvault.pro:443";
          user = "84jLA5hxrGkNrj7kLpZt519MCWwPyMj8oBt9ikTAqoZvG8Qcd3PFGmkZNDPDT9jk7FZ39VzNMgqzFXLHEKvs9pcF6L8DaTm";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}

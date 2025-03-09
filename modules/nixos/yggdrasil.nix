{...}: {
  config = {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      group = "wheel";
      openMulticastPort = true;
      # yggdrasil -genconf
      settings = {
        Peers = [
          "tcp://62.210.85.80:39565"
        ];
        MulticastInterfaces = [
          {
            Regex = ".*";
            Beacon = true;
            Listen = true;
            Port = 9001;
            Priority = 0;
          }
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [9001];
  };
}

{ ... }: {
  options = {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      group = "wheel";
      openMulticastPort = true;
      settings = {
        Peers = [
          "tls://185.175.90.87:43006"
        ];
        Listen = [
          "tls://[::]:0"
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
  };
}

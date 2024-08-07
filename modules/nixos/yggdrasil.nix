{ ... }: {
  config = {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      group = "wheel";
      openMulticastPort = true;
      settings = {
        Peers = [
          "tcp://62.210.85.80:39565"
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

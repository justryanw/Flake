{ ... }: {
  config = {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      group = "wheel";
      openMulticastPort = true;
      settings = {
        Peers = [
          "tcp://[2001:470:1f13:e56::64]:39565"
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

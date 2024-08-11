{ lib, config, ... }: {
  options = {
    modules.network = {
      hosts = lib.mkOption {
        default = {
          desktop = { ip = "202:9cf8:d9b1:83e5:f832:c74e:8fb7:e6c9"; isV4 = false; };
          laptop = { ip = "202:8699:42dd:e354:50c5:5a7e:610b:1a18"; isV4 = false; };
          server = { ip = "200:2cf:8be6:89d7:60a7:b022:7cf0:97a9"; isV4 = false; };
          work = { ip = "200:d13b:15e2:865:7c39:ad3f:fff6:cbbd"; isV4 = false; };
          vm = { ip = "200:5ec2:56e1:400a:a0e6:3266:d737:d89d"; isV4 = false; };
          kevin = { ip = "200:79ec:fa57:9588:9683:775e:d0ad:c6b9"; isV4 = false; };
          pavilion = { ip = "200:6e2:97ec:3a8a:eb8a:174e:e4dc:7ca1"; isV4 = false; };
          phone = { ip = "201:e7ad:b13b:b71a:9ef2:123e:1e86:ffe0"; isV4 = false; };
          kev-tv = { ip = "201:e145:88cf:f359:a185:19a7:9772:94a"; isV4 = false; };
          helen-phone = { ip = "201:f5ff:565:4fef:6597:9c51:654e:f08a"; isV4 = false; };
          tvbox = { ip = "201:1116:41e5:2a9d:23fe:c842:5a84:5f7c"; isV4 = false; };
          inspired = { ip = "192.168.0.198"; isV4 = true; };
        };
      };

      allowedConnections = lib.mkOption {
        default = (lib.mapAttrsToList (host: { isV4, ... }: { inherit host isV4; }) config.modules.network.hosts) ++
          [{ host = "192.168.0.0/24"; isV4 = true; }];
      };
    };
  };

  config =
    let
      makeIptablesRule = { host, isV4 }: "ip${if !isV4 then "6" else ""}tables -A nixos-fw -s ${host} -j nixos-fw-accept";
      makeIptablesStopRule = { host, isV4 }: "ip${if !isV4 then "6" else ""}tables -D nixos-fw -s ${host} -j nixos-fw-accept || true";

      iptablesRules = map makeIptablesRule config.modules.network.allowedConnections;
      iptalbesStopRules = map makeIptablesStopRule config.modules.network.allowedConnections;
    in
    {
      networking = {
        hosts = lib.mapAttrs' (name: { ip, ... }: lib.nameValuePair ip [ name ]) config.modules.network.hosts;

        firewall = {
          extraCommands = lib.concatStringsSep "\n" iptablesRules;
          extraStopCommands = lib.concatStringsSep "\n" iptalbesStopRules;
        };
      };
    };
}

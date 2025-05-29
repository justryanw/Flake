{
  lib,
  config,
  ...
}: {
  options = {
    modules.nixbuild.enable = lib.mkEnableOption "Add nixbuild as a builder";
  };

  config = lib.mkIf config.modules.nixbuild.enable {
    nix = {
      settings = {
        builders-use-substitutes = true;
        substituters = ["ssh://eu.nixbuild.net"];
        trusted-public-keys = ["nixbuild.net/ACT8PT-1:xsXpIjcF8wW2pTTAaNYZzfDNcYZkG7ICcY+/o5tNCGE="];
      };

      distributedBuilds = true;
      buildMachines = [
        {
          hostName = "eu.nixbuild.net";
          system = "x86_64-linux";
          maxJobs = 100;
          protocol = "ssh-ng";
          sshUser = "ryan";
          sshKey = "/home/ryan/.ssh/id_ed25519";
          supportedFeatures = [
            "benchmark"
            "big-parallel"
          ];
        }
      ];
    };
  };
}

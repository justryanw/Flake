{
  lib,
  config,
  ...
}: {
  options = {
    modules.nixbuild.enable = lib.mkEnableOption "Add nixbuild as a builder";
  };

  config = lib.mkIf config.modules.nixbuild.enable {
    nix.buildMachines = [
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
}

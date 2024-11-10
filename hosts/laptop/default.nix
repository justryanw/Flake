{ ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  hardware.flirc.enable = true;

  networking.hostName = "laptop";
  system.stateVersion = "22.11";

  nix = {
    buildMachines = [
      {
        hostName = "server";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshUser = "ryan";
        sshKey = "/home/ryan/.ssh/id_ed25519";
        maxJobs = 6;
        speedFactor = 2;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [ ];
      }
      {
        hostName = "desktop";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshUser = "ryan";
        sshKey = "/home/ryan/.ssh/id_ed25519";
        maxJobs = 8;
        speedFactor = 2;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [ ];
      }
    ];
    distributedBuilds = true;
    settings = {
      builders-use-substitutes = true;
    };
  };
}

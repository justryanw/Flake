{ lib, config, ... }: {
  options = {
    modules.graphics.enable = lib.mkEnableOption "Enable graphics and sound support";
  };

  config = lib.mkIf config.modules.graphics.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];

    services = {
      xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
      };
    };

    hardware.pulseaudio.enable = true;
  };
}

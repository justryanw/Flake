{ lib, config, ... }:
{
  options = {
    modules.amd.enable = lib.mkEnableOption "Enable AMD graphics drivers";
  };

  config = lib.mkIf config.modules.amd.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}

{ lib, config, ... }:
{
  options.modules.disko = {
    enable = lib.mkEnableOption "Enable disko";
  };

  config = lib.mkIf config.modules.disko.enable {
    disko.devices.disk.${config.networking.hostName} = {
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # MBR = {
          #   type = "EF02";
          #   size = "1M";
          #   priority = 1;
          # };
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}

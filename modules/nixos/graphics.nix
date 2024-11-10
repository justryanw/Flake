{ lib, config, ... }:
{
  options = {
    modules.graphics.enable = lib.mkEnableOption "Enable graphics and sound support";
  };

  config = lib.mkIf config.modules.graphics.enable {
    security.rtkit.enable = true;

    hardware.pulseaudio.enable = false;

    services = {
      xserver = {
        enable = true;
        xkb.layout = "gb";
      };

      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };
    };
  };
}

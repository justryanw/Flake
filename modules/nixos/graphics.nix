{ lib, config, ... }: {
  options = {
    modules.graphics.enable = lib.mkEnableOption "Enable graphics and sound support";
  };

  config = lib.mkIf config.modules.graphics.enable {
    services.xserver = {
      enable = true;
      xkb.layout = "gb";
    };

    hardware.pulseaudio.enable = true;
  };
}

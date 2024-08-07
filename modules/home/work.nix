{ pkgs, lib, config, ... }: {
  options = {
    work.enable = lib.mkEnableOption "Enable work software";
  };

  config = lib.mkIf config.work.enable {
    home.packages = with pkgs; [
      teams-for-linux
    ];
  };
}
{ pkgs, lib, config, rootConfig, ... }: {
  options = {
    work.enable = lib.mkEnableOption "Enable work software";
  };

  config = lib.mkMerge [
    (lib.mkIf config.work.enable {
      home.packages = with pkgs; [
        teams-for-linux
        remmina
      ];
    })
    (lib.mkIf (config.work.enable && rootConfig.modules.gnome.enable) {
      home.packages = with pkgs.gnomeExtensions; [ remmina-search-provider ];

      dconf.settings."org/gnome/shell".enabled-extensions = [ "remmina-search-provider@alexmurray.github.com" ];

      programs.vscode.userSettings.remote.SSH.remotePlatform.inspired = "windows";
    })
  ];
}

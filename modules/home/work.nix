{
  pkgs,
  lib,
  config,
  rootConfig,
  ...
}:
{
  options = {
    modules.work.enable = lib.mkEnableOption "Enable work software";
  };

  config = lib.mkMerge [
    (lib.mkIf config.modules.work.enable {
      programs.ssh.matchBlocks = {
        inspired = {
          user = "ryan.walker";
        };

        wsl = {
          hostname = "localhost";
          proxyJump = "inspired";
          port = 2224;
        };

        marketing = {
          user = "dev";
          hostname = "gamepreview.inseinc.com";
          identityFile = [ "/home/ryan/.ssh/marketing/id_rsa" ];
        };

        gli = {
          user = "gds";
          hostname = "ftp.ingg.com";
        };
      };
    })
    (lib.mkIf (config.modules.work.enable && rootConfig.modules.gnome.enable) {

      home.packages =
        (with pkgs; [
          teams-for-linux
          remmina
        ])
        ++ (with pkgs.gnomeExtensions; [
          remmina-search-provider
        ]);

      dconf.settings."org/gnome/shell".enabled-extensions = [
        "remmina-search-provider@alexmurray.github.com"
      ];

      programs.vscode.userSettings.remote.SSH.remotePlatform.inspired = "windows";
    })
  ];
}

name: {
  pkgs,
  lib,
  config,
  ...
}: let
  grayjay-app = pkgs.callPackage ../../../pkgs/grayjay.nix {};
in {
  imports = [(import ./home.nix name)];

  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      extraGroups = ["wheel"];
      initialHashedPassword = lib.mkDefault "$y$j9T$/0D7TzdJ47wVaY77j8gnJ.$RKHvm/DQTTD8xCdx1ZRhhj9fMuiP5kocHXRmwBBPPR1";

      packages = lib.mkIf config.modules.graphics.enable [
        grayjay-app
      ];
    };

    services.syncthing = {
      enable = true;
      user = name;
      dataDir = "/home/${name}";
      settings = {
        options = {
          localAnnounceEnabled = true;
          relaysEnabled = true;
          urAccepted = -1;
        };
        devices = {
          ODeck.id = "D32ZTUQ-KM3YQGX-GJPBUXA-U3XJSCR-7ZQB6YL-O2Z2HT6-Q4T5ZU2-CSQ3DQF";
        };
        folders = {
          "/home/ryan/.local/share/Steam/steamapps/common/7 Days To Die/Mods" = {
            label = "7 Days Mods";
            id = "wsrhh-yywd5";
            devices = ["ODeck"];
          };
          "/home/ryan/.local/share/Steam/steamapps/compatdata/251570/pfx/drive_c/users/steamuser/AppData/Roaming/7DaysToDie/Saves" = {
            label = "7 Days Saves";
            id = "6kc7o-3bqpp";
            devices = ["ODeck"];
          };
        };
      };
    };
  };
}

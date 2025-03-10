{
  pkgs,
  lib,
  rootConfig,
  ...
}: {
  config = lib.mkIf rootConfig.modules.gnome.enable {
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        clock-show-weekday = true;
      };
      "org/gnome/shell" = {
        favourite-apps = [];
        disable-user-extensions = false;
        disabled-extensions = [];
      };
      "org/gnome/mutter" = {
        workspaces-only-on-primary = true;
        dynamic-workspaces = false;
        attach-modal-dialogs = true;
        edge-tiling = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 3;
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/desktop/peripherals/mouse" = {
        speed = 0.5;
        accel-profile = "flat";
        natural-scroll = false;
      };
      "org/gnome/desktop/wm/keybindings" = {
        toggle-fullscreen = ["<Super>f"];
        minimize = ["<Super>s"];
        maximize = ["<Super>w"];
        begin-move = ["<Super>e"];
        begin-resize = ["<Super>r"];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = ["<Super>a"];
        toggle-tiled-right = ["<Super>d"];
      };
      "org/gnome/shell/keybindings" = {
        toggle-application-view = [];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        mic-mute = ["<Super>AudioMute"];
      };
      "org/gnome/desktop/background" = {
        picture-uri = ''file://${pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath}'';
        picture-uri-dark = ''file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'';
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        natural-scroll = false;
      };
      "org/gnome/desktop/calendar".show-weekdate = true;
      "org/gtk/settings/file-chooser".clock-format = "12h";
      "org/gnome/desktop/input-sources" = {
        xkb-options = ["caps:escape"];
        sources = [
          (lib.hm.gvariant.mkTuple [
            "xkb"
            "gb"
          ])
        ];
      };
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
    };
  };
}

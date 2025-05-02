{
  lib,
  rootConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf rootConfig.modules.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        monitor = [
          "DP-3, 3440x1440@120, 0x0, 1"
          "HDMI-A-1, 1280x1024x75, 3440x0, 1"
        ];

        general = {
          gaps_in = 0;
          gaps_out = 0;
        };

        animations.enabled = false;

        input.kb_layout = "gb";

        misc.vrr = 1;

        "$modifier" = "SUPER";

        bind = [
          "$modifier,Return,exec,kitty"
          "$modifier,W,exec,firefox"
          "$modifier,Y,exec,kitty -e yazi"
          "$modifier,D,exec,discord"
          "$modifier,Z,exec,zeditor"
          "$modifier,S,exec,steam"
          "$modifier,M,exec,thunderbird"
          "$modifier,Q,killactive,"
          "$modifier,F,fullscreen,"
          "$modifier SHIFT,F,togglefloating,"
          "$modifier ALT,F,workspaceopt, allfloat"
          "$modifier SHIFT,h,movewindow,l"
          "$modifier SHIFT,l,movewindow,r"
          "$modifier SHIFT,k,movewindow,u"
          "$modifier SHIFT,j,movewindow,d"
          "$modifier ALT, 43, swapwindow,l"
          "$modifier ALT, 46, swapwindow,r"
          "$modifier ALT, 45, swapwindow,u"
          "$modifier ALT, 44, swapwindow,d"
          "$modifier,h,movefocus,l"
          "$modifier,l,movefocus,r"
          "$modifier,k,movefocus,u"
          "$modifier,j,movefocus,d"
          "$modifier,1,workspace,1"
          "$modifier,2,workspace,2"
          "$modifier,3,workspace,3"
          "$modifier,4,workspace,4"
          "$modifier,5,workspace,5"
          "$modifier,6,workspace,6"
          "$modifier,7,workspace,7"
          "$modifier,8,workspace,8"
          "$modifier,9,workspace,9"
          "$modifier,0,workspace,10"
          "$modifier SHIFT,1,movetoworkspace,1"
          "$modifier SHIFT,2,movetoworkspace,2"
          "$modifier SHIFT,3,movetoworkspace,3"
          "$modifier SHIFT,4,movetoworkspace,4"
          "$modifier SHIFT,5,movetoworkspace,5"
          "$modifier SHIFT,6,movetoworkspace,6"
          "$modifier SHIFT,7,movetoworkspace,7"
          "$modifier SHIFT,8,movetoworkspace,8"
          "$modifier SHIFT,9,movetoworkspace,9"
          "$modifier SHIFT,0,movetoworkspace,10"
          "ALT,Tab,cyclenext"
          "ALT,Tab,bringactivetotop"
          ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        ];

        bindm = [
          "$modifier, mouse:272, movewindow"
          "$modifier, mouse:273, resizewindow"
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}"];

        wallpaper = [
          ",${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}"
        ];
      };
    };

    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
  };
}

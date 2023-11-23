{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ libva libva-utils radeontop ];

  hardware.opengl = {
    extraPackages = with pkgs; [
      # casus ffmpeg to hang instead of error
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };


  services.jellyfin = {
    enable = true;
    group = "media";
  };

  users.groups.render.members = [ "jellyfin" ];
  users.groups.video.members = [ "jellyfin" ];
}

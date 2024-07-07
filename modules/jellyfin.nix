{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ libva libva-utils radeontop clinfo opencl-info jellyfin-ffmpeg ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
  };


  services.jellyfin = {
    enable = true;
    group = "media";
  };

  users.groups.render.members = [ "jellyfin" ];
  users.groups.video.members = [ "jellyfin" ];
}

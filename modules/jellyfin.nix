{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ libva libva-utils radeontop clinfo jellyfin-ffmpeg ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      vaapiVdpau
      libvdpau-va-gl
    ];
  };


  services.jellyfin = {
    enable = true;
    group = "media";
  };

  users.groups.render.members = [ "jellyfin" ];
  users.groups.video.members = [ "jellyfin" ];
}

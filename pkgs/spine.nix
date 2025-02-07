{
  lib,
  writeShellScript,
  buildFHSEnv,
  licenseKey ? null,
}:
let
  baseUrl = "https://eu.esotericsoftware.com/launcher/linux";
in
buildFHSEnv rec {
  pname = "spine";
  version = "4.2.39${(if licenseKey == null then "-trial" else "")}";

  src = builtins.fetchTarball (
    if licenseKey == null then
      {
        url = baseUrl;
        sha256 = "sha256:0f4gif6qc3jhli84qqdka3h81y35z0nlfrfi27ln1jwh5h7xz4r0";
      }
    else
      {
        url = "${baseUrl}/${licenseKey}";
        sha256 = "sha256:1jqmh26yg1ml3in5bmy553cny5gi0j8hk8zcv37mmdbp3w1dkq12";
      }
  );

  runScript = writeShellScript "spine-launcher" ''
    ${src}/launcher/2/bin/java \
      -Xms512m -Xmx4096m \
      com.esotericsoftware.spine.launcher.Launcher
  '';

  targetPkgs =
    pkgs: with pkgs; [
      zlib
      freetype
      fontconfig

      libGL
      libglvnd
      mesa.drivers
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXxf86vm

      alsa-lib
      libpulseaudio
      udev
    ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications/
  '';

  license = lib.licenses.unfree;
}

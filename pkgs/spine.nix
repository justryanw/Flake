{ lib
, requireFile
, runCommand
, writeShellScript
, buildFHSEnv
}:

let
  spineTarball = requireFile rec {
    name = "Spine.tar.gz";
    url = "https://eu.esotericsoftware.com/";
    message = ''
      Unfortunately, we cannot download file ${name} automatically.
      Please run the following command replacing LICENSE_KEY with your Spine license key to download it manually.
        nix-prefetch-url --type sha256 https://eu.esotericsoftware.com/launcher/linux/LICENSE_KEY
    '';
    sha256 = "0ayja2p6p4wkgiqw2f5xvbifh55gicvhxbwm5yh9b9hwwhxx28z5";
  };

  unpackedSpine = runCommand "spine-pro-unpacked" {} ''
    mkdir -p $out
    tar -xzf ${spineTarball} -C $out --strip-components=1
  '';

in
buildFHSEnv {
  pname = "spine-pro";
  version = "4.2.39";

  runScript = writeShellScript "spine-launcher" ''
    ${unpackedSpine}/launcher/2/bin/java \
      -Xms512m -Xmx4096m \
      com.esotericsoftware.spine.launcher.Launcher
  '';

  targetPkgs = pkgs: with pkgs; [
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

  meta = {
    license = lib.licenses.unfree;
  };
}
name: { pkgs, lib, config, ... } @ inputs: {
  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      initialHashedPassword = "$y$j9T$VcFtf.LY2BA.ICsKVYa.X.$lEGovq2oX/EwnV5Q/8Rj2vehlUi3fWaP3UIayolWSU8";
      
      packages = lib.mkIf config.modules.graphics.enable (with pkgs; [
        authenticator
        gnome.gnome-software
        krita
        inkscape
        celluloid
        gnome-frog
        gnome-decoder
        parabolic
        g4music
      ]);
    };
  };
}

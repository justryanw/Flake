{ ... }: {
  programs = {
    zsh.shellAliases = {
      s = "sudo nixos-rebuild switch --flake ~/Flake/.#desktop";
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}

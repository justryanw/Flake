{ ... }: {
  programs.zsh.shellAliases = {
    s = "sudo nixos-rebuild switch --flake ~/Flake/.#kevin";
  };
}

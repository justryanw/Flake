{ pkgs, ... }: {
  home.packages = with pkgs; [ ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.zsh.shellAliases = {
    s = "sudo nixos-rebuild switch --flake ~/Flake/.#desktop";
  };
}

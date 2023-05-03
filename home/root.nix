{ ... }: {

  programs.zsh.shellAliases = {
    sys = "systemctl";
    logs = "journalctl -fu";
  };

}

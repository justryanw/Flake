{ ... }: {

  programs.zsh.shellAliases = {
    sys = "systemctl";
    logs = "journalctl -fu";
    la = "ls -A";
  };

}

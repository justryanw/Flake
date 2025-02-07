{ ... }:
{
  users.mutableUsers = false;

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/home/ryan/.ssh/id_ed25519" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      spine-key = { };
      ryan-password.neededForUsers = true;
      helen-password.neededForUsers = true;
    };
  };
}

{ ... } : {
  sops = {
    age.keyFile = "/home/ryan/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    secrets = {
      "private_keys/ryan" = {
        path = "/home/ryan/.ssh/id_ed25519";
      };
    };
  };
}
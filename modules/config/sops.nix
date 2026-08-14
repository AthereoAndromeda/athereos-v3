{
  inputs,
  den,
  ...
}: let
  secretspath = toString inputs.my-secrets;
in {
  den.aspects.security.sops = {
    includes = [
      den.aspects.security.age
      den.aspects.security.ssh
    ];

    nixos = {
      imports = [inputs.sops-nix.nixosModules.sops];

      # environment.systemPackages = with pkgs; [age sops];
      # # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      sops = {
        # This will add secrets.yml to the nix store
        # You can avoid this by adding a string to the full path instead, i.e.
        # defaultSopsFile = "/home/athereo/nixos/secrets/example.yaml";
        defaultSopsFile = "${secretspath}/secrets/example.yaml";
        # sops.defaultSopsFile = ./secrets/example.yaml;
        validateSopsFiles = false;

        age = {
          # This will automatically import SSH keys as age keys
          sshKeyPaths = [];
          keyFile = "/var/lib/sops-nix/key.txt";
          # This is using an age key that is expected to already be in the filesystem
          # This will generate a new key if the key specified above does not exist
          generateKey = true;
        };

        # This is the actual specification of the secrets.
        secrets.example_key = {};
        # sops.secrets."myservice/my_subdir/my_secret" = {};
      };

      # sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };

    persist = {
      directories = ["/var/lib/sops-nix"];
      home.directories = [".config/sops"];
    };
  };
}

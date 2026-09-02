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

    nixos = {pkgs, ...}: {
      imports = [inputs.sops-nix.nixosModules.sops];
      environment.systemPackages = [pkgs.sops];

      sops = {
        defaultSopsFile = "${secretspath}/secrets/main.yaml";
        validateSopsFiles = false;

        age = {
          # This will automatically import SSH keys as age keys
          sshKeyPaths = [];
          keyFile = "/persist/var/lib/sops-nix/key.txt";
          # This is using an age key that is expected to already be in the filesystem
          # This will generate a new key if the key specified above does not exist
          generateKey = true;
        };

        # This is the actual specification of the secrets.
        # secrets.example_key = {};
        # sops.secrets."myservice/my_subdir/my_secret" = {};
      };
    };

    homeManager = {config, ...}: {
      home.sessionVariables = {
        SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys-pq.txt";
      };
    };

    persist = {
      directories = ["/var/lib/sops-nix"];
      home.config.directories = ["sops"];
    };
  };
}

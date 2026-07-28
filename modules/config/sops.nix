{
  inputs,
  den,
  ...
}: {
  den.aspects.security.sops = {
    nixos = {pkgs, ...}: {
      imports = [inputs.sops-nix.nixosModules.sops];

      environment.systemPackages = with pkgs; [age sops];
      # Enable the OpenSSH daemon.
      services.openssh.enable = true;

      # This will add secrets.yml to the nix store
      # You can avoid this by adding a string to the full path instead, i.e.
      sops.defaultSopsFile = "/home/athereo/nixos/secrets/example.yaml";
      # sops.defaultSopsFile = ./secrets/example.yaml;
      sops.validateSopsFiles = false;

      # This will automatically import SSH keys as age keys
      sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      # This is using an age key that is expected to already be in the filesystem
      sops.age.keyFile = "/home/athereo/.config/sops/age/keys.txt";
      # This will generate a new key if the key specified above does not exist
      sops.age.generateKey = false;
      # This is the actual specification of the secrets.
      sops.secrets.example_key = {};
      # sops.secrets."myservice/my_subdir/my_secret" = {};
    };
  };
}

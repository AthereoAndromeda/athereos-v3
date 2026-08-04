{...}: {
  den.aspects.security.ssh = {
    nixos = {
      services.openssh.enable = true;
    };

    persist.files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];

    persist.home.directories = [
      {
        directory = ".ssh";
        mode = "0600";
      }
    ];
  };
}

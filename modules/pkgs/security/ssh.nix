{...}: {
  den.aspects.security.ssh = {
    nixos = {
      services.openssh.enable = true;
    };

    homeManager = {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings = {
          # Default settings
          "*" = {
            ForwardAgent = false;
            AddKeysToAgent = "no";
            Compression = false;
            ServerAliveInterval = 0;
            ServerAliveCountMax = 3;
            HashKnownHosts = false;
            UserKnownHostsFile = "~/.ssh/known_hosts";
            ControlMaster = "no";
            ControlPath = "~/.ssh/master-%r@%n:%p";
            ControlPersist = "no";
          };

          "gitlab.com github.com codeberg.org" = {
            # Host = "gitlab.com github.com codeberg.org";
            IdentitiesOnly = true;
            IdentityFile = [
              "~/.ssh/id_ed25519"
              "~/.ssh/github_signing"
            ];
          };
        };
      };
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
        mode = "0700";
      }
    ];
  };
}

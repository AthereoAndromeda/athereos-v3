{lib, ...}: {
  den.aspects.impermanence.nixos = {
    user,
    persist,
    ...
  }: {
    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;

      directories =
        [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/sops-nix"
          "/var/db/sudo"
          # "/var/lib/cups"
          # "/var/lib/greetd"
          # "/var/lib/regreet"

          "/etc/ssl/certs"
          "/etc/NetworkManager/system-connections"
          "/etc/nixos"
          # "/etc/greetd"
        ]
        ++ lib.concatMap (f: f.directories or []) persist;

      files =
        [
          "/etc/machine-id"
          "/etc/NIXOS" # Empty file marker
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
        ]
        ++ lib.concatMap (f: f.files or []) persist;

      users.${user.name} = {
        directories =
          [
            "nixos"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Templates"
            "Videos"
            ".thunderbird"
            {
              directory = ".ssh";
              mode = "0700";
            }

            # Local
            ".local/share/applications"
            ".local/share/Trash"
            ".local/state/noctalia"

            # Config
            ".config/age"
            ".config/nix"
          ]
          ++ lib.concatMap (f: f.home.directories or []) persist;

        files =
          [".face"]
          ++ lib.concatMap (f: f.home.files or []) persist;
      };
    };
  };

  den.quirks.persist = {
    description = "Directories and files to persist when impermanence is active";
  };
}

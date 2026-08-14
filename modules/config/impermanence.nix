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
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
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
        ]
        ++ lib.concatMap (f: f.files or []) persist;

      users.${user.name} = {
        directories =
          [
            "nixos"
            ".thunderbird"

            # Local
            ".local/share/applications"
            ".local/share/Trash"

            # Config
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

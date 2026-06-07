{inputs, ...}: {
  den.aspects.impermanence = {
    nixos = {user, ...}: {
      imports = [inputs.impermanence.nixosModules.impermanence];

      environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;

        directories = [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          # "/var/lib/cups"
          # "/var/lib/greetd"
          # "/var/lib/regreet"

          "/etc/ssl/certs"
          "/etc/NetworkManager/system-connections"
          "/etc/nixos"
          # "/etc/greetd"
        ];

        files = [
          "/etc/machine-id"
          # "/etc/ssh/ssh_known_hosts"
        ];

        users.${user.name} = {
          directories = [
            "nixos"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Templates"
            "Videos"
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".gnupg";
              mode = "0700";
            }

            # Local
            ".local/share/Trash"
            ".local/share/zoxide"
            ".local/state/noctalia"
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }

            # Config
            ".config/zen"
          ];

          files = [
            ".face"
            ".config/nushell/history.txt"
          ];
        };
      };
    };
  };
}

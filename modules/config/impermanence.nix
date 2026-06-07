{inputs, ...}: {
  den.aspects.impermanence = {
    nixos = {user, ...}: {
      imports = [inputs.impermanence.nixosModules.impermanence];

      boot.initrd.systemd = {
        enable = true;
        services.rollback = {
          description = "Rollback BTRFS subvolume to a pristine state";
          wantedBy = ["initrd.target"];

          # LUKS/TPM process
          after = ["systemd-cryptsetup@enc.service"];

          # Before mounting the system root (/sysroot) during early boot process
          before = ["sysroot.mount"];

          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = ''
            mkdir -p /mnt

            mount -o subvol=/ /dev/mapper/enc /mnt

            # Recursively remove subvolumes
            btrfs subvolume list -o /mnt/root |
              cut -f9 -d' ' |
              while read subvolume; do
                echo "Deleting /$subvolume subvolume..."
                btrfs subvolume delete "/mnt/$subvolume"
              done &&
              echo "Deleting /root subvolume..." &&
              btrfs subvolume delete /mnt/root
            echo "Restoring blank /root subvolume..."
            btrfs subvolume snapshot /mnt/root-blank /mnt/root

            # Once done rolling back, we can unmount
            umount /mnt
          '';
        };
      };

      environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;

        directories = [
          "/var/log"
          "/var/lib/bluetooth"
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
        ];

        files = [
          "/etc/machine-id"
          "/etc/NIXOS" # Empty file marker
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

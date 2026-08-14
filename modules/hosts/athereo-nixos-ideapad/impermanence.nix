{
  inputs,
  lib,
  ...
}: {
  den.aspects.impermanence.nixos = {
    user,
    persist,
    ...
  }: {
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

          # # Recursively remove subvolumes
          # btrfs subvolume list -o /mnt/root |
          #   cut -f9 -d' ' |
          #   while read subvolume; do
          #     echo "Deleting /$subvolume subvolume..."
          #     btrfs subvolume delete "/mnt/$subvolume"
          #   done &&
          #   echo "Deleting /root subvolume..." &&
          #   btrfs subvolume delete /mnt/root

          if [ -e /mnt/root ]; then
            echo "Deleting subvolumes recursively"
            btrfs subvolume delete --recursive /mnt/root
          fi

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

{inputs, ...}: {
  den.aspects.athereo-nixos-ideapad.nixos = {
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
        serviceConfig.TimeoutSec = 180;
        script = ''
          mkdir -p /mnt
          mkdir -p /old-roots

          mount -o subvol=/ /dev/mapper/enc /mnt
          mount -o subvol=old-roots,compress=zstd,noatime /dev/mapper/enc /old-roots

          timestamp="$(date -u +%Y%m%d-%H%M%S)"
          backup="/old-roots/root-$timestamp"

          echo "Backing up /root subvolume..."
          btrfs subvolume snapshot -r /mnt/root "$backup"

          if [ -e /mnt/root ]; then
            echo "Deleting subvolumes recursively"
            btrfs subvolume delete --recursive /mnt/root
          fi

          echo "Restoring blank /root subvolume..."
          btrfs subvolume snapshot /mnt/root-blank /mnt/root

          echo "Deleting root snapshots older than 14 days..."
          find /old-roots \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            -name 'root-????????-??????' \
            -mtime +14 \
            -exec btrfs subvolume delete --recursive {} \;

          echo "Waiting for Btrfs deletions..."
          btrfs subvolume sync /old-roots

          # Once done rolling back, we can unmount
          umount /mnt
          umount /old-roots
        '';
      };
    };
  };
}

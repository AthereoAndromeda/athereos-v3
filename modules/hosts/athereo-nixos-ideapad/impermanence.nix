{inputs, ...}: {
  den.aspects.hardware.athereo-nixos-ideapad.nixos = {
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
  };
}

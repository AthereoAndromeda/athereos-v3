{lib, ...}: {
  den.aspects.hardware.athereo-nixos-ideapad = {
    nixos = {config, ...}: {
      boot.initrd = {
        availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci"];
        kernelModules = [];

        luks.devices."enc".device = "/dev/disk/by-uuid/c56d902e-d1b7-4803-b754-1f4d451b1c5f";
      };

      boot.kernelModules = ["kvm-amd"];
      boot.extraModulePackages = [];
      boot.supportedFilesystems = {
        btrfs = true;
        ntfs = true;
      };

      boot.zswap = {
        enable = true;
      };

      # Here a more complete example
      boot.kernelParams = [
        "zswap.enabled=1"
        "zswap.max_pool_percent=50"
        "zswap.shrinker_enabled=1"
        "zswap.compressor=zstd"
        "zswap.accept_threshold_percent=90"
      ];

      fileSystems."/" = {
        device = "/dev/mapper/enc";
        fsType = "btrfs";
        options = ["subvol=root" "compress=zstd" "noatime"];
      };

      fileSystems."/nix" = {
        device = "/dev/mapper/enc";
        fsType = "btrfs";
        options = ["subvol=nix" "compress=zstd" "noatime"];
      };

      fileSystems."/persist" = {
        device = "/dev/mapper/enc";
        fsType = "btrfs";
        options = ["subvol=persist" "compress=zstd" "noatime"];
        neededForBoot = true;
      };

      fileSystems."/var/log" = {
        device = "/dev/mapper/enc";
        fsType = "btrfs";
        options = ["subvol=log" "compress=zstd" "noatime"];
        neededForBoot = true;
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/840D-B11A";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      swapDevices = [
        {
          device = "/dev/disk/by-label/lb_swap";
          options = ["discard"];
          encrypted = {
            enable = true;
            label = "swap";
            blkDev = "/dev/disk/by-label/lb_luks_swap";
          };
        }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      hardware.enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}

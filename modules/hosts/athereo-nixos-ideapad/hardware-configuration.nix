{lib, ...}: {
  den.aspects.athereo-nixos-ideapad-hardware = {
    nixos = {config, ...}: {
      boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-amd"];
      boot.extraModulePackages = [];
      boot.supportedFilesystems = {
        btrfs = true;
        ntfs = true;
      };

      fileSystems."/" = {
        device = "/dev/mapper/enc";
        fsType = "btrfs";
        options = ["subvol=root" "compress=zstd" "noatime"];
      };

      boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/c56d902e-d1b7-4803-b754-1f4d451b1c5f";

      # fileSystems."/home" = {
      #   device = "/dev/mapper/enc";
      #   fsType = "btrfs";
      #   options = ["subvol=home" "compress=zstd" "noatime"];
      # };

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
        {device = "/dev/disk/by-uuid/ad39123d-0e0c-40e2-ade9-9829a50e066f";}
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      hardware.enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}

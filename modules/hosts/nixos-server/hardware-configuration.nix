{
  lib,
  den,
  ...
}: {
  den.aspects.nixos-server = {
    includes = with den.aspects.hardware; [
      swap
    ];

    nixos = {config, ...}: {
      swap.enable = true;
      swap.swappiness = 60;

      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
      boot.initrd.kernelModules = [];
      boot.initrd.supportedFilesystems = {btrfs = true;};
      boot.supportedFilesystems = {
        btrfs = true;
        ntfs = true;
      };
      boot.kernelModules = ["kvm-intel"];
      boot.kernelParams = [
        "consoleblank=300"
      ];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/mapper/enc";
        fsType = "btrfs";
        options = ["subvol=root" "compress=zstd" "noatime"];
      };

      boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/4616d311-204f-4339-82af-9f97c38cc6c6";

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
        device = "/dev/disk/by-uuid/12CE-A600";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      swapDevices = [
        {device = "/dev/disk/by-uuid/c2e96655-7386-41df-89ff-808f992cfaff";}
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}

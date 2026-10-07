{
  config,
  lib,
  ...
}: {
  swap.enable = true;

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = {
    btrfs = true;
    ntfs = true;
  };
  boot.initrd.systemd.enable = true;
  boot.initrd.supportedFilesystems = {
    btrfs = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/15AE-5873";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/" = {
    device = "/dev/mapper/enc";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd" "noatime"];
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/be651f6e-0ac4-4b75-90fd-fdef1db00048";

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

  swapDevices = [
    {device = "/dev/disk/by-uuid/87f85453-3a30-4447-9b38-c010fbba321e";}
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

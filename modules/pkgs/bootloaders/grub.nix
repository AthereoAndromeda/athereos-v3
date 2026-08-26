{den, ...}: {
  den.aspects.boot.grub = {
    includes = [den.aspects.boot];

    nixos = {...}: {
      boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}

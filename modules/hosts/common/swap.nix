{lib, ...}: {
  den.aspects.hardware.swap = {
    nixos = {config, ...}: {
      options.swap = {
        enable = lib.mkEnableOption "swap";

        swappiness = lib.mkOption {
          default = 100;
          type = lib.types.int;
        };
      };

      config = lib.mkIf config.swap.enable {
        boot.kernel.sysctl = {
          "vm.swappiness" = config.swap.swappiness;
        };
      };
    };
  };
}

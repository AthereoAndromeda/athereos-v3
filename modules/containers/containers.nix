{lib, ...}: {
  den.aspects.containers = {
    nixos = {config, ...}: {
      networking.nat = {
        enable = true;
        internalInterfaces = lib.mkMerge [
          (lib.mkIf config.networking.nftables.enable ["ve-*"])
          (lib.mkIf (!config.networking.nftables.enable) ["ve-+"])
        ];
        externalInterface = "wlp2s0";
        enableIPv6 = true;
      };
    };
  };
}

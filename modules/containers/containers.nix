{...}: {
  den.aspects.containers = {
    nixos = {config, ...}: {
      assertions = [
        {
          assertion = config.networking.nftables.enable;
          message = "nftables must be used.";
        }
      ];

      networking.nat = {
        enable = true;
        internalInterfaces = ["ve-*"];
        # externalInterface = "ens3";
        externalInterface = "wlp2s0";
        enableIPv6 = true;
      };
    };
  };
}

{den, ...}: {
  den.aspects.hardware.zswap = {
    includes = [den.aspects.hardware.swap];
    nixos = {
      boot.zswap = {
        enable = true;
        maxPoolPercent = 50;
        shrinkerEnabled = true;
        compressor = "zstd";
        acceptThresholdPercent = 90;
      };

      # Here a more complete example
      # boot.kernelParams = [
      #   "zswap.enabled=1"
      #   "zswap.max_pool_percent=50"
      #   "zswap.shrinker_enabled=1"
      #   "zswap.compressor=zstd"
      #   "zswap.accept_threshold_percent=90"
      # ];
    };
  };
}

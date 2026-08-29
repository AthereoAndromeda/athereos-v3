{...}: {
  gaming.steam = {
    nixos = {
      pkgs,
      config,
      ...
    }: {
      assertions = [
        # (lib.optionals config.hardware.graphics.enable "Steam requires graphics acceleration.")
        # (lib.optionals config.hardware.graphics.enable32Bit "Some games require 32-bit support.")
        {
          assertion = config.hardware.graphics.enable;
          message = "Steam requires graphics acceleration.";
        }
        {
          assertion = config.hardware.graphics.enable32Bit;
          message = "Some games require 32-bit support.";
        }
      ];

      environment.systemPackages = [pkgs.steam-run];
      programs.steam = {
        enable = true;
      };

      programs.gamemode.enable = true;

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    persist.home.directories = [".steam"];
    persist.home.data.directories = ["Steam"];
  };
}

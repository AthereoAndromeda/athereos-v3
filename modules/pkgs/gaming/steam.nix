{
  lib,
  config,
  ...
}: {
  gaming.steam = {
    config.warnings = [
      (lib.optionals config.hardware.graphics.enable "Steam requires graphics acceleration.")
      (lib.optionals config.hardware.graphics.enable32Bit "Some games require 32-bit support.")
    ];

    nixos = {pkgs, ...}: {
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
  };
}

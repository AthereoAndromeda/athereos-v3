{inputs, ...}: {
  imports = [(inputs.den.namespace "gaming" false)];

  gaming.base = {
    user.extraGroups = ["gamemode"];

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wineWow64Packages.full
        winetricks
      ];

      programs.gamemode.enable = true;
      programs.gamescope = {
        enable = true;
        capSysNice = false;
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}

{gaming, ...}: {
  gaming.lutris = {
    includes = [gaming.base];
    persist.home.directories = ["Games"];
    persist.home.data.directories = ["lutris" "umu"];

    homeManager = {
      host,
      osConfig,
      pkgs,
      ...
    }: {
      assertions = [
        {
          assertion = host.sharedHomePkgs;
          message = "UseGlobalPkgs must be enabled. nixos pkgs must match home-manager pkgs instance";
        }
      ];

      programs.lutris = {
        enable = true;

        extraPackages = with pkgs; [mangohud winetricks gamescope gamemode umu-launcher];
        winePackages = with pkgs; [wineWow64Packages.full];
        steamPackage = osConfig.programs.steam.package;
      };
    };
  };
}

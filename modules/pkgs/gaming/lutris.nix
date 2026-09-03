{...}: {
  gaming.lutris = {
    persist.home.directories = ["Games"];
    persist.home.data.directories = ["lutris" "umu"];

    # TODO: Move to own wine.nix file
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wineWow64Packages.full
        winetricks
      ];
    };
    homeManager = {
      host,
      osConfig,
      pkgs,
      ...
    }: {
      assertions = [
        {
          assertion = host.sharedHomePkgs;
          message = "UseGlobalPkgs must be enabled. nixos steam pkgs must match home-manager pkgs instance";
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

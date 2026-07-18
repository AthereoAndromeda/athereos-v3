{inputs, ...}: {
  den.aspects.pkgs.vesktop = {
    nixos = {
      nixpkgs.config.permittedInsecurePackages = [
        "electron-40.10.5"
      ];
    };
    homeManager = {host, ...}: let
      pinned-pkgs = import inputs.pinned-nixpkgs {inherit (host) system;};
    in {
      programs.vesktop.enable = true;
      # programs.vesktop.package = pinned-pkgs.vesktop;
    };
  };
}

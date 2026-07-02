{inputs, ...}: {
  den.aspects.pkgs.vesktop = {
    homeManager = {host, ...}: let
      pinned-pkgs = import inputs.pinned-nixpkgs {inherit (host) system;};
    in {
      programs.vesktop.enable = true;
      programs.vesktop.package = pinned-pkgs.vesktop;
    };
  };
}

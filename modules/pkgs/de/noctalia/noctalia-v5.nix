{inputs, ...}: {
  den.aspects.noctalia-v5.nixos = {pkgs, ...}: {
    qt.enable = true;
    services.upower.enable = true;
    # services.tuned.enable = true;

    environment.systemPackages = [
      pkgs.quickshell
      inputs.noctalia-v5.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  den.aspects.noctalia-v5.homeManager = {...}: {
    imports = [inputs.noctalia-v5.homeModules.default];
  };
}

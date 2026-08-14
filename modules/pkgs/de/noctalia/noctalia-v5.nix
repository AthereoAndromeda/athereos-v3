{
  inputs,
  den,
  ...
}: {
  den.aspects.noctalia-v5.includes = [den.aspects.noctalia-greeter];
  den.aspects.noctalia-v5.persist.home.directories = [".local/state/noctalia"];

  den.aspects.noctalia-v5.nixos = {pkgs, ...}: {
    nix.settings = {
      extra-substituters = ["https://noctalia.cachix.org"];
      extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    };

    imports = [
      inputs.noctalia-v5.nixosModules.default
    ];

    qt.enable = true;
    services.upower.enable = true;
    # services.tuned.enable = true;

    environment.systemPackages = [
      inputs.noctalia-v5.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
  };

  den.aspects.noctalia-v5.homeManager = {...}: {
    # imports = [inputs.noctalia-v5.homeModules.default];
  };
}

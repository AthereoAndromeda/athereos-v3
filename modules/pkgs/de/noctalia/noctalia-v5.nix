{
  inputs,
  den,
  ...
}: {
  den.aspects.noctalia-v5 = {
    includes = [den.aspects.noctalia-greeter];
    persist.home.directories = [".local/state/noctalia"];

    nixos = {
      pkgs,
      config,
      ...
    }: {
      warnings = [
        {
          assertion = config.services.udisks2.enable;
          message = "Noctalia plugins require udisks service.";
        }
        {
          assertion = config.programs.kdeconnect.enable;
          message = "Noctalia plugins require KDE Connect.";
        }
      ];

      nix.settings = {
        extra-substituters = ["https://noctalia.cachix.org"];
        extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
      };

      imports = [
        inputs.noctalia-v5.nixosModules.default
      ];

      qt.enable = true;
      services.upower.enable = true;

      environment.systemPackages =
        [
          inputs.noctalia-v5.packages.${pkgs.stdenv.hostPlatform.system}.default
        ]
        ++ (with pkgs; [
          udiskie
          udisks2
        ]);

      services.udisks2 = {
        enable = true;
        mountOnMedia = true;
      };

      programs.kdeconnect.enable = true;

      networking.firewall = rec {
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = allowedTCPPortRanges;
      };

      programs.noctalia = {
        enable = true;
        recommendedServices.enable = true;
      };
    };
  };
}

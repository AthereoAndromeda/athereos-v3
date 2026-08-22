{
  inputs,
  den,
  lib,
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
      warnings = lib.concatLists [
        (lib.optionals (!config.services.udisks2.enable) [
          "Noctalia plugins require udisks service."
        ])

        (lib.optionals (!config.programs.kdeconnect.enable) [
          "Noctalia plugins require KDE Connect."
        ])

        (lib.optionals (!config.services.udev.enable) [
          "Udev must be enabled for device rules to work."
        ])
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
          glib
          sshfs
          evtest
          python3
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

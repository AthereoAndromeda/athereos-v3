{
  inputs,
  den,
  lib,
  ...
}: {
  den.aspects.noctalia-v5 = {
    includes = [den.aspects.noctalia-greeter];
    persist.home.state.directories = ["noctalia"];

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

      nixpkgs.overlays = [inputs.noctalia-v5.overlays.default];
      imports = [inputs.noctalia-v5.nixosModules.default];

      environment.systemPackages = with pkgs; [
        noctalia
        udiskie
        udisks2
        glib
        sshfs
        evtest
        python3
      ];

      services.udisks2 = {
        enable = true;
        mountOnMedia = true;
      };

      services.upower.enable = true;

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

    homeManager = {
      imports = [inputs.noctalia-v5.homeModules.default];

      programs.noctalia = {
        enable = true;
        settings = ./noctalia-config.toml;
      };
    };
  };
}

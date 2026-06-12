{inputs, ...}: let
  inherit (builtins) fromJSON readFile;
  plugins-url = "https://github.com/noctalia-dev/noctalia-plugins";
in {
  flake.nixConfig = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  den.aspects.noctalia.nixos = {pkgs, ...}: {
    qt.enable = true;
    services.upower.enable = true;
    # services.tuned.enable = true;

    environment.systemPackages = [
      pkgs.quickshell
      (
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
          calendarSupport = true;
        }
      )
    ];
  };

  den.aspects.noctalia.homeManager = {...}: {
    imports = [inputs.noctalia.homeModules.default];
    qt.enable = true;
    programs.quickshell.enable = true;
    programs.noctalia-shell = {
      enable = true;
      settings = fromJSON (readFile ./noctalia.json);

      plugins = {
        version = 2;
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = plugins-url;
          }
        ];

        states = {
          fancy-audiovisualizer = {
            enabled = true;
            sourceUrl = plugins-url;
          };

          mirror-mirror = {
            enabled = true;
            sourceUrl = plugins-url;
          };

          kaomoji-provider = {
            enabled = true;
            sourceUrl = plugins-url;
          };

          unicode-picker = {
            enabled = true;
            sourceUrl = plugins-url;
          };

          polkit-agent = {
            enabled = true;
            sourceUrl = plugins-url;
          };

          niri-overview-launcher = {
            enabled = true;
            sourceUrl = plugins-url;
          };

          privacy-indicator = {
            enabled = true;
            sourceUrl = plugins-url;
          };
        };
      };

      pluginSettings = {};
    };
  };
}

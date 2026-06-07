{...}: {
  den.aspects.pkgs.fastfetch = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.fastfetch];
    };

    homeManager = {...}: {
      programs.fastfetch = {
        enable = true;
      };

      xdg.configFile = {
        "fastfetch/config.jsonc".source = ./25.jsonc;
      };
    };
  };
}

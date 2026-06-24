{inputs, ...}: {
  den.aspects.noctalia-greeter.nixos = {pkgs, ...}: let
    greeter-pkg = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${greeter-pkg}/bin/noctalia-greeter-session -- --session niri";
          user = "greeter";
        };
      };
    };

    programs.noctalia-greeter = {
      enable = true;
      package = greeter-pkg;

      # Optional configuration
      greeter-args = "";
      settings.cursor = {
        theme = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
      };
    };
  };
}

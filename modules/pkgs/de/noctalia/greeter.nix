{inputs, ...}: {
  den.aspects.noctalia-greeter = {
    persist.directories = ["/var/lib/noctalia-greeter"];

    nixos = {pkgs, ...}: {
      nixpkgs.overlays = [inputs.noctalia-greeter.overlays.default];
      imports = [inputs.noctalia-greeter.nixosModules.default];

      programs.noctalia-greeter = {
        enable = true;
        package = pkgs.noctalia-greeter;

        # Optional configuration
        # greeter-args = "";
        settings.cursor = {
          theme = "LyraQ-cursors";
          size = 24;
          package = pkgs.lyra-cursors;
        };
      };
    };
  };
}

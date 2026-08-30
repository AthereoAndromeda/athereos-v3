{lib, ...}: {
  den.aspects.nix-settings = {
    nixos = {config, ...}: {
      nix.settings.trusted-users = ["root" "@wheel"];

      sops.secrets."nix-settings/access-tokens/github" = {
        reloadUnits = ["nix-daemon.service"];
        owner = "root";
        group = "root";
        mode = "0400";
      };

      sops.templates."nix-access-tokens.conf" = let
        access-token-content = tokens: "access-tokens = ${lib.concatStringsSep " " tokens}";
      in {
        content = access-token-content [config.sops.placeholder."nix-settings/access-tokens/github"];
      };

      nix.extraOptions = ''
        !include ${config.sops.templates."nix-access-tokens.conf".path}
      '';

      nix.settings.experimental-features = ["nix-command" "flakes"];

      # Hardware-optimized for v3
      nix.settings.system-features = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
        "gccarch-znver3"
        "gccarch-x86-64-v3"
        "gccarch-x86-64-v2"
        "gccarch-x86-64"
      ];

      # nixpkgs.hostPlatform = {
      #   system = "x86_64-linux";
      #   gcc.arch = "znver3";
      #   gcc.tune = "znver3";
      # };
    };
  };
}

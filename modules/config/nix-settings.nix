{lib, ...}: {
  den.aspects.nix-settings = {
    nixos = {config, ...}: let
      token-entries = ["nix-settings/access-tokens/github"];
    in {
      nix.settings.trusted-users = ["root" "@wheel"];

      sops.secrets = lib.genAttrs token-entries (_: {});

      sops.templates."nix-access-tokens.conf" = let
        access-token-content = tokens: "access-tokens = ${lib.concatStringsSep " " tokens}";
      in {
        content = access-token-content (lib.map (token: config.sops.placeholder.${token}) token-entries);
        owner = "root";
        group = "wheel";
        mode = "0440";
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

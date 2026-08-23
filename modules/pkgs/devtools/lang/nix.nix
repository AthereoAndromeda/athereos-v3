{...}: {
  den.aspects.nix-tools = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        alejandra
        nixd
      ];

      programs.nix-index.enable = true;
    };

    homeManager = {
      programs.nix-index = {
        enable = true;
        enableNushellIntegration = true;
      };
    };

    persist.home.directories = [
      ".cache/nix-index"
    ];
  };
}

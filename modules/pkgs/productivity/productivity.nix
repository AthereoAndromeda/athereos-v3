{lib, ...}: {
  den.aspects.pkgs.productivity-tools = {
    nixos = {
      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "obsidian"
        ];
    };

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        anki
        super-productivity
        obsidian
      ];
    };

    persist.home.directories = [
      ".config/superProductivity"
      ".local/share/Anki2"
    ];
  };
}

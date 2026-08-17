{...}: {
  den.aspects.pkgs.productivity-tools = {
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

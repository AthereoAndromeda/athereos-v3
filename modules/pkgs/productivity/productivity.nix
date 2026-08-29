{...}: {
  den.aspects.pkgs.productivity-tools = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        anki
        super-productivity
        obsidian
      ];
    };

    persist.home.config.directories = ["superProductivity"];
    persist.home.data.directories = ["Anki2"];
  };
}

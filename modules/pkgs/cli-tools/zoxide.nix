{...}: {
  den.aspects.pkgs.zoxide = {
    homeManager = {...}: {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
      };
    };

    persist.home.directories = [
      ".local/share/zoxide"
    ];
  };
}

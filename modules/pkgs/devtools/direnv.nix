{...}: {
  dev-tools.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
      };
    };

    persist.home.directories = [
      ".local/share/direnv"
    ];
  };
}

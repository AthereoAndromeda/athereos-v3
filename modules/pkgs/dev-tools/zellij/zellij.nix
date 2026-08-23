{...}: {
  dev-tools.zellij.homeManager = {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ./new-config.kdl;
    };

    home.shellAliases."zj" = "zellij";
  };
}

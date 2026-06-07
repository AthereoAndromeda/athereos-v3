{...}: {
  dev-tools.zellij.homeManager = {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ./config.kdl;
    };
  };
}

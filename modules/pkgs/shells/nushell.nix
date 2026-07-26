{...}: {
  den.aspects.pkgs.shells.nushell = {
    nixos = {
      pkgs,
      user,
      ...
    }: {
      environment.systemPackages = [pkgs.nushell];
      environment.shells = [pkgs.nushell];
      environment.pathsToLink = ["/share/nushell"];
      users.users.${user.name}.shell = pkgs.nushell;
    };

    homeManager = {
      config,
      pkgs,
      ...
    }: {
      home.shell.enableNushellIntegration = true;

      programs.nushell = {
        enable = true;
        environmentVariables = config.home.sessionVariables;

        # FIX: Does not work if in configFile
        envFile.text = ''
          just --completions nushell | save -f ~/.just.nu
        '';

        configFile.text = ''
          source ~/.just.nu
        '';
        # zoxide init nushell | save -f ~/.zoxide.nu
        # source ~/.zoxide.nu
        # navi widget nushell | save -f ~/.cache/.navi.nu
        # source ~/.cache/.navi.nu

        plugins = with pkgs.nushellPlugins; [
          # polars
          # query
        ];
      };
    };
  };
}

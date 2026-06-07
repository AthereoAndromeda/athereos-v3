{...}: {
  den.aspects.pkgs.shells.nushell = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.nushell];
      environment.shells = [pkgs.nushell];
      environment.pathsToLink = ["/share/nushell"];
    };

    homeManager = {
      config,
      pkgs,
      ...
    }: {
      programs.nushell = {
        enable = true;
        environmentVariables = config.home.sessionVariables;

        configFile.text = ''
          just --completions nushell | save -f ~/.just.nu
          source ~/.just.nu
        '';
        # zoxide init nushell | save -f ~/.zoxide.nu
        # source ~/.zoxide.nu
        # navi widget nushell | save -f ~/.cache/.navi.nu
        # source ~/.cache/.navi.nu

        plugins = with pkgs.nushellPlugins; [
          polars
        ];
      };
    };
  };
}

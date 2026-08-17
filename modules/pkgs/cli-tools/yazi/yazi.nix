{lib, ...}: {
  den.aspects.pkgs.yazi = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [(pkgs.yazi.override {_7zz = pkgs._7zz-rar;})];
    };

    homeManager = {pkgs, ...}: {
      programs.yazi = {
        package = pkgs.yazi.override {_7zz = pkgs._7zz-rar;};
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
        shellWrapperName = "y";

        initLua = builtins.readFile ./init.lua;

        plugins = {
          inherit
            (pkgs.yaziPlugins)
            git
            chmod
            yatline
            compress
            ;
        };

        keymap = lib.fromTOML (builtins.readFile ./keymap.toml);
        settings = lib.fromTOML (builtins.readFile ./yazi.toml);
        theme.flavor.dark = "dracula";
      };
    };
  };
}

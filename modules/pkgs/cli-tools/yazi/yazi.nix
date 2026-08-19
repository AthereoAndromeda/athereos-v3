{
  inputs,
  lib,
  ...
}: {
  den.aspects.pkgs.yazi = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [(pkgs.yazi.override {_7zz = pkgs._7zz-rar;})];
    };

    homeManager = {pkgs, ...}: let
      dracula-pkg = pkgs.stdenvNoCC.mkDerivation {
        name = "dracula";
        src = inputs.yazi-flavors;

        phases = ["installPhase"];
        installPhase = ''
          runHook preInstall

          mkdir -p $out
          cp -r $src/dracula.yazi/* $out

          runHook postInstall
        '';
      };
    in {
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
            easyjump
            ;
        };

        keymap = lib.fromTOML (builtins.readFile ./keymap.toml);
        settings = lib.fromTOML (builtins.readFile ./yazi.toml);

        flavors = {
          dracula = dracula-pkg;
        };
        theme.flavor.dark = "dracula";
      };
    };
  };
}

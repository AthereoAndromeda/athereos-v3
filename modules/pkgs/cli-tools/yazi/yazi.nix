{lib, ...}: {
  den.aspects.pkgs.yazi = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [(pkgs.yazi.override {_7zz = pkgs._7zz-rar;})];
    };

    homeManager = {pkgs, ...}: let
      dracula-pkg = pkgs.stdenvNoCC.mkDerivation {
        name = "dracula";

        src = fetchGit {
          url = "https://github.com/yazi-rs/flavors.git";
          rev = "be0b21d0873092a63946cc2678dd700aac945902";
        };

        phases = ["unpackPhase" "installPhase"];
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

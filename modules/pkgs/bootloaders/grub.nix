{
  den,
  inputs,
  ...
}: {
  den.aspects.boot.grub = {
    includes = [den.aspects.boot];

    # TODO: Switchable GRUB Themes through options
    # TODO: Switch bootloaders through options
    nixos = {pkgs, ...}: let
      hyperfluent-theme = pkgs.stdenvNoCC.mkDerivation {
        name = "hyperfluent-theme";
        src = inputs.hyperfluent-grub;

        phases = ["installPhase"];
        installPhase = ''
          runHook preInstall

          mkdir -p $out
          cp -r $src/nixos/* $out

          runHook postInstall
        '';
      };
    in {
      boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        theme = hyperfluent-theme;
      };
    };
  };
}

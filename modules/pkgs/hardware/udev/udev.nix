{...}: let
  # TODO: Fetch from https://probe.rs/files/69-probe-rs.rules
  probe-rs-rules = pkgs:
    pkgs.stdenv.mkDerivation {
      name = "probe-rs-udev";
      src = ./69-probe-rs.rules;
      phases = ["installPhase"];

      installPhase = ''
        mkdir -p $out/lib/udev/rules.d
        cp $src $out/lib/udev/rules.d/69-probe-rs.rules
      '';
    };
in {
  den.aspects.udev.probe-rs = {
    nixos = {pkgs, ...}: {
      services.udev.packages = [
        (probe-rs-rules pkgs)
      ];
    };
  };
}

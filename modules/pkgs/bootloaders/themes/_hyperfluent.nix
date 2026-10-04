{
  inputs,
  pkgs,
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "hyperfluent-theme";
  src = inputs.hyperfluent-grub;

  phases = ["installPhase"];
  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r $src/nixos/* $out

    runHook postInstall
  '';
}

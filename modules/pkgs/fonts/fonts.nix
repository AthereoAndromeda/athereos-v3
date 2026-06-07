{den, ...}: let
  install-font = pkgs: path:
    pkgs.runCommand "install-font" {} ''
      mkdir -p $out/share/fonts/truetype

      # -L follows symlinks if the directory is a Nix store path
      # -iregex allows case-insensitive matching for various extensions
      find -L ${path} -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" -o -iname "*.woff2" \) \
        -exec cp -t $out/share/fonts/truetype/ {} +
    '';
in {
  den.aspects.pkgs.fonts = {
    includes = with den.aspects.pkgs; [
      fonts.jetbrains-mono
      fonts.source-code-pro
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.gnome-font-viewer];
      fonts.packages = [pkgs.dejavu_fonts];
      fonts.enableDefaultPackages = true;
    };

    jetbrains-mono.nixos = {pkgs, ...}: {
      fonts.packages = [pkgs.jetbrains-mono];
    };

    source-code-pro.nixos = {pkgs, ...}: {
      fonts.packages = [pkgs.source-code-pro];
    };
  };
  # fonts.packages = with pkgs.nerd-fonts;
  #   [
  #     jetbrains-mono
  #     sauce-code-pro
  #   ]
  #   ++ [
  #     (install-font ./library-3-am-font)
  #     (install-font ./aquire-font)
  #   ];
}

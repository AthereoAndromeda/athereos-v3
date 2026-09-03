{...}: {
  den.aspects.pkgs.bat = let
    bat-common = pkgs: {
      programs.bat.enable = true;
      programs.bat.extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
      ];
    };
  in {
    nixos = {pkgs, ...}: bat-common pkgs;

    homeManager = {pkgs, ...}: bat-common pkgs;
  };
}

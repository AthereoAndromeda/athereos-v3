{...}: {
  den.aspects.pkgs.bat = let
  in {
    nixos = {pkgs, ...}: {
      programs.bat.enable = true;
      programs.bat.extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
      ];

      programs.bat.settings = {
        italic-text = "always";
        theme = "noctalia";
      };
    };
  };
}

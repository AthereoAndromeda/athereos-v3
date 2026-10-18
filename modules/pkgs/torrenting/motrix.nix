{...}: {
  den.aspects.pkgs.motrix = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        motrix
        rayburst
      ];
    };
  };
}

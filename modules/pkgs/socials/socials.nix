{den, ...}: {
  den.aspects.pkgs.socials = {
    includes = with den.aspects; [pkgs.vesktop];
  };
}

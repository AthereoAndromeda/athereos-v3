{den, ...}: {
  den.aspects.pkgs.socials = {
    includes = with den.aspects; [
      pkgs.vesktop
      pkgs.simplex-chat
      pkgs.signal-desktop
    ];
  };
}

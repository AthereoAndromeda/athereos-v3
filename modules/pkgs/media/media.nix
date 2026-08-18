{den, ...}: {
  den.aspects.pkgs.media-tools = {
    includes = with den.aspects; [
      pkgs.mpv
      pkgs.loupe
      pkgs.snapshot
      pkgs.amberol
      pkgs.kew
    ];
  };
}

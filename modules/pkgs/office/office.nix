{den, ...}: {
  den.aspects.office = {
    includes = with den.aspects; [
      pkgs.thunderbird
      pkgs.libreoffice
      pkgs.onlyoffice
    ];
  };
}

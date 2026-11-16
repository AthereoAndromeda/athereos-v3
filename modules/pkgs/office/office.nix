{den, ...}: {
  den.aspects.office = {
    includes = with den.aspects; [
      pkgs.thunderbird
      pkgs.libreoffice
      pkgs.onlyoffice
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.papers];
    };
  };
}

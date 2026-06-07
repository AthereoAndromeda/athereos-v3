{den, ...}: {
  den.aspects.pkgs.cli-tools = {
    includes = [
      den.aspects.pkgs.fastfetch
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ripgrep
        fd
        xh
        fzf
        sttr
        wget
      ];
    };
  };
}

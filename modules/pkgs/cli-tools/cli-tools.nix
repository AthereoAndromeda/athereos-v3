{den, ...}: {
  den.aspects.pkgs.cli-tools = {
    includes = with den.aspects; [
      pkgs.fastfetch
      pkgs.pay-respects
      pkgs.espanso
      pkgs.carapace
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ripgrep
        fd
        xh
        fzf
        sttr
        wget
        jq
        file
      ];
    };
  };
}

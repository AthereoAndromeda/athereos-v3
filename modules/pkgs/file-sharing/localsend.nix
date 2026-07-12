{...}: {
  den.aspects.pkgs.localsend = {
    nixos.programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}

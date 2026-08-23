{...}: {
  den.aspects.pkgs.obs-studio.nixos = {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };
}

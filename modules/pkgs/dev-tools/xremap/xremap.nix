{inputs, ...}: {
  den.aspects.xremap = {
    nixos = {
      pkgs,
      user,
      ...
    }: {
      imports = [inputs.xremap.nixosModules.default];
      services.xremap = {
        enable = true;
        package = pkgs.xremap; # Use binary cache
        # withGnome = true;
        withNiri = true;
        userName = user.name;
        yamlConfig = builtins.readFile ./config.yml;
      };
    };
  };
}

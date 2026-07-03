{inputs, ...}: {
  den.aspects.xremap = {
    nixos = {user, ...}: {
      imports = [inputs.xremap.nixosModules.default];
      services.xremap = {
        enable = true;
        withGnome = true;
        userName = user.name;
        yamlConfig = builtins.readFile ./config.yml;
      };
    };
  };
}

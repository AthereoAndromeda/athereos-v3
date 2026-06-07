{inputs, ...}: {
  # den.aspects.xremap = {
  #   provides.to-users = {user, ...}: {
  #     nixos = {...}: {
  #       imports = [inputs.xremap.nixosModules.default];
  #       services.xremap = {
  #         enable = true;
  #         withGnome = true;
  #         userName = user.name;
  #         yamlConfig = builtins.readFile ./config.yml;
  #       };
  #     };
  #   };
  # };
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

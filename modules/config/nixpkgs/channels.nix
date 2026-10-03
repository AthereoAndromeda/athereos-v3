{inputs, ...}: let
  channels = {
    nixos-stable = {
      nixosSystem = inputs.nixpkgs-stable.lib.nixosSystem;
      hmModule = inputs.home-manager-stable.nixosModules.home-manager;
    };
    nixos-unstable = {
      nixosSystem = inputs.nixpkgs.lib.nixosSystem;
      hmModule = inputs.home-manager.nixosModules.home-manager;
    };
  };
in {
  den.schema.host = {
    config,
    lib,
    ...
  }: {
    options.channel = lib.mkOption {
      type = lib.types.enum (builtins.attrNames channels);
      default = "nixos-unstable";
    };

    config = {
      instantiate = lib.mkDefault channels.${config.channel}.nixosSystem;
      home-manager.module = lib.mkDefault channels.${config.channel}.hmModule;
    };
  };
}

{
  description = "AthereOS-v3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Dendritic Nix
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    den.url = "github:denful/den";

    impermanence.url = "github:nix-community/impermanence";
    # Impermanence has dependencies for development but is not needed for usage.
    # This gets rid of the extraneous dependencies
    impermanence.inputs.nixpkgs.follows = "";
    impermanence.inputs.home-manager.follows = "";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";

    # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    # to have it up-to-date or simply don't specify the nixpkgs input
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    noctalia-v5.url = "github:noctalia-dev/noctalia-shell/v5";
    noctalia-v5.inputs.nixpkgs.follows = "nixpkgs";

    nuenv.url = "github:DeterminateSystems/nuenv";
    nuenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    (inputs.nixpkgs.lib.evalModules {
      modules = [
        (inputs.import-tree ./modules)
        inputs.den.flakeOutputs.flake
      ];
      specialArgs.inputs = inputs;
    }).config.flake;
}

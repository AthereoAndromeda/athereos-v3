{inputs, ...}: {
  imports = [(inputs.den.namespace "dev-tools" false)];

  dev-tools.utils = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wev
      ];
    };
  };
}

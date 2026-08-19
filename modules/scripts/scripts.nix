{...}: {
  den.aspects.scripts.lenovoctl = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "lenovoctl" (builtins.readFile ./lenovoctl.sh))
      ];
    };
  };
}

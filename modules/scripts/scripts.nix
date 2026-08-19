{...}: {
  den.aspects.scripts = {
    homeManager = {pkgs, ...}: {
      home.packages = [
        (pkgs.writeShellScriptBin "lenovoctl" (builtins.readFile ./lenovoctl.sh))
      ];
    };
  };
}

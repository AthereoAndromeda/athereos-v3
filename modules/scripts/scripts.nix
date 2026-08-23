{...}: {
  den.aspects.scripts.lenovoctl = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "lenovoctl" (builtins.readFile ./lenovoctl.sh))
      ];
    };
  };

  den.aspects.scripts.find-desktop = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        (pkgs.nuenv.writeScriptBin {
          name = "find-desktop";
          script = builtins.readFile ./find-desktop.nu;
        })
      ];
    };
  };
}

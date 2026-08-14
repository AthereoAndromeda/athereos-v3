{...}: {
  den.aspects.security.age = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.age];
    };

    persist.home.directories = [".config/age"];
  };
}

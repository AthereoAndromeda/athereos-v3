{inputs, ...}: {
  imports = [(inputs.den.namespace "remote-build" false)];

  remote-build.builder = {
    nixos = {
      users.users.remotebuild = {
        isSystemUser = true;
        group = "remotebuild";
        useDefaultShell = true;
        openssh.authorizedKeys.keyFiles = [./remotebuild.pub];
      };

      users.groups.remotebuild = {};
      nix.settings.trusted-users = ["remotebuild"];
    };
  };
}

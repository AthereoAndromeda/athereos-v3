{lib, ...}: {
  den.schema.user.includes = [
    ({ssh-keys, ...}: {user.openssh.authorizedKeys.keyFiles = ssh-keys;})

    {
      homeManager.options = {
        gitEmail = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          description = "Email address to use for Git";
          default = null;
        };

        gitName = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          description = "Name to use for Git";
          default = null;
        };
      };
    }
  ];
}

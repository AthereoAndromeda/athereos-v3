{...}: {
  den.schema.user.includes = [
    ({ssh-keys, ...}: {user.openssh.authorizedKeys.keyFiles = ssh-keys;})
  ];
}

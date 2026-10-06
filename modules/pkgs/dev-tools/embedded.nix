{den, ...}: {
  dev-tools.embedded = {
    includes = [den.aspects.udev.probe-rs];
    os.users.groups.plugdev.gid = 601;
    provides.to-users.user.extraGroups = ["plugdev"];
  };
}

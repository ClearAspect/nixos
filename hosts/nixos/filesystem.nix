{
  config,
  pkgs,
  ...
}: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e7bdb2d1-59b6-48e0-bd18-84057579384a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B8C1-84AB";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/0a5f0cee-33f9-4f04-8b92-59e2f4bdd1c1";}
  ];
}

{
  agenix,
  ghostty,
  distro-grub-themes,
  config,
  pkgs,
  ...
}: {
  # System Packages
  environment.systemPackages = with pkgs;
    [
      ghostty.packages.x86_64-linux.default
      agenix.packages."${pkgs.system}".default
      lshw
      vim
      coreutils
      pciutils
      alsa-utils
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum
    ]
    ++ (import ../../modules/nixos/packages.nix {inherit pkgs;});
}

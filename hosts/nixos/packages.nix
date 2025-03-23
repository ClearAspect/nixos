{
  config,
  pkgs,
  agenix,
  ghostty,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ghostty.packages.x86_64-linux.default
    agenix.packages."${pkgs.system}".default
    lshw
    vim
    coreutils
    pciutils
    alsa-utils
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];
}

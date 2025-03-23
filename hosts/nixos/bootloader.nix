{
  config,
  pkgs,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = false;
        configurationLimit = 4;
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 8;
        gfxmodeEfi = "3840x2160";
        gfxpayloadEfi = "keep";
        # font = pkgs.sf-pro;
        # fontSize = 16;
      };
      efi.canTouchEfiVariables = true;
      timeout = 30;
    };
    plymouth.enable = true;

    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    initrd.kernelModules = [
      "nvidia"
    ];

    kernelParams = ["video=3840x2160@60"];

    kernelPackages = pkgs.linuxPackages_6_12;
    # extraModulePackages = [config.boot.kernelPackages.nvidia_x11_latest]; # _beta
    extraModulePackages = [config.boot.kernelPackages.nvidiaPackages.latest];

    kernelModules = ["uinput"];
    # kernelParams = [
    #   "nvidia-drm.modeset=1"
    #   "nvidia-drm.fbdev=1"
    #   "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    #   "nvidia.NVreg_EnableGpuFirmware=0"
    # ];
  };

  # Enable grub theme
  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
}

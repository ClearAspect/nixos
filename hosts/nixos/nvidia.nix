{
  config,
  pkgs,
  ...
}: {
  # Setup Nvidia Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # prime = {
    #   # sync.enable = true;
    #   nvidiaBusId = "PCI:1:0:0";
    # };
  };

  services.xserver.videoDrivers = ["nvidia"];

  services.xserver.xrandrHeads = [
    {
      output = "HDMI-A-1";
      primary = false;
      monitorConfig = ''
        Option "LeftOf" "DP-2"
        Option "Rotate" "Right"
        Option "PreferredMode" "1920x1080"
        Option "Enabled" "false"
      '';
    }
    {
      output = "DP-2";
      primary = true;
      monitorConfig = ''
        Option "Below" "DP-1"
        Option "RightOf" "HDMI-A-1"
        Option "PreferredMode" "3160x2160"
      '';
    }
    {
      output = "DP-1";
      primary = false;
      monitorConfig = ''
        Option "Above" "DP-2"
        Option "PreferredMode" "3160x2160"
      '';
    }
  ];
}

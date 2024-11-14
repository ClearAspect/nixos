{
  agenix,
  ghostty,
  config,
  lib,
  inputs,
  pkgs,
  libs,
  ...
}: let
  user = "roanm";
  keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwqozRS0wVI+dZj3lUyiRzxaKK3hPKWDcwlMdjI1gz9 roanmason@live.ca"];
in {
  imports = [
    ../../modules/nixos/disk-config.nix
    ../../modules/shared
    agenix.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 4;
      # };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 4;

        catppuccin.enable = true;
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
    #initrd.kernelModules = [
    # "nvidia"
    # "nvidia_modeset"
    # "nvidia_uvm"
    # "nvidia_drm"
    # ];

    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11_beta];
    # kernelPatches = [
    #   {
    #     name = "crashdump-config";
    #     patch = null;
    #     extraConfig = ''
    #       DRM_SIMPLEDRM n
    #       FB_SIMPLE n
    #     '';
    #   }
    # ];

    kernelModules = ["uinput"];
    kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia.NVreg_EnableGpuFirmware=0"
    ];
  };

  # Setup Nvidia Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services = {
    xserver = {
      enable = true;

      videoDrivers = ["nvidia"];

      # Uncomment for Nvidia GPU
      # This helps fix tearing of windows for Nvidia cards
      # screenSection = ''
      #   Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      #   Option       "AllowIndirectGLXProtocol" "off"
      #   Option       "TripleBuffer" "on"
      # '';

      # Turn Caps Lock into Ctrl
      xkb.layout = "us";
      # xkbOptions = "ctrl:nocaps";

      xrandrHeads = [
        {
          output = "DP-1";
          primary = true;
          monitorConfig = ''Option "Enable" "true"'';
        }
        {
          output = "HDMI-A-1";
          primary = false;
          monitorConfig = ''Option "Enable" "false"'';
        }
      ];
    };
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # prime = {
    #   # sync.enable = true;
    #   nvidiaBusId = "PCI:1:0:0";
    # };
  };

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    # useDHCP = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
    # interfaces."%INTERFACE%".useDHCP = true;
  };

  # Turn on flag for proprietary software
  nix = {
    nixPath = ["nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos"];
    settings = {
      allowed-users = ["${user}"];
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;

    # Needed for anything GTK related
    dconf.enable = true;

    # My shell
    # fish executed in bash if it is interactive shell
    # bash = {
    #   enable = true;
    #   interactiveShellInit = ''
    #     if [[ $(${pkgs.procps}/bin/ps -o ucomm | grep fish | sort | uniq) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    #     then
    #       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
    #       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    #     fi
    #   '';
    # };
    fish = {
      enable = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "macOS";
    HYPRCURSOR_SIZE = "24";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";

    NIKPKGS_ALLOW_UNFREE = "1";

    EDITOR = "nvim";
  };

  services = {
    # Better support for general peripherals
    libinput.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      catppuccin.enable = true;
      package = pkgs.kdePackages.sddm;
    };

    autorandr = {
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Let's be able to SSH into this machine
    openssh.enable = true;

    # Sync state between machines
    # syncthing = {
    #   enable = true;
    #   openDefaultPorts = true;
    #   dataDir = "/home/${user}/.local/share/syncthing";
    #   configDir = "/home/${user}/.config/syncthing";
    #   user = "${user}";
    #   group = "users";
    #   guiAddress = "127.0.0.1:8384";
    #   overrideFolders = true;
    #   overrideDevices = true;

    #   settings = {
    #     devices = {};
    #     options.globalAnnounceEnabled = false; # Only sync on LAN
    #   };
    # };

    # Enable CUPS to print documents
    printing.enable = true;
    printing.drivers = [pkgs.brlaser]; # Brother printer driver

    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  # Audio support
  hardware = {
    pulseaudio.enable = false;
  };

  # Users / Me

  users = {
    users = {
      ${user} = {
        home = "/home/roanm";
        createHome = true;
        isNormalUser = true;
        extraGroups = [
          "wheel" # Enable ‘sudo’ for the user.
          "docker"
        ];
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = keys;
      };
      root = {
        openssh.authorizedKeys.keys = keys;
      };
    };
  };

  # Don't require password for users in `wheel` group for these commands
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };

  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {fonts = ["CascadiaCode" "NerdFontsSymbolsOnly"];})
  ];

  environment.systemPackages = with pkgs; [
    ghostty.packages.x86_64-linux.default
    agenix.packages."${pkgs.system}".default # "x86_64-linux"
    lshw
    vim
    coreutils
    pciutils
    alsa-utils
  ];

  system.stateVersion = "21.05"; # Don't change this
}

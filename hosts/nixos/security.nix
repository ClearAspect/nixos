{
  config,
  pkgs,
  ...
}: {
  # Don't require password for users in `wheel` group for these commands
  security = {
    sudo = {
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

    pam = {
      u2f = {
        enable = true;
      };
      yubico = {
        enable = true;
        debug = false;
        mode = "challenge-response";
        id = ["30022250"];
      };
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
  };

  services.pcscd.enable = true; # Enable smartcard daemon for YubiKey
  services.udev.packages = [pkgs.yubikey-personalization]; # Use YubiKey udev rules for access permissions&#8203;:contentReference[oaicite:1]{index=1}

  # Yubico YubiKey Security Key
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Let gpg-agent provide SSH agent capabilities
    pinentryPackage = pkgs.pinentry-curses; # or another pinentry (gtk2/qt) for passphrase prompts
    settings = {
      default-cache-ttl = 3600; # cache PIN/passphrases for 1 hour (adjust as needed)
      max-cache-ttl = 7200; # absolute max cache time 2 hours
    };
  };

  programs.ssh.startAgent = false; # Do NOT start ssh-agent (we use gpg-agent instead)
}

{
  config,
  pkgs,
  ...
}: {
  # Yubico YubiKey Security Key
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  security.pam.enableSudoTouchIdAuth = true;

  # Yubico YubiKey Security Key
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Let gpg-agent provide SSH agent capabilities
    # pinentryPackage = pkgs.pinentry-curses; # or another pinentry (gtk2/qt) for passphrase prompts
    # settings = {
    #   default-cache-ttl = 3600; # cache PIN/passphrases for 1 hour (adjust as needed)
    #   max-cache-ttl = 7200; # absolute max cache time 2 hours
    #   ignore-cache-for-signing = false; # ensure signing uses the cache
    # };
  };
}

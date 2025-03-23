{
  config,
  pkgs,
  ...
}: {
  gpg = {
    enable = true;
    scdaemonSettings.disable-ccid = true; # use pcscd exclusively to talk to YubiKey
  };
}

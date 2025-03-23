{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "roanm";
in {
  ssh = {
    enable = true;
    includes = [
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    extraConfig = ''
      Host localhomeserver
      HostName 192.168.10.208
      User super
      Port 22

      Host remotehomeserver
      HostName 99.226.10.150
      User super
      Port 22

      Host roanmDesktop
      HostName 192.168.10.248
      User roanm
      Port 22
      ForwardAgent yes

      Host Roans-MacBook-Pro
      HostName 192.168.10.223
      user roanm
      ForwardAgent yes


      VisualHostKey=yes
    '';
  };
}

{
  config,
  pkgs,
  lib,
  inputs ? {},
  ...
}: let
  # Get all nix files in the current directory except default.nix
  files =
    lib.filterAttrs
    (n: v: n != "default.nix" && lib.hasSuffix ".nix" n)
    (builtins.readDir ./.);

  # Import all program configurations
  programs =
    lib.attrsets.mapAttrs'
    (name: _:
      lib.nameValuePair
      (lib.removeSuffix ".nix" name)
      (import ./${name} {inherit config pkgs lib inputs;}))
    files;
in
  # Merge all program configurations
  lib.attrsets.mergeAttrsList (builtins.attrValues programs)

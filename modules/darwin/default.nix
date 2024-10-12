{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = import ../lib/import-modules.nix {
    inherit config lib pkgs;
    modules = [ ./globals.nix ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = import ../lib/import-modules.nix {
    inherit config lib pkgs;
    modules = import [ ./globals.nix ];
  };
}

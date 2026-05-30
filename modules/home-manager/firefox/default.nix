{ catppuccinLib }:
{ lib, ... }:

let
  mkFirefoxModule =
    args:

    lib.modules.importApply ./mkFirefoxModule.nix (
      args
      // {
        inherit catppuccinLib;
      }
    );
in

{
  imports = map mkFirefoxModule [
    { name = "firefox"; }
    {
      name = "librewolf";
      prettyName = "LibreWolf"; # W in LibreWolf is uppercase
    }
    { name = "floorp"; }
  ];
}

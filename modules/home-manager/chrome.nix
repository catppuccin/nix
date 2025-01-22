{ catppuccinLib }:
{ config, lib, ... }:
let
  cfg = config.catppuccin;

  identifiers = {
    frappe = "olhelnoplefjdmncknfphenjclimckaf";
    latte = "jhjnalhegpceacdhbplhnakmkdliaddd";
    macchiato = "cmpdlhmnmjhihmcfnigoememnffkimlk";
    mocha = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
  };

  # Google Chrome is not supported since it does not support extensions
  # See nix-community/home-manager#1383 for more information.
  supportedBrowsers = [
    "brave"
    "chromium"
    "vivaldi"
  ];

  generateConfig =
    browser:
    lib.mkIf cfg.${browser}.enable {
      programs.${browser}.extensions = [ { id = identifiers.${cfg.${browser}.flavor}; } ];
    };
in
{
  options.catppuccin = lib.genAttrs supportedBrowsers (
    name: catppuccinLib.mkCatppuccinOption { inherit name; }
  );

  config = lib.mkMerge (map generateConfig supportedBrowsers);
}

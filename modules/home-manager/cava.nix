{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.cava;
  flavor = "${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
in

{
  options.catppuccin.cava = catppuccinLib.mkCatppuccinOption { name = "cava"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "programs"
        "cava"
        "catppuccin"
      ];
      to = "cava";
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "programs"
          "cava"
          "catppuccin"
          "transparent"
        ]
        [
          "catppuccin"
          "cava"
          "transparent"
        ]
      )
    ];

  config = lib.mkIf cfg.enable {
    programs.cava = {
      settings = catppuccinLib.importINIRaw (sources.cava + "/${flavor}.cava");
    };
  };
}

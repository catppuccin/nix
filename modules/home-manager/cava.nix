{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.cava;
  enable = cfg.enable && config.programs.cava.enable;
  flavor = "${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
in
{
  options.catppuccin.cava = lib.ctp.mkCatppuccinOpt { name = "cava"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  imports =
    (lib.ctp.mkRenamedCatppuccinOpts {
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

  config.programs.cava = lib.mkIf enable {
    settings = lib.ctp.fromINIRaw (sources.cava + "/themes/${flavor}.cava");
  };
}

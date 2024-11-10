{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.aerc;
  enable = cfg.enable && config.programs.aerc.enable;
  themeName = "catppuccin-${cfg.flavor}";
in
{
  options.catppuccin.aerc = lib.ctp.mkCatppuccinOpt { name = "aerc"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "aerc"
      "catppuccin"
    ];
    to = "aerc";
  };

  config = lib.mkIf enable {
    programs.aerc = {
      stylesets.${themeName} = builtins.readFile "${sources.aerc}/dist/${themeName}";
      extraConfig = {
        ui = {
          styleset-name = themeName;
          border-char-vertical = "│";
          border-char-horizontal = "─";
        };
      };
    };
  };
}

{ config
, pkgs
, lib
, sources
, ...
}:
let
  cfg = config.programs.zathura.catppuccin;
  enable = cfg.enable && config.programs.zathura.enable;
  themeFile = sources.zathura + /src/catppuccin-${cfg.flavour};
in
{
  options.programs.zathura.catppuccin =
    lib.ctp.mkCatppuccinOpt "zathura";

  config.programs.zathura.options = lib.mkIf enable
    (lib.ctp.fromINI
      (pkgs.runCommand "catppuccin-zathura-theme" { } ''
        ${pkgs.gawk}/bin/awk '/.+/ { printf "%s=%s\n", $2, $3 }' ${themeFile} > $out
      ''));
}

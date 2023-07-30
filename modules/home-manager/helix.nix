{ config
, pkgs
, lib
, inputs
, ...
}:
let
  cfg = config.programs.helix.catppuccin;
  enable = cfg.enable && config.programs.helix.enable;
in
{
  options.programs.helix.catppuccin = with lib;
    ctp.mkCatppuccinOpt "helix" config
    // {
      useItalics = mkEnableOption "Italics in Catppuccin theme for Helix";
    };

  config.programs.helix =
    let
      subdir =
        if cfg.useItalics
        then "default"
        else "no_italics";
    in
    lib.mkIf enable {
      settings = {
        theme = "catppuccin-${cfg.flavour}";
        editor.color-modes = lib.mkDefault true;
      };

      themes."catppuccin-${cfg.flavour}" = builtins.fromTOML
        "${inputs.helix}/themes/${subdir}/catppuccin_${cfg.flavour}.toml";
    };
}

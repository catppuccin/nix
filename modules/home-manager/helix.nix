{ config
, pkgs
, lib
, ...
}:
let
  inherit (builtins) fromTOML readFile;
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

      themes."catppuccin-${cfg.flavour}" = fromTOML (readFile (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "helix";
          rev = "5677c16dc95297a804caea9161072ff174018fdd";
          sha256 = "sha256-aa8KZ7/1TXcBqaV/TYOZ8rpusOf5QeQ9i2Upnncbziw=";
        }
      + "/themes/${subdir}/catppuccin_${cfg.flavour}.toml"));
    };
}

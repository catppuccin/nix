{ config, pkgs, lib, ... }:
let cfg = config.programs.helix.catppuccin;
in {
  options.programs.helix.catppuccin = with lib;
    ctp.mkCatppuccinOpt "helix" config // {
      useItalics = mkEnableOption "Italics in Catppuccin theme for Helix";
    };

  config.programs.helix = with builtins;
    with lib;
    with pkgs;
    let subdir = if cfg.useItalics then "default" else "no_italics";
    in mkIf cfg.enable {
      settings = {
        theme = "catppuccin-${cfg.flavour}";
        editor.color-modes = mkDefault true;
      };
      themes."catppuccin-${cfg.flavour}" = fromTOML (readFile (fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "helix";
          rev = "5677c16dc95297a804caea9161072ff174018fdd";
          sha256 = "sha256-aa8KZ7/1TXcBqaV/TYOZ8rpusOf5QeQ9i2Upnncbziw=";
        } + "/themes/${subdir}/catppuccin_${cfg.flavour}.toml"));
    };
}

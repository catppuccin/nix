{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.fuzzel;
in
{
  options.catppuccin.fuzzel = lib.ctp.mkCatppuccinOpt { name = "fuzzel"; } // {
    accent = lib.ctp.mkAccentOpt "fuzzel";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "fuzzel"
      "catppuccin"
    ];
    to = "fuzzel";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.settings.main.include =
      sources.fuzzel + "/themes/catppuccin-${cfg.flavor}/${cfg.accent}.ini";
  };
}

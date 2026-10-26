{ catppuccinLib }:
{
  config,
  lib,
  options,
  ...
}:

let
  cfg = config.catppuccin.opencode;
  enable = config.catppuccin.enable && cfg.enable && config.programs.opencode.enable;
  opencodeCfg = config.programs.opencode;
  packageVersion = if opencodeCfg.package != null then lib.getVersion opencodeCfg.package else null;
  isV2 = packageVersion == null || packageVersion == "" || lib.versionAtLeast packageVersion "2.0.0";

  # Map Catppuccin flavors to OpenCode's available theme names
  # OpenCode provides: "catppuccin", "catppuccin-frappe", "catppuccin-macchiato"
  themeName =
    if cfg.flavor == "frappe" then
      "catppuccin-frappe"
    else if cfg.flavor == "macchiato" then
      "catppuccin-macchiato"
    else
      "catppuccin"; # Default for mocha and latte
in

{
  options.catppuccin.opencode = catppuccinLib.mkCatppuccinOption { name = "opencode"; };

  config = lib.mkIf enable (
    {
      programs.opencode.tui = lib.mkIf (!isV2) { theme = themeName; };
    }
    // lib.optionalAttrs (options.programs.opencode ? cli) {
      programs.opencode.cli = lib.mkIf isV2 { theme.name = themeName; };
    }
  );
}

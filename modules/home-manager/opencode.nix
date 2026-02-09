{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.opencode;
  enable = config.catppuccin._enable && cfg.enable && config.programs.opencode.enable;

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
  config = lib.mkIf enable {
    programs.opencode.settings = {
      theme = themeName;
    };
  };
}

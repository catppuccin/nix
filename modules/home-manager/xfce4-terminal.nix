{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.xfce4-terminal;
  enable = cfg.enable;
  themeName = "catppuccin-${cfg.flavor}";

  # required until merged https://github.com/nix-community/home-manager/pull/7282
  pascalToKebabCase = string: lib.removePrefix "-" (lib.hm.strings.toKebabCase string);

  normalizeValue =
    value:
    if value == "TRUE" then
      true
    else if value == "FALSE" then
      false
    else
      value;

  themeFile = sources.xfce4-terminal + "/${themeName}.theme";

  themeProperties = builtins.removeAttrs (catppuccinLib.importINI themeFile).Scheme [ "Name" ];

  terminalSettings = lib.listToAttrs (
    lib.mapAttrsToList (name: value: {
      name = pascalToKebabCase name;
      value = normalizeValue value;
    }) themeProperties
  );
in
{
  options.catppuccin.xfce4-terminal = catppuccinLib.mkCatppuccinOption {
    name = "xfce4-terminal";
    accentSupport = false;
  };

  config = lib.mkIf enable {
    xfconf.settings = {
      xfce4-terminal = terminalSettings;
    };
  };
}

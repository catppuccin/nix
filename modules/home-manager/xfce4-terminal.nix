{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.xfce4-terminal;
  enable = cfg.enable;
  themeName = "catppuccin-${cfg.flavor}";

  toCaseWithSeparator =
    separator: string:
    let
      splitByWords = builtins.split "([A-Z])";
      processWord = s: if lib.isString s then s else separator + lib.toLower (lib.elemAt s 0);
      words = splitByWords string;
      converted = lib.concatStrings (map processWord words);
    in
    lib.removePrefix separator converted;

  toKebabCase = toCaseWithSeparator "-";

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
      name = toKebabCase name;
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

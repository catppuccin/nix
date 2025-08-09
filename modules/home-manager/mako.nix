{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.mako;
in

{
  options.catppuccin.mako = catppuccinLib.mkCatppuccinOption {
    name = "mako";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "services"
      "mako"
      "catppuccin"
    ];
    to = "mako";
    accentSupport = true;
  };

  config.services.mako = lib.mkIf cfg.enable ({
    settings.include =
      sources.mako + "/catppuccin-${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}";
  });
}

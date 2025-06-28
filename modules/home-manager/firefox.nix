{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (lib)
    mapAttrs
    mapAttrsToList
    listToAttrs
    isBool
    mkIf
    mkOption
    types
    ;

  inherit (config.catppuccin) sources;
  cfg = config.catppuccin;

  supportedBrowsers = {
    firefox = "Firefox";
    librewolf = "LibreWolf";
    floorp = "Floorp";
  };

  stylusExtensionId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";

  castUserstyleSettings =
    settings: mapAttrs (_k: v: if isBool v then (if v then 1 else 0) else v) settings;

  generateUserstyleSettings =
    userstylesOptions:
    builtins.fromJSON (
      builtins.readFile (
        (sources.userstyles.override {
          inherit userstylesOptions;
        })
        + /share/storage.js
      )
    );
in
{
  options.catppuccin = mapAttrs (browser: prettyName: {
    profiles = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            userstyles =
              catppuccinLib.mkCatppuccinOption {
                name = "${prettyName} Userstyles";
                # Must be explicitly enabled because:
                # - Stylus must be installed (doesn't make sense to do it within this module), and
                # - Profile to install to must be manually specified, so there needs to be manual config anyway
                useGlobalEnable = false;
                accentSupport = true;
              }
              // {
                force = mkOption {
                  type = types.bool;
                  default = false;
                  description = "Forcibly override any existing configuration for Stylus.";
                  example = true;
                };

                settings = mkOption {
                  type = types.attrsOf (
                    types.attrsOf (
                      types.oneOf [
                        types.str
                        types.int
                        types.bool
                      ]
                    )
                  );
                  default = { };
                  description = "Settings for each userstyle.";
                  example = {
                    youtube = {
                      lightFlavor = "latte";
                      darkFlavor = "mocha";
                      accentColor = "mauve";

                      logo = true;
                      oled = false;
                      sponsorBlock = true;
                    };

                    github.enable = false;
                  };
                };
              };
          };
        }
      );
      default = { };
      description = "Catppuccin settings for ${prettyName} profiles.";
    };
  }) supportedBrowsers;

  config = {
    programs = mapAttrs (browser: _prettyName: {
      profiles = mapAttrs (profile: profileCfg: {
        extensions.settings.${stylusExtensionId} = mkIf profileCfg.userstyles.enable {
          inherit (profileCfg.userstyles) force;
          settings = generateUserstyleSettings (
            {
              global = {
                lightFlavor = cfg.flavor;
                darkFlavor = cfg.flavor;
                accentColor = cfg.accent;
              };
            }
            // (listToAttrs (
              mapAttrsToList (name: value: {
                name = "Userstyle ${name} Catppuccin";
                value = castUserstyleSettings value;
              }) profileCfg.userstyles.settings
            ))
          );
        };
      }) cfg.${browser}.profiles;
    }) supportedBrowsers;
  };
}

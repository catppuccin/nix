{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (lib)
    importJSON
    mapAttrs
    filterAttrs
    toSentenceCase
    mkIf
    mkOption
    getAttrFromPath
    setAttrByPath
    types
    ;

  inherit (config.catppuccin) sources;
  themes = importJSON "${sources.firefox}/themes.json";

  mkFirefoxModule =
    {
      name,
      prettyName ? toSentenceCase name,
      hmModulePath ? [
        "programs"
        name
      ],
    }:
    let
      modulePath = [
        "catppuccin"
        name
      ];
      cfg = getAttrFromPath modulePath config;
    in
    {
      options = setAttrByPath modulePath {
        profiles = mkOption {
          type = types.attrsOf (
            types.submodule {
              options =
                catppuccinLib.mkCatppuccinOption {
                  inherit name;
                  accentSupport = true;
                }
                // {
                  force = mkOption {
                    type = types.bool;
                    default = false;
                    description = "Forcibly override any existing configuration for Firefox Color.";
                    example = true;
                  };
                };
            }
          );

          # by default we list the `default` profile to enable the theme with just the `.enable` option
          default = {
            default = { };
          };

          description = "Catppuccin settings for ${prettyName} profiles.";
        };
      };

      config =
        let
          # guarding against creating any configuration when no profiles are enabled
          activeProfiles = filterAttrs (_: profile: profile.enable) cfg.profiles;
        in
        mkIf (activeProfiles != { }) (
          setAttrByPath hmModulePath {
            profiles = mapAttrs (_: profile: {
              extensions = {
                settings."FirefoxColor@mozilla.com" = {
                  inherit (profile) force;
                  settings = {
                    firstRunDone = true;
                    theme = themes.${profile.flavor}.${profile.accent};
                  };
                };
              };
            }) activeProfiles;
          }
        );
    };
in
{
  imports = map mkFirefoxModule [
    { name = "firefox"; }
    {
      name = "librewolf";
      prettyName = "LibreWolf"; # W in LibreWolf is uppercase
    }
    { name = "floorp"; }
  ];
}

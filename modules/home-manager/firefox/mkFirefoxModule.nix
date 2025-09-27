{
  catppuccinLib,

  name,
  prettyName ? null,
  hmModulePath ? [
    "programs"
    name
  ],
}:
{ config, lib, ... }:

let
  inherit (lib)
    attrNames
    const
    foldl'
    genAttrs
    hasAttr
    importJSON
    toSentenceCase
    optional
    mkIf
    mkOption
    getAttrFromPath
    setAttrByPath
    types
    ;

  getAttrStringFromPath = lib.concatStringsSep ".";

  inherit (config.catppuccin) sources;
  themes = importJSON "${sources.firefox}/themes.json";

  cfg = getAttrFromPath modulePath config;
  firefoxCfg = getAttrFromPath hmModulePath config;

  modulePath = [
    "catppuccin"
    name
  ];
  prettyName' = if prettyName == null then toSentenceCase name else prettyName;

  optionsModule = {
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
  };

  catppuccinProfilesSubmodule = {
    imports = [ optionsModule ];

    config = lib.mapAttrs (lib.const lib.mkDefault) {
      inherit (cfg)
        enable
        flavor
        accent
        force
        ;
    };
  };

  catppuccinOptions = setAttrByPath modulePath (
    lib.mkOption {
      type = lib.types.submodule {
        imports = [ optionsModule ];

        options = {
          profiles = mkOption {
            type = types.attrsOf (types.submodule catppuccinProfilesSubmodule);
            default = genAttrs (attrNames firefoxCfg.profiles) (const { });
            defaultText = "<profiles declared in `${getAttrStringFromPath hmModulePath}.profiles`>";
            description = "Catppuccin settings for ${prettyName'} profiles.";
          };
        };
      };
      default = { };
      description = "Catppuccin settings for ${prettyName'}.";
    }
  );

  firefoxProfilesSubmodule =
    { name, ... }:

    let
      profile = cfg.profiles.${name} or { enable = false; };
    in

    {
      config = mkIf profile.enable {
        extensions = {
          settings."FirefoxColor@mozilla.com" = {
            inherit (profile) force;
            settings = {
              firstRunDone = true;
              theme = themes.${profile.flavor}.${profile.accent};
            };
          };
        };
      };
    };

  homeOptions = setAttrByPath hmModulePath {
    profiles = mkOption {
      type = types.attrsOf (types.submodule firefoxProfilesSubmodule);
    };
  };
in

{
  options = catppuccinOptions // homeOptions;

  config = {
    warnings = foldl' (
      acc: name:
      acc
      ++
        optional (!(hasAttr name firefoxCfg.profiles))
          "${prettyName'} profile '${name}' is defined in '${getAttrStringFromPath modulePath}', but not '${getAttrStringFromPath hmModulePath}'. This will have no effect."
    ) [ ] (attrNames cfg.profiles);
  };
}

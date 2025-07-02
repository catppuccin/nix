{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (lib)
    attrNames
    foldl'
    hasAttr
    importJSON
    mapAttrs'
    toSentenceCase
    mapAttrs
    mkIf
    mkOption
    optional
    getAttrFromPath
    setAttrByPath
    types
    ;

  inherit (config.catppuccin) sources;
  themes = importJSON "${sources.firefox}/themes.json";

  stylusExtensionId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";

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

      getAttrStringFromPath = lib.concatStringsSep ".";

      cfg = getAttrFromPath modulePath config;
      firefoxCfg = getAttrFromPath hmModulePath config;

      mkThemeOptions =
        {
          name,
          forceDefault,
          enableDefault,
        }:
        catppuccinLib.mkCatppuccinOption (
          {
            inherit name;
            accentSupport = true;
          }
          // (lib.optionalAttrs (enableDefault != null) {
            default = enableDefault;
          })
        )
        // {
          force = mkOption {
            type = types.bool;
            default = forceDefault;
            description = "Forcibly override any existing configuration for ${name}.";
            example = true;
          };
        };

      mkBrowserOptions =
        {
          isProfile ? false,
        }:
        mkThemeOptions {
          name = "Firefox Color";
          forceDefault = if isProfile then cfg.force else false;
          enableDefault = if isProfile then cfg.enable else null;
        }
        // {
          userstyles =
            mkThemeOptions {
              name = "Stylus";
              forceDefault = if isProfile then cfg.userstyles.force else false;
              enableDefault = if isProfile then cfg.userstyles.enable else null;
            }
            // {
              settings = mkOption {
                type = types.attrsOf (
                  types.submodule (
                    { name, ... }:
                    {
                      options = {
                        # we use mkOption instead of mkEnable option to default true
                        enable = mkOption {
                          type = types.bool;
                          default = true;
                          example = false;
                          description = "Whether to enable ${name} Catppuccin userstyle";
                        };

                        # Since applying settings through home-manager makes the storage.js file read only,
                        # build-stylus-settings removes the ability to configure userstyles through the stylus extension,
                        # instead settings are defined here & are baked into the userstyles
                        settings = mkOption {
                          type = types.attrsOf (
                            types.oneOf [
                              types.str
                              types.int
                              types.bool
                            ]
                          );
                          default = { };
                          description = "Userstyle setting overrides";
                          example = lib.literalExample ''
                            {
                              lightFlavor = "latte";
                              darkFlavor = "mocha";
                              accentColor = "mauve";
                              logo = true;
                              oled = false;
                              sponsorBlock = true;
                            };
                          '';
                        };

                        # From what I can tell, this has no function with Catppuccin userstyles
                        # It is probably better not to include this option, to reduce confusion
                        # inclusions = mkOption {
                        #   type = types.listOf types.str;
                        #   default = [];
                        #   description = "Custom included sites";
                        #   example = "*://www.aaa.com/*";
                        # };

                        exclusions = mkOption {
                          type = types.listOf types.str;
                          default = [ ];
                          description = "Custom excluded sites";
                          example = "*://www.aaa.com/*";
                        };
                      };
                    }
                  )
                );
                default = { };
                description = "Settings for Catppuccin userstyles";
              };
            };
        };
    in
    {
      options =
        (setAttrByPath modulePath (
          (mkBrowserOptions { })
          // {
            profiles = mkOption {
              type = types.attrsOf (
                types.submodule {
                  options = mkBrowserOptions { isProfile = true; };
                  config = {
                    flavor = lib.mkDefault cfg.flavor;
                    accent = lib.mkDefault cfg.accent;
                  };
                }
              );
              default = mapAttrs (_: _: { }) firefoxCfg.profiles;
              defaultText = "<profiles declared in `${getAttrStringFromPath hmModulePath}.profiles`>";
              description = "Catppuccin settings for ${prettyName} profiles.";
            };
          }
        ))
        # home-manager browser config
        // (setAttrByPath hmModulePath {
          profiles = mkOption {
            type = types.attrsOf (
              types.submodule (
                { name, ... }:
                let
                  profile = cfg.profiles.${name} or { enable = false; };
                in
                {
                  config.extensions.settings = {
                    "FirefoxColor@mozilla.com" = mkIf profile.enable {
                      inherit (profile) force;
                      settings = {
                        firstRunDone = true;
                        theme = themes.${profile.flavor}.${profile.accent};
                      };
                    };

                    ${stylusExtensionId} = mkIf profile.userstyles.enable {
                      inherit (profile.userstyles) force;
                      settings =
                        let
                          userstylesConfig = {
                            # default settings applied to all userstyles
                            defaultSettings = {
                              lightFlavor = profile.userstyles.flavor;
                              darkFlavor = profile.userstyles.flavor;
                              accentColor = profile.userstyles.accent;
                            };

                            # settings applied per userstyle
                            # these take priority over global settings
                            userstyles = mapAttrs' (name: value: {
                              name = "${name} catppuccin";
                              value = { inherit (value) enable settings exclusions; };
                            }) profile.userstyles.settings;
                          };

                          settingsPackage = sources.userstyles.override { inherit userstylesConfig; };
                        in
                        lib.importJSON "${settingsPackage}/share/storage.js";
                    };
                  };
                }
              )
            );
          };
        });

      config = {
        warnings = foldl' (
          acc: name:
          acc
          ++
            optional (!(hasAttr name firefoxCfg.profiles))
              "${prettyName} profile '${name}' is defined in '${getAttrStringFromPath modulePath}', but not '${getAttrStringFromPath hmModulePath}'. This will have no effect."
        ) [ ] (attrNames cfg.profiles);
      };
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

{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (lib)
    importJSON
    mapAttrs
    mapAttrs'
    toSentenceCase
    mkIf
    mkOption
    mkEnableOption
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
                  force = mkEnableOption "forcibly overriding any existing configuration for Firefox Color.";

                  userstyles =
                    catppuccinLib.mkCatppuccinOption {
                      name = "${name} userstyles";
                      accentSupport = true;
                    }
                    // {
                      force = mkEnableOption "forcibly overriding any existing configuration for Stylus.";

                      # Settings is nested twice here, much like how home-manager does it
                      # programs.firefox.profiles.<name>.extensions.settings.<name>.settings
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
            }
          );
          default = { };
          description = "Catppuccin settings for ${prettyName} profiles.";
        };
      };

      config = setAttrByPath hmModulePath {
        profiles = mapAttrs (_: profile: {
          extensions = {
            settings."FirefoxColor@mozilla.com" = mkIf profile.enable {
              inherit (profile) force;
              settings = {
                firstRunDone = true;
                theme = themes.${profile.flavor}.${profile.accent};
              };
            };

            settings.${stylusExtensionId} = mkIf profile.userstyles.enable {
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
        }) cfg.profiles;
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

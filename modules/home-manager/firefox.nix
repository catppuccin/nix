
{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.firefox;
  enable = cfg.enable && config.programs.firefox.enable;
in

{
  options.catppuccin.firefox =
    catppuccinLib.mkCatppuccinOption {
      name = "firefox";
      accentSupport = true;
    }
    // {
      profile = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-${cfg.flavor}-${cfg.accent}";
        description = "The profile name";
      };
    };

  config = lib.mkIf enable {
    programs.firefox = {
      profiles."${cfg.profile}".extensions = [
        (pkgs.runCommandLocal "catppuccin-${cfg.flavor}-${cfg.accent}.firefox.theme"
          {
            buildInputs = [ sources.firefox ];
            nativeBuildInputs = with pkgs; [
              jq
              unzip
            ];
          }
          ''
            xpi=${sources.firefox}/catppuccin_${cfg.flavor}_${cfg.accent}.xpi
            extId=$(unzip -qc $xpi manifest.json | jq -r .browser_specific_settings.gecko.id)
            # The extensions path shared by all profiles.
            extensionPath="extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            install -Dv $xpi $out/share/mozilla/$extensionPath/$extId.xpi
          ''
        )
      ];
    };
  };
}
